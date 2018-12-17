#include <sourcemod>
#include <sdktools>

public Plugin myinfo = {
    name="ReportPlugin",
    author="Olle Thunberg",
	description = "Adds the reports to the database",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}

public void OnPluginStart(){
	RegConsoleCmd("sm_report", sm_report);

}
public Action:sm_report(int client, int args){
	
	char arg1[64];
	char query[255];
	char reported[64];

	GetCmdArg(1, arg1, sizeof(arg1));
	int reportedTarget = FindTarget(client, arg1);
	
	if(reportedTarget == -1){
		ReplyToCommand(client, "Couldn't find the user.. Did you type correct?");
		return Plugin_Handled;
	}
	// GET THE STEAMID OF THE USER WITH THE INDEX PROVIDED ABOVE
	GetClientAuthString(reportedTarget, reported, 255);

	// REPLACE SOME CHARACTERS
	ReplaceString(reported, 255, "_1:", "_0:");
	Format(query, sizeof(query), "UPDATE users SET reports = reports + 1 WHERE steamid = '%s'", reported);

	if(client){
			ReplyToCommand(client, "Reported the steamid: %s", reported);
			
			    new String:Error[255];
				new Handle:db = SQL_DefConnect(Error, sizeof(Error));
				if(db == null){
					PrintToServer("Failed to connect to database: %s", Error);
					return Plugin_Handled;
				}else {
					// FIXA MER HÄR IMORGON
					// FIXA MER HÄR IMORGON
					// FIXA MER HÄR IMORGON
					if(!SQL_FastQuery(db, query)){
						char error[255];
						SQL_GetError(db, error, sizeof(error));
						PrintToServer("Failed to query (error: %s)", error);
					}

				}
	}
	return Plugin_Handled;
	
}
