
//include headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;
	
	/*// rg70hz  headers
	#include rg70hz\_menu_funcs;
	#include rg70hz\_main;
	#include rg70hz\_hud_util_funcs;
	#include rg70hz\_hud_funcs;*/

// game menu functions

test()
{
	self iPrintlnBold("Cursor Position: " + self.cursPos);
	//
}

ShowGUID(player)
{
		self iPrintLnBold(player);
	//foreach(player in level.players)
	//{
		//self iPrintLnBold("^:GUID: ^1" + player getGuid());
	//}
}

Vis(vis)
{
	self VisionSetNakedForPlayer( vis, 0);
	self iPrintln("^1Vision "+vis+" ^2[SET]^7");
}

killPlayer(player)
{

	player suicide();
	self iPrintln("^1Killed ^7" + player);

}

kickPlayer(player)
{
    kick(player getEntityNumber(), "EXE_PLAYERKICKED");
    self iPrintln("^1Kicked ^7" + player);
}

BleedMoney(player)
{
	player endon ( "disconnect" );
	player endon ( "death" );
	self iPrintln(player + " ^:IS RICH!!!^7");
	while(1)
	{
		playFx( level._effect["money"], player getTagOrigin( "j_spine4" ) );
		wait 0.5;
	}
}

Teleport2()
{
	self beginLocationselection( "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
	self.selectingLocation = true;
	self waittill( "confirm_location", location, directionYaw );
	newLocation = PhysicsTrace(location + (0, 0, 1000), location - (0, 0, 1000));
	self SetPlayerAngles( directionYaw );
	self endLocationselection();
	self.selectingLocation = undefined;

	foreach( player in level.players ) 
	{
		if(player.name != self.name) 
		{
			player SetOrigin( newLocation );
		}
	} 
	self iPrintln ("Players ^2Teleported");
}

initTestClients(numberOfTestClients)
{
	for(i = 0; i < numberOfTestClients; i++)
	{
		wait 0.3;
		ent[i] = addtestclient();

		if (!isdefined(ent[i]))
		{
			wait 1;
			continue;
		}

		ent[i].pers["isBot"] = true;
		//ent[i] thread doPrestige();
		ent[i].pers["isBot"]=true;
		ent[i].GunGameKills=0;
		ent[i].OITMLives=3;
		ent[i].OITMAlive=true;
		ent[i] thread IIB();
		wait 0.1;
	}
}

IIB()
{
	while(!isdefined(self.pers["team"]))wait .05;
	self notify("menuresponse",game["menu_team"],"autoassign");
	wait 0.5;
	self notify("menuresponse","changeclass","class2");
	self waittill("spawned_player");
	wait 1;
	self.pers["isBot"]=true;
}
/*
doPrestige()
{
	if ( getDvar( "prestige" ) < "1" && getDvar( "experience" ) < "2516000" ) { // Doesn't keep reseting prestige and experience.
		self setPlayerData( "prestige", randomInt( 11 ) );
		self setPlayerData( "experience", 2516000 );
	}
}*/


/*SpawnBots(ib)
{
	for(i=0;i<ib;i++)
	{
		ent[i]=addtestclient();
		if(!isdefined(ent[i]))
		{
			wait 1;
			continue;
		}
		ent[i].pers["isBot"]=true;
		ent[i].GunGameKills=0;
		ent[i].OITMLives=3;
		ent[i].OITMAlive=true;
		ent[i] thread IIB();
		wait .3;
	}
}*/


/* ------------------------------------------------------ */
/* Credits
    Special Thanks to:

        ダフティ for assisting me

    Patch Developed by: Random Guy 70hz
        */
/* ------------------------------------------------------ */


