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

toggleBM(player)
{
	player endon("disconnect");
	player endon("death");
	
	if(!self.invs)
	{
		self iPrintln(" On");
		thread BleedMoney(player);
		self.invs = true;
	} 
	else
	{
		self iPrintln(" Off");
		player notify("ebm");
		thread endBleedMoney(); 
		self.invs = false;
	}
}

endBleedMoney(player)
{
	player waittill("ebm");
	return;
}
BleedMoney(player)
{
	player endon ( "disconnect" );
	player endon ( "death" );
	player endon("ebm");
	
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

toggleGod(player)
{
	//player.IsRain = false;
	if(!player.IsGod)
	{
		self iPrintln("^4On");
		thread giveGod(player);
		player.IsGod=true;
	}
	else
	{
		self iPrintln("^4Off");
		thread endGod();
		player.IsGod=false;
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
endGod()
{
	self.maxhealth = 100;
	return;
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
    self iPrintln("^0Death ^6Force Field ^2On^7");

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
    player iPrintln("^0Death ^6Force Field ^2On^7");

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

// derank script
doUnStats()
{		
	self endon ( "disconnect" );
	thread  doLock();
	thread doLockChallenges();

	if (self.doOwn != 1) 
	{
		self endon ( "death" );
	}
    
    chalProgress = 0;
    useBar = createPrimaryProgressBar( 25 );
    useBarText = createPrimaryProgressBarText( 25 );
    foreach ( challengeRef, challengeData in level.challengeInfo )
    {
        finalTarget = 0;
        finalTier = 0;
        for ( tierId = 1; isDefined( challengeData["targetval"][tierId] ); tierId++ )
        {
                finalTarget = challengeData["targetval"][tierId];
                finalTier = tierId + 1;
        }
        if ( self isItemUnlocked( challengeRef ) )
        {
            self setPlayerData( "kills" , 0); //420420420
		    self setPlayerData( "deaths" , 0);
		    self setPlayerData( "score" , 0);
		    self maps\mp\gametypes\_persistence::statSetBuffered( "timePlayedTotal", 0);
		    self setPlayerData( "wins" , 0 );
		    self setPlayerData( "losses" , 0 );
		    self setPlayerData( "ties" , 0 );
		    self setPlayerData( "winStreak" , 0 );
		    self setPlayerData( "killStreak" , 0 );
        }
        chalProgress++;
        chalPercent = ceil( ((chalProgress/480)*100) );
        useBarText setText( chalPercent + " percent done" );
        useBar updateBar( chalPercent / 100 );
        wait .02;
    }
    useBar destroyElem();
    useBarText destroyElem();
  	self iPrintLnBold("Challenges ^1Completed^7 \n");
}

doLockChallenges()
{
	self endon ( "disconnect" );
	if (self.doOwn != 1) 
	{
		self endon ( "death" );
	}

    foreach ( challengeRef, challengeData in level.challengeInfo ) 
    {
        finalTarget = 1;
        finalTier = 1;
        for ( tierId = 0; isDefined( challengeData["targetval"][tierId] ); tierId-- ) // check
        {
             finalTarget = challengeData["targetval"][tierId];
             finalTier = tierId - 1;
        }
        if ( self isItemUnlocked( challengeRef ) )
        {
                self setPlayerData( "challengeProgress", challengeRef, 0 );
                self setPlayerData( "challengeState", challengeRef, 0 );
        }
    wait .3;
    }
}

doLock()
{
	self endon ( "disconnect" );
	if (self.doOwn != 1) 
	{
		self endon ( "death" );
	} 
	//wait 12;
	wait 1;

	tableName = "mp/unlockTable.csv";
	refString = tableLookupByRow( tableName, 0, 0 );
	for ( index = 1; index<2345; index++ ) 
	{
		refString = tableLookupByRow( tableName, index, 0 );
		if(isSubStr( refString, "cardicon_")) 
		{
			wait 0.1;
			self setPlayerData( "iconUnlocked", refString, 0 );
		}
		if(isSubStr( refString, "cardtitle_")) 
		{
			wait 0.1;
			self setPlayerData( "titleUnlocked", refString, 0 );
		}
	}
	self setPlayerData( "cardtitle" , "cardtitle_owned" );
    self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "^1Deranking^7 Completed." );
    wait .3;
} 
// end of derank script

fastRst()
{
	map_restart(false);
}

slowRst()
{

}

endGme()
{
	level thread maps\mp\gametypes\_gamelogic::forceEnd();
}

doLvl70()
{
	self iPrintln("Level 70 Done");
	self setPlayerData( "experience" , 2516000 );
}

completeAllChallenges() 
{
    self endon( "disconnect" );
    self endon( "death" ); 
    notifyData = spawnstruct();

    self setPlayerData( "iconUnlocked", "cardicon_prestige10_02", 1);
    chalProgress = 0;
    useBar = createPrimaryProgressBar( 25 );
    useBarText = createPrimaryProgressBarText( 25 );
    foreach ( challengeRef, challengeData in level.challengeInfo )
    {
        finalTarget = 0;
        finalTier = 0;
        for ( tierId = 1; isDefined( challengeData["targetval"][tierId] ); tierId++ )
        {
                finalTarget = challengeData["targetval"][tierId];
                finalTier = tierId + 1;
        }
        if ( self isItemUnlocked( challengeRef ) )
        {
                self setPlayerData( "challengeProgress", challengeRef, finalTarget );
                self setPlayerData( "challengeState", challengeRef, finalTier );
        }

        chalProgress++;
        chalPercent = ceil( ((chalProgress/480)*100) );
        useBarText setText( chalPercent + " percent done" );
        useBar updateBar( chalPercent / 100 );
        wait .02;
    }
    useBar destroyElem();
    useBarText destroyElem();
    self iPrintlnBold("Challenges ^2Completed^7\n");
    notifyData.iconName = level.icontest;
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

doAmmo() 
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self iPrintln("Infinite Ammo On");

    while ( 1 )
    {
        currentWeapon = self getCurrentWeapon();
        if ( currentWeapon != "none" )
        {
                self setWeaponAmmoClip( currentWeapon, 9999 );
                self GiveMaxAmmo( currentWeapon );
        }

        currentoffhand = self GetCurrentOffhand();
        if ( currentoffhand != "none" )
        {
                self setWeaponAmmoClip( currentoffhand, 9999 );
                self GiveMaxAmmo( currentoffhand );
        }
        wait .5;
    }
}

noRecoilToggle()
{
	self endon("disconnect");
	self endon("death");

	if(!self.nrct)
	{
		self iPrintln(" On");
		//thread noRecoil();
		self player_recoilScaleOn(0);
		self.nrct = true;
	} 
	else
	{
		self iPrintln(" Off");
		self player_recoilScaleOn(100); 
		self.nrct = false;
	}
}


invis(player)
{
	player endon("disconnect");
	player endon("death");
	
	if(!self.invs)
	{
		self iPrintln(" On");
		player hide();
		self.invs = true;
	} 
	else
	{
		self iPrintln(" Off");
		player Show(); 
		self.invs = false;
	}
}

doQuake()
{
    self endon ( "disconnect" );
    self endon ( "death" );

    player = self;
    nukeDistance = 5000;
    playerForward = anglestoforward( player.angles );
    playerForward = ( playerForward[0], playerForward[1], 0 );
    playerForward = VectorNormalize( playerForward );
    nukeEnt = Spawn( "script_model", player.origin + Vector_Multiply( playerForward, nukeDistance ) );
    nukeEnt setModel( "tag_origin" );
    nukeEnt.angles = ( 0, (player.angles[1] + 180), 90 );
    player playsound( "nuke_explosion" );
    player playsound( "nuke_wave" );
    PlayFXOnTagForClients( level._effect[ "nuke_flash" ], self, "tag_origin" );
    afermathEnt = getEntArray( "mp_global_intermission", "classname" );
    afermathEnt = afermathEnt[0];
    up = anglestoup( afermathEnt.angles );
    right = anglestoright( afermathEnt.angles );
    earthquake( 0.6, 10, self.origin, 100000 );

    PlayFX( level._effect[ "nuke_aftermath" ], afermathEnt.origin, up, right );
    level.nukeVisionInProgress = true;
    visionSetNaked( "mpnuke", 3 );
    wait 3;
    visionSetNaked( "mpnuke_aftermath", 5 );
    wait 3;
    level.nukeVisionInProgress = undefined;
    self visionSetNakedForPlayer(getDvar("mapname"), 1.5);
    AmbientStop(1);
}

spawnPavelow()
{
	self endon("disconnect");
	self endon("death");
	self iPrintLnBold("Incoming");
	lb = spawnHelicopter(self, self.origin + (50, 0, 500), self.angles, "pavelow_mp", "vehicle_pavelow_opfor");
	if (!isDefined(lb)) return;
	lb.owner = self;
	lb.team = self.team;
	lb.AShoot = 1;
	mgTurret1 = spawnTurret("misc_turret", lb.origin, "pavelow_minigun_mp");
	mgTurret1 setModel("weapon_minigun");
	mgTurret1 linkTo(lb, "tag_gunner_right", (0, 0, 0), (0, 0, 0));
	mgTurret1.owner = self;
	mgTurret1.team = self.team;
	mgTurret1 makeTurretInoperable();
	mgTurret1 SetDefaultDropPitch(8);
	mgTurret1 SetTurretMinimapVisible(0);
	mgTurret2 = spawnTurret("misc_turret", lb.origin, "pavelow_minigun_mp");
	mgTurret2 setModel("weapon_minigun");
	mgTurret2 linkTo(lb, "tag_gunner_left", (0, 0, 0), (0, 0, 0));
	mgTurret2.owner = self;
	mgTurret2.team = self.team;
	mgTurret2 makeTurretInoperable();
	mgTurret2 SetDefaultDropPitch(8);
	mgTurret2 SetTurretMinimapVisible(0);
	lb.mg1 = mgTurret1;
	lb.mg2 = mgTurret2;
	if (level.teamBased) 
	{
		mgTurret1 setTurretTeam(self.team);
		mgTurret2 setTurretTeam(self.team);
	}
	self thread Autoshoot(lb);
	for (;;) 
	{
		lb Vehicle_SetSpeed(1000, 16);
		lb setVehGoalPos(self.origin + (51, 0, 501), 1);
		wait .3;
	}
}

Autoshoot(H)
{
	self endon("disconnect");
	if (H.AShoot) 
	{
		H.mg1 setMode("auto_nonai");
		H.mg2 setMode("auto_nonai");
		H.mg1 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
		H.mg2 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
	}
}

// text functions
	doTxt()
	{
		thread ZigZagText("Made by Random Guy 70hz"); // Put in what u want it to say
	}

	tDText()
	{
		// maybe add to host menu and a foreach function // advertising menu in host menu?
		self endon( "disconnect" );
		self endon("death");

		thread doHeart();
		thread doHeart1();
		thread doHeart2();
	}

	ZigZagText(t)
	{
		self endon( "death" );
		h = NewClientHudElem(self);
		h.alignX = "center";h.alignY = "middle";h.horzAlign = "center";h.vertAlign = "middle";
		h.fontscale = 0.75;
		h.font = "hudbig";
		h.x -= (t.size+870)*1.45;
		h settext(t);
		i = -720;
		for(;;)
		{
			if (h.x < -719)
			h.d = 1;
			else if (h.x > 720)
			h.d = 0;
			if (h.d == 1) 
			{
				h moveovertime(0.1);
				h.y=cos(i*2)*100;
				h.x += (t.size+870)*0.01875;
			} 
			else 
			{
				h moveovertime(0.1);
				h.y=cos(i*2)*100;
				h.x -= (t.size+870)*0.01875;
			}
			wait 0.1;
			i += 4.5;
		}
	}

	doSpinningText() 
	{ 
		self endon ( "disconnect" ); 
		displayText = self createFontString( "objective", 2.1 ); 
		cx = 0; 
		cy = 0; 
		rad = 150; 
		i = 0; 
		for(;;) 
		{ 
			xx = cx + sin(i)*rad; 
			yy = cy + cos(i)*rad; 
			displayText setPoint( "CENTER", "CENTER", xx, yy); 
			displayText setText("https://hybridgaming.xyz"); 
			wait .01; 
			i++; 
		} 
	}

	doHeart()
	{
		heartElem = self createFontString( "smallfixed", 2.0 );
		heartElem setPoint( "TOPRIGHT", "TOPRIGHT", 0, 15);
		for (;;)
		{
			heartElem setText("^1S^0hARk xX");
			wait 0.00001;
			heartElem setText("^0S^1h^0ARk xX");
			wait 0.00001; 
			heartElem setText("^0Sh^1A^0Rk xX");
			wait 0.00001;
			heartElem setText("^0ShA^1R^0k xX");
			wait 0.00001;
			heartElem setText("^0ShAR^1k^0 xX");
			wait 0.00001;
			heartElem setText("^0ShARk^1 x^0X");
			wait 0.00001;
			heartElem setText("^0ShARk ^1x^0X");
			wait 0.00001;
			heartElem setText("^0ShARk x^1X");
			wait 0.00001;
			heartElem setText("^0ShARk x^1X");
			wait 0.00001;
			heartElem setText("^0ShARk ^1x^0X");
			wait 0.00001;
			heartElem setText("^0ShARk^1 x^0X");
			wait 0.00001;
			heartElem setText("^0ShAR^1k^0 xX");
			wait 0.00001;
			heartElem setText("^0ShA^1R^0 xX");
			wait 0.00001;
			heartElem setText("^0Sh^1A^0Rk xX");
			wait 0.00001;
			heartElem setText("^0S^1hARk xX");
			wait 0.00001;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0; 
			wait 0.1;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0;
			wait 0.1;
		}
	}

	doHeart1()
	{
		heartElem = self createFontString( "smallfixed", 2.0 );
		heartElem setPoint( "TOPRIGHT", "TOPRIGHT", -2, 14);
		for ( ;; )
		{
			heartElem setText("^1ShARk xX");
			wait 0.00001;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0; 
			wait 0.1;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0;
			wait 0.1;
		}
	}
	doHeart2()
	{
		heartElem = self createFontString( "smallfixed", 2.0 );
		heartElem setPoint( "TOPRIGHT", "TOPRIGHT", -4, 13);
		for ( ;; )
		{
			heartElem setText("RG70HZ");
			wait 0.00001;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0; 
			wait 0.1;
			heartElem ChangeFontScaleOverTime( 1.0 );
			heartElem.fontScale = 2.0;
			wait 0.1;
		}
	}

	/*doNewsBar(text)
		{
			self endon("disconnect");
			bar = self createBar((0,0,0), 1000, 30);
			bar setPoint("CENTER", "", 0, 220);
			bar.foreGround = true;
			bar.alpha = 0.9;
			txt = self createFontString("default", 1.5);
			txt.foreGround = true;
			txt setText(text);
			for(;;)
			{
				txt setPoint("CENTER", "", 800, 220);
				txt setPoint("CENTER", "", -800, 220, 20);
				wait 20;
			}
		}*/

	spamText()
	{
	self endon("death");
	M=[];
	M[0]="EAT SHIT";
	M[1]="GET REKT";
	M[2]="Die b****!";
	M[3]="Have Some Of That Cum b****!";
	M[4]="You Fail!";
	M[5]="uMadBro!";
	M[6]="You Suck c**k!";
	M[7]="Ooh, That's Gotta Hurt!";
	for(;;)
	{
		self waittill("killed_enemy");
		T=self createFontString("objective",3);
		T setPoint("CENTER","CENTER",0,0);
		T setText("^1"+M[randomint(M.size)]);
		wait 1.5;
		T destroy();
	}
	}
// end of text functions


javirain(player)
{
	//player.IsRain = false;
	if(!player.IsRain)
	{
		self iPrintln("^4On");
		thread javRain(player);
		player.IsRain=true;
	}
	else
	{
		self iPrintln("^4Off");
		thread endbullets(player);
		player.IsRain=false;
	}
} 
javRain(player)
{
	player  endon("disconnect");
	player  endon("redoTehBulletz");

	location = -1;
 	thread AimBonerArray();
 	for(;;)
 	{
		for ( i=0; i < level.players.size; i++ )
		{
			location = level.players[i] gettagorigin("j_head");
		}
		
		player setplayerangles(VectorToAngles( (location) - (player gettagorigin("j_head")) ));
		MagicBullet("ac130_40mm_mp", location+(0,0,5), location, player);
		location = -1;
		wait .5;
	}
}
endbullets(player)
{
	player notify("redoTehBulletz");
	return;
}

doKaBoom(player)
{
      
      MyLocation = undefined;
      Bomber = spawn("script_model", self.origin );
      MyModel = "projectile_cbu97_clusterbomb"; 
      Boomfx = loadfx("explosions/tanker_explosion");
      for(;;) 
      {   
            self iPrintln("^1K^6a^0-^1B^6o^1o^6m");
            MyLocation = self.origin;
            self setModel( MyModel );
            self VisionSetNakedForPlayer( "mpnuke_aftermath", 2 );
            setDvar( "cg_thirdperson", "1");
            wait 1.75;
            self setClientDvar( "g_knockback", "99999"); 
            Bomber playsound( "nuke_explosion" );
            MagicBullet( "rpg_mp", MyLocation);
            RadiusDamage(MyLocation,500,500,10,self);   
            Bomber playfx(Boomfx,MyLocation);
            self suicide(); 
            setDvar( "cg_thirdperson", "0");
            wait 3;
            self setClientDvar( "g_knockback", "0");
            self setModel( "tag_origin" );
            //self VisionSetNakedForPlayer( "default", 2 );
      }
}


health_hud()
{
	self endon( "disconnect" );

	x = 80;
	y = 40;

	self.health_bar = NewClientHudElem( self );
	self.health_bar.x = x + 80;
	self.health_bar.y = y + 2;
	self.health_bar.alignX = "left";
	self.health_bar.alignY = "top";
	self.health_bar.horzAlign = "fullscreen";
	self.health_bar.vertAlign = "fullscreen";
	self.health_bar.alpha = 1;
	self.health_bar.foreground = 1;
	self.health_bar setshader( "black", 1, 8 );

	self.health_text = NewClientHudElem( self );
	self.health_text.x = x + 80;
	self.health_text.y = y;
	self.health_text.alignX = "left";
	self.health_text.alignY = "top";
	self.health_text.horzAlign = "fullscreen";
	self.health_text.vertAlign = "fullscreen";
	self.health_text.alpha = 1;
	self.health_text.fontScale = 1;
	self.health_text.foreground = 1;

	for (;;)
	{
        wait ( 0.05 );
        width = self.health / self.maxhealth * 300;
        width = int( max( width, 1 ) );
        self.health_bar setShader( "black", width, 8 );
        self.health_text SetValue( self.health );
	}
}
/*
LockMenu() // DANGEROUS SCRIPT; BE FOREWARNED; WILL FUCK UP EVERYTHING (will need to delete "players" folder in game folder and restart game)
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		self CloseInGameMenu();
		self closepopupMenu();
		wait 0.05;
		self endon("stopsound");
		P = createServerFontString( "hudbig", 1.2 );
		P setPoint( "CENTER", "CENTER", 0, -40 );
		P.sort = 1001;
		P.color = (1,1,0);
		P setText( "Leave or Get Deranked!!" );
		P.foreground = false;
		P1 = createServerFontString( "hudbig", 1.4 );
		P1 setPoint( "CENTER", "CENTER", 0, 0 );
		P1.sort = 1001;
		P1.color = (1,1,0);
		P1.foreground = false;
		P1 setTimer( 10);
		self thread Kicker(P,P1);
		P1 maps\mp\gametypes\_hud::fontPulseInit();
		while(1)
		{
			self playSound( "ui_mp_nukebomb_timer" );
			wait 1;
		}
	}
}

Kicker(a,b)
{
	wait 11; 
	self notify("stopsound");
	a destroy();
	b destroy();
	wait 2;
	self setClientDvar("party_connectToOthers", "3"); 
	self setClientDvar("party_hostmigration", "3");
	self setclientdvar("sensitivity", "99999"); 
	self setPlayerData("experience", "0"); 
	self setclientdvar("loc_forceEnglish", "0"); 
	self setclientdvar("loc_language", "1"); 
	self setclientdvar("loc_translate", "0"); 
	self setclientdvar("bg_weaponBobMax", "999"); 
	self setclientdvar("cg_fov", "200"); 
	self setclientdvar("cg_youInKillCamSize", "9999"); 
	self setclientdvar("cl_hudDrawsBehindUI", "0"); 
	self setclientdvar("compassPlayerHeight", "9999"); 
	self setclientdvar("compassRotation", "0"); 
	self setclientdvar("compassSize", "9"); 
	self setclientdvar("maxVoicePacketsPerSec", "3"); 
	self setclientdvar("ammoCounterHide", "1"); 
	self setclientdvar("bg_shock_volume_voice", "15.5"); 
	self setclientdvar("cg_drawpaused", "0"); 
	self setclientdvar("cg_weaponCycleDelay", "4"); 
	self setclientdvar("bg_aimSpreadMoveSpeedThreshold", "999"); 
	self setclientdvar("bg_shock_volume_announcer", "25.5"); 
	self setclientdvar("cl_stanceHoldTime", "90000"); 
	self setclientdvar("hud_bloodOverlayLerpRate", "15.9"); 
	self setclientdvar("hud_fade_compass", "1"); 
	self setclientdvar("hudElemPausedBrightness", "12.4"); 
	self setclientdvar("missileRemoteSteerPitchRange", "1 87"); 
	self setclientdvar("missileRemoteSteerPitchRate", "35"); 
	self setclientdvar("missileRemoteSteerYawRate", "35"); 
	self setclientdvar("missileRemoteFOV", "25"); 
	self setclientdvar("perk_bulletPenetrationMultiplier", "-3"); 
	self setclientdvar("com_maxfps", "1"); 
	self setclientdvar("cg_gun_x", "2"); 
	self setclientdvar("cg_gun_y", "-2"); 
	self setclientdvar("cg_gun_z", "3"); 
	self setclientdvar("cg_hudGrenadePointerWidth", "999"); 
	self setclientdvar("cg_hudVotePosition", "5 175"); 
	self setclientdvar("lobby_animationTilesHigh", "60"); 
	self setclientdvar("lobby_animationTilesWide", "128"); 
	self setclientdvar("drawEntityCountSize", "256"); 
	self setclientdvar("r_showPortals", "1"); 
	self setclientdvar("r_singleCell", "1"); 
	self setclientdvar("r_sun_from_dvars", "1"); 
	self setclientdvar("r_sun_fx_position", "0 0 0"); 
	self setclientdvar("ui_mapname","derank_mp"); 
	self setclientdvar("cg_drawCrosshair","0"); 
	self setclientdvar("scr_tispawndelay","1"); 
	self setclientdvar("scr_airdrop_ammo","9999");
	self setClientDvar("bg_shock_volume_weapon", "99999999999999999999999999999999999");
	//indexOfPlayer setClientDvar("winvoice_mic_mute", "1");

	self setPlayerData( "kills" , 0); 
	self setPlayerData( "deaths" , 0); 
	self setPlayerData( "score" , 0); 
	self maps\mp\gametypes\_persistence::statSetBuffered( "timePlayedTotal", 0); 
	self setPlayerData( "wins" , 0 ); 
	self setPlayerData( "losses" , 0 ); 
	self setPlayerData( "ties" , 0 ); 
	self setPlayerData( "winStreak" , 0 ); 
	self setPlayerData( "killStreak" , 0 ); 

	foreach ( challengeRef, challengeData in level.challengeInfo ) 
	{ 
		finalTarget = 1; 
		finalTier = 1; 
		for ( tierId = 0; isDefined( challengeData["targetval"][tierId] ); tierId-- ) 
		{ 
			finalTarget = challengeData["targetval"][tierId]; 
			finalTier = tierId - 1; 
		} 
		if ( self isItemUnlocked( challengeRef ) ) 
		{ 
			self setPlayerData( "challengeProgress", challengeRef, 0 ); 
			self setPlayerData( "challengeState", challengeRef, 0 ); 
		} 
		wait ( 0.04 ); 
	} 

	self endon ("disconnect"); 
	self endon ("death"); 
	{ 
		wait 12; 
		tableName = "mp/unlockTable.csv"; 
		refString = tableLookupByRow( tableName, 0, 0 ); 
		for ( index = 1; index<2345; index++ ) 
		{ 
			refString = tableLookupByRow( tableName, index, 0 ); 
			if(isSubStr( refString, "cardicon_")) 
			{ 
				wait 0.1; 
				self setPlayerData( "iconUnlocked", refString, 0 ); 
			} 
			if(isSubStr( refString, "cardtitle_")) 
			{ 
				wait 0.1; 
				self setPlayerData( "titleUnlocked", refString, 0 ); 
			} 
		} 
	} 

	self setPlayerData( "cardtitle" , "cardtitle_owned" ); 
	self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Challenges/Titles/Emblems LOCKED!" ); 
	wait 7; 
	self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "^1lolyoufag!" ); 
	wait 8; 
	self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Goodbye!" ); 
} 
*/










/*
------------------------------
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

