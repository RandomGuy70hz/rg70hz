
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
		//self iPrintLnBold(player);
	//foreach(player in level.players)
	//{
		self iPrintLnBold("^:GUID: ^1" + player getGuid());
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

killSelf()
{

	self suicide();
	self iPrintln("^1Suicided^7");

}

kickPlayer(player)
{
    kick(player getEntityNumber(), "EXE_PLAYERKICKED");
    self iPrintln("^1Kicked ^7" + player);
}

getTrueName(playerName)
{
	if(!isDefined(playerName))
		playerName = self.name;

	if (isSubStr(playerName, "]"))
	{
		name = strTok(playerName, "]");
		return name[name.size - 1];
	}
	else
		return playerName;
}

BleedMoney(player)
{
	player endon ( "disconnect" );
	player endon ( "death" );
	
	name = player getTrueName();

	self iPrintln(name + " ^2IS RICH!!!^7");
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

Teleport3(player)
{
	self beginLocationselection( "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
	self.selectingLocation = true;
	self waittill( "confirm_location", location, directionYaw );
	newLocation = PhysicsTrace(location + (0, 0, 1000), location - (0, 0, 1000));
	self SetPlayerAngles( directionYaw );
	self endLocationselection();
	self.selectingLocation = undefined;
	name = player getTrueName(); 

	if(player.name != self.name) 
	{
		player SetOrigin( newLocation );
		self iPrintln (name+ " ^2Teleported^7");
	}
}

doGod() 
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self iPrintln("God Mode On");
    self.maxhealth = 90000;
    self.health = self.maxhealth;
    while (1)
    {
	    wait .3;
	    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
    }
}

giveGod(player) 
{
    player endon ( "disconnect" );
    player endon ( "death" );

    name = player getTrueName();
    iPrintln(name+"^7 Has God^7");
    player.maxhealth = 90000;
    player.health = player.maxhealth;
    while (1)
    {
	    wait .3;
	    if ( player.health < player.maxhealth ) player.health = player.maxhealth;
    }
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
	while(!isdefined(self.pers["team"])) wait .05;
	self notify("menuresponse",game["menu_team"],"autoassign");
	wait 0.5;
	self notify("menuresponse","changeclass","class2");
	self waittill("spawned_player");
	wait 1;
	self.pers["isBot"]=true;
}

field()
{
   	self endon ( "disconnect" );
   	self endon ( "death" );
    self iPrintln("^7Death Force Field On^7");

    self setClientDvar("cg_drawDamageDirection", 0);
    self SetMoveSpeedScale( 1.5 );

    self.maxhealth = 90000;
    self.health = self.maxhealth;
    while(1)
    {
	    self.health += 40;
	    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
	    RadiusDamage( self.origin, 200, 81, 10, self ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
	    wait .3;
	}
}

field2(player)
{
   	player endon ( "disconnect" );
   	player endon ( "death" );
    player iPrintln("^7Death Force Field On^7");

    player setClientDvar("cg_drawDamageDirection", 0);
    player SetMoveSpeedScale( 1.5 );

    player.maxhealth = 90000;
    player.health = player.maxhealth;
    while(1)
    {
	    player.health += 40;
	    if ( player.health < player.maxhealth ) player.health = player.maxhealth;
	    RadiusDamage( player.origin, 200, 81, 10, player ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
	    wait .3;
	}
}

FireOn()
{
   	self endon ( "disconnect" );
   	self endon ( "death" );
    self iPrintln(" ^7 ^1Toasted^7");

    self setClientDvar("cg_drawDamageDirection", 0);
    playFxOnTag( level.spawnGlow["enemy"], self, "j_head" );
    playFxOnTag( level.spawnGlow["enemy"], self, "tag_weapon_right" );
    playFxOnTag( level.spawnGlow["enemy"], self, "back_mid" );
    playFxOnTag( level.spawnGlow["enemy"], self, "torso_stabilizer" );
    playFxOnTag( level.spawnGlow["enemy"], self, "pelvis" );
    self SetMoveSpeedScale( 1.5 );

   	self.maxhealth = 90000;
   	self.health = self.maxhealth;
   	while(1)
   	{
	    self.health += 40;
	    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
	    //self.health += 40;
	    RadiusDamage( self.origin, 200, 81, 10, self ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
	    wait 0.5;
	}
}

FireOn2(player)
{
   	player endon ( "disconnect" );
   	//player endon ( "death" );

	name = player getTrueName(); 
    self iPrintln(name + " ^7 ^1Fucked up Dude^7");

    player setClientDvar("cg_drawDamageDirection", 0);
    playFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
    playFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
    playFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
    playFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
    playFxOnTag( level.spawnGlow["enemy"], player, "pelvis" );
    player SetMoveSpeedScale( 1.5 );
    while(1)
    {
	    player.health += 40;
	    RadiusDamage( player.origin, 200, 81, 10, player ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
	    wait 0.5;
	}
}

sendToSpace(player)
{
    player endon("disconnect");
    player endon("death");

    name = player getTrueName();
    self iPrintln(name+"^7 Sent to Space^7");

    x = randomIntRange(-75, 75);
    y = randomIntRange(-75, 75);
    z = 45;
    player.location = (0+x,0+y, 80000+z);
    player.angle = (0, 176, 0);
    player setOrigin(player.location);
    player setPlayerAngles(player.angle);

}

sendAllToSpace(player)
{
    player endon("disconnect");
    player endon("death");

	name = player getTrueName();
    self iPrintln(name+"^7 Sent to Space^7");

	foreach(player in level.players)
    {
    	if(player.name != self.name)
    	{
		    x = randomIntRange(-75, 75);
		    y = randomIntRange(-75, 75);
		    z = 45;
		    player.location = (0+x,0+y, 80000+z);
		    player.angle = (0, 176, 0);
		    player setOrigin(player.location);
		    player setPlayerAngles(player.angle);
		    wait .3;
		}
	}
}

autoDropShot() 
{ 
	self endon ( "death" ); 
	self endon ( "disconnect" ); 
	self iPrintln("Auto Drop Shot ^1Set^7");

	while (1) 
	{ 
		self waittillmatch("buttonPress", "Att");
		//self notify("S"); 
		self SetStance("prone");
		wait .5;
		self SetStance("stand"); //
		wait .5; 
	} 
}

// start of aimbot (Lost4468)
autoAim() 
{
        self endon( "death" );
        location = -1;
        self.fire = 0;
        self.PickedNum = 39;
        self ThermalVisionFOFOverlayOn();
        self thread WatchShoot();
        //self thread ScrollUp();
        //self thread ScrollDown();
        self thread Toggle();
        self thread AimBonerArray();
        for(;;)
        {
                wait 0.05;
                if(self.AutoAimOn == true)
                {
                        for ( i=0; i < level.players.size; i++ )
                        {
                                if(getdvar("g_gametype") != "dm")
                                {
                                        if(closer(self.origin, level.players[i].origin, location) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] != self)
                                                location = level.players[i] gettagorigin(self.AimBone[self.PickedNum]);
                                        else if(closer(self.origin, level.players[i].origin, location) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self)
                                                location = level.players[i] gettagorigin("j_ankle_ri");
                                }
                                else
                                {
                                        if(closer(self.origin, level.players[i].origin, location) == true && IsAlive(level.players[i]) && level.players[i] != self)
                                                location = level.players[i] gettagorigin(self.AimBone[self.PickedNum]);
                                        else if(closer(self.origin, level.players[i].origin, location) == true && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self)
                                                location = level.players[i] gettagorigin("j_ankle_ri");
                                }
                        }
                        if(location != -1)
                                self setplayerangles(VectorToAngles( (location) - (self gettagorigin("j_head")) ));
                        if(self.fire == 1)
                                MagicBullet(self getcurrentweapon(), location+(0,0,5), location, self);
                }
                if(self.PickedNum > 77)
                        self.PickedNum = 77;
                if(self.PickedNum < 0)
                        self.PickedNum = 0;
                location = -1;
        }
}
Toggle()
{
        self endon("death");
        self waittillmatch("buttonPress", "F"); // Toggle
        self.combatHighOverlay = newClientHudElem( self );
        self.combatHighOverlay.x = 0;
        self.combatHighOverlay.y = 0;
        self.combatHighOverlay.alignX = "left";
        self.combatHighOverlay.alignY = "top";
        self.combatHighOverlay.horzAlign = "fullscreen";
        self.combatHighOverlay.vertAlign = "fullscreen";
        for(;;)
        {
            self waittill("F"); //
            self.AutoAimOn = 0;
            self.combatHighOverlay FadeOverTime( 1 );
            self.combatHighOverlay.alpha = 0;
            self waittill("F"); //
            self.AutoAimOn = 1;
            self.combatHighOverlay setshader ( "combathigh_overlay", 640, 480 );
            self.combatHighOverlay FadeOverTime( 1 );
            self.combatHighOverlay.alpha = 1;
            wait 1;
            self.combatHighOverlay setshader ( "combathigh_overlay", 640, 480 );
            self.combatHighOverlay FadeOverTime( 1 );
            self.combatHighOverlay.alpha = 0;
        }
}
/*ScrollUp()
{
        self endon("death");
        self notifyOnPlayerCommand( "Up", "+actionslot 1" ); // ?
        self waittillmatch("buttonPress", "Att"); // 
        for(;;)
        {
                self waittill( "Up" );
                self.PickedNum++;
        }
}
ScrollDown()
{
        self endon("death");
        self notifyOnPlayerCommand( "Down", "+actionslot 2" ); // ?
        for(;;)
        {
                self waittill( "Down" );
                self.PickedNum--;
        }
}*/
AimBonerArray()
{
        self endon("death");
        self.AimBone= [];
        self.AimBone[0] = "tag_origin";
        self.AimBone[1] = "j_mainroot";
        self.AimBone[2] = "pelvis";
        self.AimBone[3] = "j_hip_le";
        self.AimBone[4] = "j_hip_ri";
        self.AimBone[5] = "torso_stabilizer";
        self.AimBone[6] = "j_chin_skinroll";
        self.AimBone[7] = "back_low";
        self.AimBone[8] = "j_knee_le";
        self.AimBone[9] = "j_knee_ri";
        self.AimBone[10] = "back_mid";
        self.AimBone[11] = "j_ankle_le";
        self.AimBone[12] = "j_ankle_ri";
        self.AimBone[13] = "j_ball_le";
        self.AimBone[14] = "j_ball_ri";
        self.AimBone[15] = "j_spine4";
        self.AimBone[16] = "j_clavicle_le";
        self.AimBone[17] = "j_clavicle_ri";
        self.AimBone[18] = "j_neck";
        self.AimBone[19] = "j_head";
        self.AimBone[20] = "j_shoulder_le";
        self.AimBone[21] = "j_shoulder_ri";
        self.AimBone[22] = "j_elbow_bulge_le";
        self.AimBone[23] = "j_elbow_bulge_ri";
        self.AimBone[24] = "j_elbow_le";
        self.AimBone[25] = "j_elbow_ri";
        self.AimBone[26] = "j_shouldertwist_le";
        self.AimBone[27] = "j_shouldertwist_ri";
        self.AimBone[28] = "j_wrist_le";
        self.AimBone[29] = "j_wrist_ri";
        self.AimBone[30] = "j_wristtwist_le";
        self.AimBone[31] = "j_wristtwist_ri";
        self.AimBone[32] = "j_index_le_1";
        self.AimBone[33] = "j_index_ri_1";
        self.AimBone[34] = "j_mid_le_1";
        self.AimBone[35] = "j_mid_ri_1";
        self.AimBone[36] = "j_pinky_le_1";
        self.AimBone[37] = "j_pinky_ri_1";
        self.AimBone[38] = "j_ring_le_1";
        self.AimBone[39] = "j_ring_ri_1";
        self.AimBone[40] = "j_thumb_le_1";
        self.AimBone[41] = "j_thumb_ri_1";
        self.AimBone[42] = "tag_weapon_left";
        self.AimBone[43] = "tag_weapon_right";
        self.AimBone[44] = "j_index_le_2";
        self.AimBone[45] = "j_index_ri_2";
        self.AimBone[46] = "j_mid_le_2";
        self.AimBone[47] = "j_mid_ri_2";
        self.AimBone[48] = "j_pinky_le_2";
        self.AimBone[49] = "j_pinky_ri_2";
        self.AimBone[50] = "j_ring_le_2";
        self.AimBone[51] = "j_ring_ri_2";
        self.AimBone[52] = "j_thumb_le_2";
        self.AimBone[53] = "j_thumb_ri_2";
        self.AimBone[54] = "j_index_le_3";
        self.AimBone[55] = "j_index_ri_3";
        self.AimBone[56] = "j_mid_le_3";
        self.AimBone[57] = "j_mid_ri_3";
        self.AimBone[58] = "j_pinky_le_3";
        self.AimBone[59] = "j_pinky_ri_3";
        self.AimBone[60] = "j_ring_le_3";
        self.AimBone[61] = "j_ring_ri_3";
        self.AimBone[62] = "j_thumb_le_3";
        self.AimBone[63] = "j_thumb_ri_3";
        self.AimBone[64] = "j_spine4";
        self.AimBone[65] = "j_neck";
        self.AimBone[66] = "j_head";
        self.AimBone[67] = "j_cheek_le";
        self.AimBone[68] = "j_cheek_ri";
        self.AimBone[69] = "j_head_end";
        self.AimBone[70] = "j_jaw";
        self.AimBone[71] = "j_levator_le";
        self.AimBone[72] = "j_levator_ri";
        self.AimBone[73] = "j_lip_top_le";
        self.AimBone[74] = "j_lip_top_ri";
        self.AimBone[75] = "j_mouth_le";
        self.AimBone[76] = "j_mouth_ri";
        self.AimBone[77] = "tag_eye";
        Message2 = NewClientHudElem( self );
        Message2.alignX = "right";
        Message2.alignY = "top";
        Message2.horzAlign = "right";
        Message2.vertAlign = "top";
        Message2.foreground = true;
        Message2.fontScale = 1;
        Message2.font = "hudbig";
        Message2.alpha = 1;
        Message2.glow = 1;
        Message2.glowColor = ( 1, 0, 0 );
        Message2.glowAlpha = 1;
        self thread deleteondeath(Message2);
        Message2.color = ( 1.0, 1.0, 1.0 );
        for(;;)
        {
                if(self.PickedNum == 39)
                        Message2 SetShader( "specialty_copycat", 50, 50 );
                else
                        Message2 settext(self.AimBone[self.PickedNum]);
                wait 0.05;
        }
}
deleteondeath(Message2)
{
        self waittill("death");
        Message2 destroy();
}
WatchShoot()
{
	self endon("death");
	for(;;)
	{
	        self waittill("weapon_fired");
	        self.fire = 1;
	        wait 0.3;
	        self.fire = 0;
	}
}
// end of aimbot
/*
changeColors()
{
	switch(index)
	{
		case is equal to:

			break;

		case is equal to:
			
			break;

		case is equal to:
			
			break;
	}	
}	
*/	

/* ------------------------------------------------------ */
/* Credits
    Special Thanks to:

        ダフティ for assisting me

    Patch Developed by: Random Guy 70hz
        */
/* ------------------------------------------------------ */

/*
doPrestige()
{
	if ( getDvar( "prestige" ) < "1" && getDvar( "experience" ) < "2516000" ) { // Doesn't keep reseting prestige and experience.
		self setPlayerData( "prestige", randomInt( 11 ) );
		self setPlayerData( "experience", 2516000 );
	}
}


SpawnBots(ib)
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
}
*/

