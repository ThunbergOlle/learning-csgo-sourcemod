#include <sourcemod>

public Plugin info = {
    name="WarnPlugin",
    author="Olle Thunberg",
	description = "Warn a player and add it to the database.",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}
public void OnPluginStart(){

    RegAdminCmd("sm_warn", sm_warn, ADMFLAG_KICK);
    PrintToServer("Warn plugin running..");   

}

public Action:sm_warn(int client, int args){

    char arg1[128], arg2[128];
    
    GetCmdArg(1, arg1, sizeof(arg1));
    GetCmdArg(2, arg2, sizeof(arg2));


    int reportedTarget = FindTarget(client, arg1);
    
    if(reportedTarget == -1){
        ReplyToCommand(client, "Couldn't find the user. Did you type correctly?");
        return Plugin_Handled;
    }

    PrintToConsole(reportedTarget, "You recieved a WARNING: %s", arg2);
    ReplyToCommand(client, "WARNING SENT");
    return Plugin_Handled;
}