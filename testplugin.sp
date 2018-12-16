#include <sourcemod>
#include <sdktools>
//MAN KAN INTE HA KOD UTANMFÖR FUNKTIONER
public Plugin myinfo = {
    name="The first test plugin",
    author="Olle Thunberg",
	description = "My first plugin ever",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}
ConVar sm_slap_damage = null;

public void OnPluginStart(){
    // Register new commands

    RegAdminCmd("sm_testslap", Command_TestSlap, ADMFLAG_SLAY);
    PrintToServer("Plugin running...");   
    
    sm_slap_damage = CreateConVar("sm_slap_damage", "0", "Default slap damage");
	AutoExecConfig(true, "testslap");

}
//ADD COMMAND
public Action Command_TestSlap(int client, int args){

    //CLIENT ÄR SPELARE SOM SKICAKDE COMMANDET

    //TVÅ SAKER, PLAYER OCH DAMAGE ANTAR JAG
    char arg1[32], arg2[32];

    int damage = GetConVarInt(sm_slap_damage);
    GetCmdArg(1, arg1, sizeof(arg1));

    if(args >= 2){
        GetCmdArg(2, arg2, sizeof(arg2));
        damage = StringToInt(arg2);
    }
    int target = FindTarget(client, arg1);
    if(target == -1){
        return Plugin_Handled;
    }

    //SLAPPA SPELARE
    SlapPlayer(target, damage);

    //INFORMERA SPELAREN OM ATT HEN BLEV SLAPPAD.
    char name[MAX_NAME_LENGTH];

    GetClientName(target, name, sizeof(name));
    ReplyToCommand(client, "You slapped a guy! God says he deserved that!! (%s)", damage);

    return Plugin_Handled;
}
