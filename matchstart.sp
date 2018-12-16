#include <sourcemod>

public Plugin myinfo = {
    name="Tell when match started..",
    author="Olle Thunberg",
	description = "It tells in chat who got killed",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}
ConVar sm_enabled = null;

public void OnPluginStart(){
    //WHEN THE PLUGIN STARTS
    
    HookEvent("round_start", printInChat, EventHookMode_PostNoCopy);
    sm_enabled = CreateConVar("sm_enabled", "1", "1 = ENABLED, 0 = DISABLED");
	AutoExecConfig(true, "sm_enabled");
}

public void printInChat(Event event, const char[] name, bool dontBroadcast){

    int enabledOrNot = GetConVarInt(sm_enabled);

    if(enabledOrNot != 0){
        ServerCommand("say New round.");
    }else {
        ServerCommand("say Round plugin not working.")
    }

}