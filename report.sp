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
	RegConsoleCmd("sql_test", sql_test);
	RegConsoleCmd("sm_report", sm_report);

}
public Action:sm_report(int client, int args){
	
	char reported[128];



	GetCmdArg(1, reported, sizeof(reported));

	int target = FindTarget(client, reported);
	if(client){
		if(target == -1){
			ReplyToCommand(client, "Couldn't the user. Are you sure that you typed correctly?");
			return Plugin_Handled;
		}else {
			ReplyToCommand(client, "Reported the user!");
			    new String:error[255];
				new Handle:db = SQL_DefConnect(error, sizeof(error));
				if(db == null){
					PrintToServer("Failed to connect to database: %s", error);
					return Plugin_Handled;
				}else {
					// FIXA MER HÄR IMORGON
					// FIXA MER HÄR IMORGON
					// FIXA MER HÄR IMORGON
					new Handle:query = SQL_Query(db, "DELETE FROM users WHERE id = 5");
				}
		}
		
	}
	return Plugin_Handled;
	
}
public Action:sql_test(int client, int args){
    
    new String:error[255];

	new Handle:db = SQL_DefConnect(error, sizeof(error));
	if (db == null)
	{
		PrintToServer("Failed to connect: %s", error);
	    return Plugin_Handled;
	}else {
        new Handle:query = SQL_Query(db, "DELETE FROM users WHERE id = 5");
        if(query == null){
		    SQL_GetError(db, error, sizeof(error))
            PrintToServer("Failed to query %s", error);
            
        }else {
			PrintToServer("Success");
		}
    }
    
    return Plugin_Handled;

}
