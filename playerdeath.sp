#include <sourcemod>

public Plugin myinfo = {
    name="Write in chat who got killed",
    author="Olle Thunberg",
	description = "It tells in chat who got killed",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}
ConVar sm_writeInChat = null;

public void OnPluginStart(){

	HookEvent("player_death", Event_PlayerDeath);
    sm_writeInChat = CreateConVar("sm_writeInChat", "1", "If the plugin will write the info inside the chat. 1 = YES, 0 = NO");
	AutoExecConfig(true, "sm_writeInChat");

}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast){
    int dead_id = event.GetInt("userid");
    int attacker_id = event.GetInt("attacker");

    int dead = GetClientOfUserId(dead_id);
    int attacker = GetClientOfUserId(attacker_id);

    char name[MAX_NAME_LENGTH];

    GetClientName(attacker, name, sizeof(name));
    int displayOrNot = GetConVarInt(sm_writeInChat);
    if(displayOrNot == 1){
        ServerCommand("say %s got a kill!", attacker);
    } else {
        PrintToConsole(attacker, "Please set displayOrNot TO 1");
    }
}
