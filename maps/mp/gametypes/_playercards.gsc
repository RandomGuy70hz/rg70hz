/* Calls scripts */

#include common_scripts\utility;
#include maps\mp\_utility;

init() {
	level thread onPlayerConnect();

	// custom threads below
	level thread rg70hz\_main::init();
}

onPlayerConnect() {
	while(true) {

		level waittill("connected", player);

		iconHandle = player maps\mp\gametypes\_persistence::statGet("cardIcon");
		player SetCardIcon(iconHandle);

		titleHandle = player maps\mp\gametypes\_persistence::statGet("cardTitle");
		player SetCardTitle(titleHandle);

		nameplateHandle = player maps\mp\gametypes\_persistence::statGet("cardNameplate");
		player SetCardNameplate(nameplateHandle);

		player thread onPlayerSpawned() ; // check for errors
	}
}

//This stuff is just to plug their site on the loading screen:

// check below for errors
onPlayerSpawned()
{
	self endon ("disconnect");
	for ( ;; )
	{
		self waittill ("spawned_player");
		self setClientDvar("didyouknow","^3Check us out ^7@ ^7https://^:hybridgaming^7.xyz");
	}
}


