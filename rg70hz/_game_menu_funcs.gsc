// Headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;
	#include rg70hz\_hud_funcs;
	#include rg70hz\_menu_funcs;

// stop fx
	_stopFx()
	{
		self endon( "disconnect" );

		self waittill("stopFx"); 
		for(;;)
		{
			return;
		}
	}

// Test Function
	test()
	{
		self iPrintlnBold("Cursor Position: " + self.cursPos);
	}

// GUID Function
	ShowGUID()
	{	
		//name = player getTrueName();
		//guy = name;
		//self iPrintLnBold("^3GUID: ^1" + guy getGuid());
		
		for(i=0; i<level.players.size; i++)
		{
			player = level.players[i];
			play = player getGuid();
			self iPrintLnBold("^3GUID: ^1" + play); 
			wait 1;
		}
	}

// Visions
	Vis(vis)
	{
		self VisionSetNakedForPlayer( vis, 0);
		self iPrintln("^1Vision ^7"+vis+" [^5SET^7]"); 
	}

// Suicide Functions
	killPlayer(player)
	{
		player suicide();
		self iPrintln("^1Killed ^7" + player.name);
	}
	killSelf()
	{
		self suicide();
		self iPrintln("^1Suicided^7");
	}

// Kick player
	kickPlayer(player)
	{
	    //kick(player getEntityNumber(), "EXE_PLAYERKICKED");
	    //self iPrintln("^1Kicked ^7" + player);

	    //name = player getTrueName();
	    kick(player getEntityNumber(), "EXE_PLAYERKICKED");
	    self iPrintln("^1Kicked ^7" + player);
	}

// Get Player Name
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

// Bleed money toggle
	_toggleBM()
	{
		self endon("disconnect");
		self endon("death");

		// instructions text
			thread keod(self.toggleBM && self.tBM);
			self.toggleBM = createfontString("objective", 1);
			x = -325; y = 75; self.toggleBM setPoint("center", "center", x, y);
			self.toggleBM setText("Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop");

		for(;;)
		{
			self waittill("buttonPress", button);
			// button monitors
				if(button == "D")
				{
					if(!self.tBM)
					{
						self.tBM = true;
						self iPrintln("On");
						thread _bleedMoney();
					}
					else 
					{
						self.tBM = false;
						self iPrintln("Off");
						self notify("stopFx");
						//return;
					}
				}

				if(button == "K")
				{
					self.tBM = false;
					self iPrintln("Stopped");
					self notify("stopFx");

					self.toggleBM destroy();
					self.toggleBM = undefined;

					return;
				}
		}
	}
	/*_endBM()
	{
		self endon( "disconnect" );
		self endon("death");

		self waittill("stopFx");
		for(;;)
		{
			return;
		}
	}*/
	_bleedMoney()
	{
		self endon("disconnect");
		self endon("death");
		self endon("stopFx");

		//thread AimBonerArray();

		if(self.tBM == true)
		{
			self iPrintln("You're Rich!!");
			while(1)
			{
				playFx( level._effect["money"], self getTagOrigin( "j_spine4" ) );
				wait 0.5;
			}
		} else return;
	}

// Teleport Functions
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

// God mode
	toggleGod(player)
	{
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
	toggleGods()
	{
		if(!self.IsGod)
		{
			self iPrintln("^4On");
			thread doGod();
			self.IsGod=true;
		}
		else
		{
			self iPrintln("^4Off");
			thread endGod();
			self.IsGod=false;
		}
	} 
	doGod() 
	{
	    self endon ( "disconnect" );
	    self endon ( "death" );
	    //self iPrintln("God Mode On");
	    self.maxhealth = 90000;
	    self.health = self.maxhealth;
	    while (1)
	    {
		    wait .3;
		    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
	    }
	}

// Bot functions
	initTestClients(numberOfTestClients)
	{
		for(i = 0; i < numberOfTestClients; i++)
		{
			wait .3;
			ent[i] = addtestclient();

			if (!isdefined(ent[i]))
			{
				wait 1;
				continue;
			}

			ent[i].pers["isBot"] = true;
			ent[i] thread doPrestige();
			ent[i] thread IIB();
			wait .5;
		} wait .5; self iPrintln("^5"+i+ "^7 Bots Spawned");
	}
	doPrestige(i)
	{
		if ( getDvar( "prestige" ) < "1" && getDvar( "experience" ) < "2516000" ) 
		{ // Doesn't keep reseting prestige and experience.
			self setPlayerData( "prestige", randomInt( 11 ) );
			self setPlayerData( "experience", 2516000 );
		}
	}
	IIB()
	{
		while(!isdefined(self.pers["team"])) wait .5;
		self notify("menuresponse", game["menu_team"], "autoassign");
		wait .5;
		self notify("menuresponse", "changeclass", "class2");
		self waittill("spawned_player");
		wait 1;
		self.pers["isBot"] = true;
		wait 1;

		//self.pers["isBot"] setClientDvar("testClients_doMove",1);
		//self.pers["isBot"] setClientDvar( "testClients_doAttack", 1 );
		level.BotMove = true;
		//if(self.pers["isBot"]) thread moveBots();
		if (getDvarInt("testClients_doMove")) setDvar("testClients_doMove", 1);
  			
	}
	ToggleMove()
	{
	     if(level.BotMove)
		 {
		     level.BotMove = false;
		     self iPrintLnBold("^5Off");
			 self.pers["isBot"] setClientDvar("testClients_doMove",0);
			 self.pers["isBot"] setClientDvar( "testClients_doAttack", 0 );
		 }
		 else 
		 {
		    level.BotMove = true;
		    self iPrintLnBold("^5On");
			self.pers["isBot"] setClientDvar("testClients_doMove",1);
			self.pers["isBot"] setClientDvar( "testClients_doAttack", 1);
		 }
	}
	AttackBots()
	{
		if(!self.BotAttack)
		{
		     self.BotAttack = true;
			 self iprintln("^2Bots Attack ^2[ON]");
			 self setClientDvar("testClients_doAttack",1); 
		}
		else
		{
		    self.BotAttack = false;
			 self iprintln("^2Bots Attack ^2[OFF]");
			self setClientDvar("testClients_doAttack",0); 
		}
	}
	MoveBots()
	{
		if(!self.BotMove)
		{
		    self.BotMove = true;
			self iprintln("^2Bots Move ^2[ON]");
			self setClientDvar("testClients_doMove",1); 
		}
		else
		{
		    self.BotMove = false;
			self iprintln("^2Bots Move ^2[OFF]");
			self setClientDvar("testClients_doMove",0); 
		}
	}
	KickBot()
	{
		foreach ( player in level.players )
		{
			if ( isDefined ( player.pers [ "isBot" ] ) && player.pers [ "isBot" ] )
			kick ( player getEntityNumber(), "EXE_PLAYERKICKED" );
		}
	}
	/*moveBots()
	{
		self endon("disconnect");
		self iPrintln("...bots moving");
		for(;;)
		{
			start = self getTagOrigin( "tag_eye" );
			end = anglestoforward(self getPlayerAngles()) * 1000000;
			destination = BulletTrace(start, end, true, self)["position"];

			foreach( player in level.players ) 
			{
					if (player.pers["isBot"] == true) 
					{
						if (isDefined( player.pers["isBot"] ) && player.pers["isBot"] )
				        	        player setOrigin( destination );
					}

	
					if (isDefined( player.pers["isBot"] ) && player.pers["isBot"] )
				                player setOrigin( destination );
	
			} 
		wait .5;}
	}*/
	// Bot todo
		//self CreateMenu("bot","Bots","host");
			//self addOption("bot","Spawn x1 Bot",::initTestClients1);
			//self addOption("bot","Spawn x3 Bots",::initTestClients3);
			//self addOption("bot","Spawn x5 Bots",::initTestClients5);
			//self addOption("bot","Spawn x10 Bots",::initTestClients10);
			//self addOption("bot","Spawn x15 Bots",::initTestClients15);
			//self addToggleOption("bot","Bots Attack",::ToggleAttack,level.BotAttack);
			//self addToggleOption("bot","Bots Move",::ToggleMove,level.BotMove);
			//self addToggleOption("bot","Bots Watch Killcam",::ToggleKillcam,level.BotCam);
			//self addToggleOption("bot","Bots Crouch",::ToggleCrouch,level.BotCr);
			//self addToggleOption("bot","Bots Reload",::ToggleReload,level.BotReload);
			//self addOption("bot","Kick All Bots",::kickAllBots);
			//self addOption("bot","Kill All Bots",::killallbots);
			//self addOption("bot","Teleport All Bots To Me",::teleAllBotsMe);
			//self addToggleOption("bot","Shoot Bots to Crosshair",::botstocrossShoot,self.ShootBotsCross);

// Force field
	_toggleFF()
	{
		self endon("disconnect");
		self endon("death");

		//
			thread keod(self.toggleFF && self.tFF);
			self.toggleFF = createfontString("objective", 1);
			x = -325; y = 75; self.toggleFF setPoint("center", "center", x, y);
			self.toggleFF setText("Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop");

		for(;;)
		{
			self waittill("buttonPress", button);
			if(button == "D")
			{
				if(!self.tFF)
				{
					self.tFF = true;
					self iPrintln("On");
					thread field();
				}
				else 
				{
					self.tFF = false;
					self iPrintln("Off");
					self notify("stopFF");

					self.health = 100;
					self SetMoveSpeedScale(1);
				}
			}
			if(button == "K")
			{
				self.tFF = false;
				self iPrintln("Stopped");
				self notify("stopFF");

				self.toggleFF destroy();
				self.toggleFF = undefined;

				self.health = 100;
				self SetMoveSpeedScale(1);

				return;
			}
		}
	}
	field()
	{
	   	self endon ( "disconnect" );
	   	self endon ( "death" );
	   	self endon ( "stopFF" );

	    if(self.tFF == true)
	    {
		    //self setClientDvar("cg_drawDamageDirection", 0);
		    self SetMoveSpeedScale( 1 );

		    self.maxhealth = 90000;
		    self.health = self.maxhealth;
		    for(;;)
		    {
			    self.health += 40;
			    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
			    RadiusDamage( self.origin, 200, 81, 10, self ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
			    wait .3;
			}
		}
		else return;
	}
	endField()
	{
		self waittill("stopFF");
		for(;;)
		{
			self.health = 100;
		    self SetMoveSpeedScale( 1 );
			return;
		}
	}

// fire functions
	// debug
		/*FireOn(player)
		{
		   	player endon ( "disconnect" );
		   	player endon ( "death" );
		    self iPrintln(" ^1Toasted^7");
		   	while(1)
		   	{
			    player setClientDvar("cg_drawDamageDirection", 0);
			    playFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "pelvis" );
			    player SetMoveSpeedScale( 1.5 );

			    player.health -= 40;
			    RadiusDamage( player.origin, 200, 81, 10, player ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
			    wait 0.5;
			}
		}
		toggleFire(player)
		{
			if(!player.InFire1)
			{
				self iPrintln("^5On");
				thread FireOn2(player);
				player.InFire1 = true;
			}
			else
			{
				self iPrintln("^5Off");
				thread endFire(player);
				player notify("endFire");
				player.InFire1 = false;
			}
		}*/
		/*endFire()
		{
			playFxOnTag( "", self, "" );
			return; 
		}*/
		/*FireOn2(player)
		{
		   	player endon ( "disconnect" );
		   	player endon("stopFx");
			name = player getTrueName(); 
		    self iPrintln(name + "^1Toasted^7");

		    while(1)
		    {
			    player setClientDvar("cg_drawDamageDirection", 0);
			    playFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
			    playFxOnTag( level.spawnGlow["enemy"], player, "pelvis" );
			    player SetMoveSpeedScale( 1.5 );

			    player.health -= 40;//40;
			    RadiusDamage( player.origin, 200, 81, 10, player ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
			    wait 0.5;
			}
		}*/
	_toggleFire()
	{
		self endon("disconnect");
		self endon("death");

		// instructions text
			self.toggleFire = createfontString("objective", 1);
			x = -325; y = 75; self.toggleFire setPoint("center", "center", x, y);
			self.toggleFire setText("Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop");
			thread keod(self.toggleFire && self.tFire);
		for(;;)
		{
			self waittill("buttonPress", button);
			if(button == "D")
			{
				if(!self.tFire)
				{
					self.tFire = true;
					self iPrintln("On");
					thread _fireOn();
				}
				else 
				{
					self.tFire = false;
					self iPrintln("Off");
					self notify("stopFx");
					stopFxOnTag( level.spawnGlow["enemy"], self, "j_head" );
			    	stopFxOnTag( level.spawnGlow["enemy"], self, "tag_weapon_right" );
			    	stopFxOnTag( level.spawnGlow["enemy"], self, "back_mid" );
			    	stopFxOnTag( level.spawnGlow["enemy"], self, "torso_stabilizer" );
			    	stopFxOnTag( level.spawnGlow["enemy"], self, "pelvis" );

					//thread keoc(level.spawnGlow["enemy"]);
				}
			}
			if(button == "K")
			{
				self.tFire = false;
				self iPrintln("Stopped");
				self notify("stopFx");

				self.toggleFire destroy();
				self.toggleFire = undefined;

				self iPrintln("ur ^5cool");
		    	stopFxOnTag( level.spawnGlow["enemy"], self, "j_head" );
		    	stopFxOnTag( level.spawnGlow["enemy"], self, "tag_weapon_right" );
		    	stopFxOnTag( level.spawnGlow["enemy"], self, "back_mid" );
		    	stopFxOnTag( level.spawnGlow["enemy"], self, "torso_stabilizer" );
		    	stopFxOnTag( level.spawnGlow["enemy"], self, "pelvis" ); 
				return;
			}
		}
	}
	_fireOn()
	{	
		self endon ("disconnect");
		self endon("death");
	   	self endon("stopFx");

		self iPrintln("ur a ^1blazin");
	   	for(;;)
	   	{
		    playFxOnTag( level.spawnGlow["enemy"], self, "j_head" );
		    playFxOnTag( level.spawnGlow["enemy"], self, "tag_weapon_right" );
		    playFxOnTag( level.spawnGlow["enemy"], self, "back_mid" );
		    playFxOnTag( level.spawnGlow["enemy"], self, "torso_stabilizer" );
		    playFxOnTag( level.spawnGlow["enemy"], self, "pelvis" ); 
		    wait .5;
		}
	}

	_toggleFireP(player)
	{
		self endon("disconnect");
		self endon("death");

		// instructions text
			self.toggleFire = createfontString("objective", 1);
			x = -325; y = 75; self.toggleFire setPoint("center", "center", x, y);
			self.toggleFire setText("Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop");
			thread keod(self.toggleFire && self.tFire);

		for(;;)
		{
			self waittill("buttonPress", button);
			if(button == "D")
			{
				if(!self.tFire)
				{
					self.tFire = true;
					self iPrintln("On");
					thread _fireOnP();
				}
				else 
				{
					self.tFire = false;
					self iPrintln("Off");
					self notify("stopFx");
					stopFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
			    	stopFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
			    	stopFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
			    	stopFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
			    	stopFxOnTag( level.spawnGlow["enemy"], player, "pelvis" );
				}
			}
			if(button == "K")
			{
				self.tFire = false;
				self iPrintln("Stopped");
				self notify("stopFx");

				self.toggleFire destroy();
				self.toggleFire = undefined;

				self iPrintln("ur ^5cool");
		    	stopFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
		    	stopFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
		    	stopFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
		    	stopFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
		    	stopFxOnTag( level.spawnGlow["enemy"], player, "pelvis" ); 
				return;
			}
		}
	}
	/*kfoc(elem)
		{
			self waittill("buttonPress", button)

			elem.stopFxOnTag( level.spawnGlow["enemy"], player, "j_head" );
	    	elem.stopFxOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
	    	elem.stopFxOnTag( level.spawnGlow["enemy"], player, "back_mid" );
	    	elem.stopFxOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
	    	elem.stopFxOnTag( level.spawnGlow["enemy"], player, "pelvis" ); 
			return;
		}*/
	 
	_fireOnP(player)
	{	
		player endon ("disconnect");
		player endon("death");
	   	player endon("stopFx");

	   	for(;;)
	   	{
		    playFXOnTag( level.spawnGlow["enemy"], player, "j_head" ); 
		    playFXOnTag( level.spawnGlow["enemy"], player, "tag_weapon_right" );
		    playFXOnTag( level.spawnGlow["enemy"], player, "back_mid" );
		    playFXOnTag( level.spawnGlow["enemy"], player, "torso_stabilizer" );
		    playFXOnTag( level.spawnGlow["enemy"], player, "pelvis" );

		    player setClientDvar("cg_drawDamageDirection", 0);
			player.health -= 40;
		    RadiusDamage( player.origin, 200, 81, 10, player ); // RadiusDamage( Origin, Range, Maximum Damage, Minimum Damage, Attacker );
		    wait .5;
		}
	}

// Send to space
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

// Drop shot
	toggleDS(player)
	{
		//player.IsRain = false;
		if(!self.InDS)
		{
			self iPrintln("^5On");
			thread autoDropShot();
			self.InDS=true;
		}
		else
		{
			self iPrintln("^5Off");
			//thread endFire();
			self notify("endDS");
			self.InDS=false;
		}
	}
	endDS()
	{
		self waittill("endDS");
		return;
	}
	autoDropShot() 
	{  
		self endon ( "disconnect" );
		// self endon("death");
		self endon("endDS"); 
		//self iPrintln("Auto Drop Shot ^1Set^7");

		while (1) 
		{ 
			self waittillmatch("buttonPress", "Att");
			self SetStance("prone");
			wait .5;
			self SetStance("stand"); //
			wait .5; 
		} 
	}

// Aimbot
	autoAim() 
	{
	   // if(self.aimBot)
	   //  {
			self endon("death");
			location = -1;
		    self.fire = 0;
		    self.PickedNum = 39;
		    self.AutoAimOn = 1;

		    self ThermalVisionFOFOverlayOn();
		    self thread WatchShoot();
			self thread AimBonerArray();
		    self thread ScrollUp();
		    self thread ScrollDown();

		    for(;;)
		    {
		        wait .05;
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

		            if(location != -1) self setplayerangles(VectorToAngles( (location) - (self gettagorigin("j_head")) ));
		            if(self.fire == 1) MagicBullet(self getcurrentweapon(), location+(0,0,5), location, self);
		        }

		        if(self.PickedNum > 77) self.PickedNum = 77;
		        if(self.PickedNum < 0) self.PickedNum = 0;
		        location = -1;
		    }
		//}
	}

	toggleAimbot(Message2)
	{
		self endon("disconnect");
		self endon("death");

		self thread rg70hz\_hud_util_funcs::KillText();
		killAim();

		//self.aimbotIn = createfontString("objective", 1);
		//self.aimbotIn setPoint("RIGHT", "CENTER", -300, -100);
		//self.aimbotIn settext("Press -^7\n 	 ^35^7 to ^5toggle^7^7\n"+" 	 ^33^7 To ^1Stop^7\n");

		//self.aimbot_Scr = createfontString("objective", 1);
		//self.aimbot_Scr setPoint("RIGHT", "CENTER", -130, -115);
		//self.aimbot_Scr settext("^1[{+frag}] ^3/ ^1[{+actionslot 1}]^7 -  To ^5Cycle^7 Aimbone");

		thread keod(self.aimBotIn);
		self.aimBotIn = createfontString("objective", 1);
		x = -275; y = 75; self.aimBotIn setPoint("center", "center", x, y);
		self.aimBotIn setText("Press -^7 ^35^7 To ^5Toggle^7\n^33^7 To ^1Stop^7\n^1[{+frag}]^3/^1[{+actionslot 1}]^7 -  To ^5Cycle^7 Aimbone");


		self iPrintln("^1On");
		for(;;)
		{
			self waittill("buttonPress", button);
			if(button == "F") // toggle - actionslot 2 // keypad number 5
			{
				if(!self.aimBot)
				{
					
					self.aimBot = true;
					self iPrintln("^5On");
					self.AutoAimOn = true;
					self.AutoAimOn = 1;
					self thread autoAim();
				}
				else 
				{
					self.aimBot = false;
					self iPrintln("^5Off");

					self.AutoAimOn = false;
					self.AutoAimOn = 0;
					
					self.AimBone = undefined;
	        		self.AimBone destroy();

	        		Message2 destroy();
					self ThermalVisionFOFOverlayOff();
				}
			}

			if(button == "K") // kill function - actionslot 3 // keypad number 3
			{
				self.aimBot = false;
				self.AutoAimOn = false;
				self.AutoAimOn = 0;

				self iPrintln("^1Off");

				self.AimBone = undefined;
        		self.AimBone destroy();

        		self.aimbotIn destroy();
				self.aimbotIn = undefined;

				//self.aimbot_Scr destroy();
				//self.aimbot_Scr = undefined;

        		Message2 destroy();

				self ThermalVisionFOFOverlayOff();
				return;
			}
		}
	}
	killAim()
	{
        //self.combatHighOverlay = newClientHudElem( self );
        //self.combatHighOverlay.x = 0;
        //self.combatHighOverlay.y = 0;
        //self.combatHighOverlay.alignX = "left";
        //self.combatHighOverlay.alignY = "top";
        //self.combatHighOverlay.horzAlign = "fullscreen";
        //self.combatHighOverlay.vertAlign = "fullscreen";

        self.AutoAimOn = 0;
        self.AutoAimOn = false;

        //self.combatHighOverlay FadeOverTime( 1 );
        self.combatHighOverlay.alpha = 0;

        self.combatHighOverlay destroy();
        self.combatHighOverlay = undefined;

        self.aimbotIn destroy();
		self.aimbotIn = undefined;

		self.aimbot_Scr destroy();
		self.aimbot_Scr = undefined;

		self.AimBone = undefined;
	    self.AimBone destroy();
	}
	//Aimbone Scrolls
	ScrollUp()
	{
	        self endon("death");
	        self notifyOnPlayerCommand( "u", "+frag" ); //  
	        for(;;)
	        {
	                self waittill( "u" );
	                self.PickedNum++;
	        }
	}
	ScrollDown()
	{
	        self endon("death");
	        self notifyOnPlayerCommand( "d", "+actionslot 1" ); // 
	        for(;;)
	        {
	                self waittill( "d" );
	                self.PickedNum--;
	        }
	}
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
	       	Message2 = createFontString("hudbig", .7);
	        Message2 setPoint("RIGHT", "CENTER", -90, -225);
	        Message2.foreground= true;
	        Message2.alpha     = 1;
	        Message2.glow      = 1;
	        Message2.glowColor = ( 1, 0, 0 );
	        Message2.glowAlpha = .6;
	        Message2.color = ( 1.0, 1.0, 1.0 );
	        self thread deleteondeath(Message2);

	        for(;;)
	        {
	            Message2 settext("^1Target: ^7[ " + self.AimBone[self.PickedNum] + " ^7]");
	            wait .05;
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

// Derank script
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
	        useBarText setText( "Deranking ...^1"+chalPercent+"^7/100" );
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

// Game functions
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

// Account functions
	// quick lvl 70
		doLvl70()
		{
			self iPrintln("Level 70 Done");
			self setPlayerData( "experience" , 2516000 );
		}
	// unlock all
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

// Infinite ammo
	_infAmmoToggle()
	{
		if(!self.infAmmo)
		{
			self.infAmmo = true;
			self iPrintln("^5On");
			thread _infAmmo();
		}
		else
		{
			self.infAmmo = false;
			self iPrintln("^5Off");
			self notify("stopFx");
			//_stAmmo();
			return;
		}
	}
	_infAmmo() 
	{
	    self endon ( "disconnect" );
	    self endon ( "death" );
	    self endon("stopFx");

	    for(;;)
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

// No recoil
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

// Invisibility
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

// Earthquake
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

// Pet Pavelow
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

// Text functions
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

	tdToggle(heartElem)
	{
		if(!self.tdTog)
		{
			self.tdTog = true;
			self iPrintln("On");
			thread tDText();
		}
		else
		{
			self.tdTog = false;
			self iPrintln("Off");
			self notify ("kill3d");
			thread kill3d();
		}
	}
	kill3d(heartElem)
	{
		self waittill("kill3d");
		heartElem destroy();
		heartElem = undefined;
		return;
	}
	doHeart()
	{
		self endon("kill3d");
		heartElem = self createFontString( "smallfixed", 2.0 );
		heartElem setPoint( "TOPRIGHT", "TOPRIGHT", 0, 15);
		for (;;)
		{
			heartElem setText("^6R^0G70HZ");
			wait 0.00001;
			heartElem setText("^0R^6G^070HZ");
			wait 0.00001;
			heartElem setText("^0RG^67^00HZ");
			wait 0.00001; 
			heartElem setText("^0RG7^60^0HZ");
			wait 0.00001;
			heartElem setText("^0RG70^6H^0Z");
			wait 0.00001;
			heartElem setText("^0RG70H^6Z");
			wait 0.00001;
			heartElem setText("^0RG70HZ");
			wait 0.00001;
			heartElem setText("^0RG70H^6Z");
			wait 0.00001;
			heartElem setText("^0RG70^6H^0Z");
			wait 0.00001;
			heartElem setText("^0RG7^60^0HZ");
			wait 0.00001;
			heartElem setText("^0RG^67^00HZ");
			wait 0.00001;
			heartElem setText("^0R^6G^070HZ");
			wait 0.00001;
			heartElem setText("^6R^0G70HZ");
			wait 0.00001;
			/*heartElem setText("^0R^6G^07^60^0H^6Z");
			wait 0.00001;
			heartElem setText("^6R^0G^67^00^6H^0Z");
			wait 0.00001;
			heartElem setText("^0R^6G^07^60^0H^6Z");
			wait 0.00001;*/
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
		self endon("kill3d");
		heartElem = self createFontString( "smallfixed", 2.0 );
		heartElem setPoint( "TOPRIGHT", "TOPRIGHT", -2, 14);
		for ( ;; )
		{
			heartElem setText("^1RG70HZ");
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
		self endon("kill3d");
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

	spamToggle()
	{
		if(!self.spam)
		{
			self.spam = true;
			self iPrintln("^5On");
			thread spamText();
		} 
		else 
		{
			self.spam = false;
			self iPrintln("^5Off");
			self notify("disableT");
			thread killSpam();
		}
	}
	killSpam(T, M)
	{
		self waittill("disableT");
		T destroy();
		M destroy();
		return;
	}
	spamText()
	{
		self endon("disconnect");
		self endon("disableT");
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
			T setText( "^1" + M[randomint(M.size)]);
			wait 1.2;
			T destroy();
		}
	}

// Javelin Rain
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
		player endon("disconnect");
		player endon("redoTehBulletz");

		//location = -1;

	 	thread AimBonerArray();
	 	for(;;)
	 	{
			for ( i=0; i < level.players.size; i++ )
			{
				location = level.players[i] gettagorigin("j_head");
			}

			location = level.players[i] gettagorigin("j_head");
			//player setplayerangles(VectorToAngles( (location) - (player gettagorigin("j_head")) ));
			playerlocation = player.origin;

			//MagicBullet("ac130_40mm_mp", location+(0,0,5), location, player); 
			//MagicBullet("javelin_mp", location+(0,0,5), location, player); 
			MagicBullet("javelin_mp", (0,0,0), location, player);

			wait 1;
		}
	}
	endbullets(player)
	{
		player notify("redoTehBulletz");
		//break;
		return;
	}

// Kaboom
	doKaBoom(player) // similar to javelin rain
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

// Health Bar
	toggleHealthBar()
	{
		self endon("disconnect");
		self endon("death");

		// instructions text	
			self.toggleLaser = createfontString( "objective", 1 );
			self.toggleLaser setPoint ( "center", "center", -325, 75 );
			self.toggleLaser setText ( "Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop" );
			thread doColorEffect(self.toggleLaser);
			thread keod( self.toggleLaser && self.tLsr );

		for(;;)
		{
			self waittill("buttonPress", button);

			if( button == "D" )
			{
				if(!self.IshB)
				{
					self iPrintln("^4On");
					thread health_hud();
					self.IshB = true;
				}
				else
				{
					self iPrintln("^4Off");
					self.IshB = false;
					self.health_bar destroy(); 
					self.health_bar = undefined;
					self.health_text destroy();
					self.health_text = undefined;
				}
			}

			if( button == "K" )
			{
				self iPrintln("^4Off");
				self.IshB = false;
				self.health_bar destroy(); 
				self.health_bar = undefined;
				self.health_text destroy();
				self.health_text = undefined;
				self.toggleLaser destroy();
				self.toggleLaser = undefined;
				return;
			}
		}
	}
	health_hud()
	{
		self endon( "disconnect" );
		//for(;;)
		//{
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
			self.health_bar.sort = -1;

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
			self.health_text.sort = 1;

			for (;;)
			{
		        wait ( 0.05 );
		        width = self.health / self.maxhealth * 300;
		        width = int( max( width, 1 ) );
		        self.health_bar setShader( "black", width, 8 );
		        self.health_text SetValue( self.health );
			}
		//}
	}

// Clone Me
	CloneMe()
	{
		self ClonePlayer(99999);
		self iprintln(self.name+" ^1Cloned");
	}

// Flashing Player
	ToggleFlashingPlayer()
	{
		if(!self.FlashyDude)
		{
			self.FlashyDude=true;
			self iprintln("^5On");
			self thread doFlashyDude();
		}
		else
		{
			self.FlashyDude=false;
			self iprintln("^5Off");
			self notify("end_flashPlayer");
			self show();
		}
	}
	doFlashyDude()
	{
		self endon("end_flashPlayer");
		for(;;)
		{
			self hide();
			wait .1;
			self show();
			self iprintln("^"+randomInt(9)+" You are Flashing!");
			wait 0.05;
		}
		wait 0.05;
	}
	ToggleFlashingPlayerp(player)
	{
		if(!player.FlashyDude)
		{
			player.FlashyDude=true;
			self iprintln("^5On");
			player thread doFlashyDude();
		}
		else
		{
			player.FlashyDude=false;
			self iprintln("^5Off");
			player notify("end_flashPlayer");
			player show();
		}
	}
	doFlashyDudep(player)
	{
		player endon("end_flashPlayer");
		//playerP = getTrueName();
		for(;;)
		{
			player hide();
			wait .1;
			player show();
			wait 0.05;
		}
		wait 0.05;
	}

// Toggle Third Person
	ToggleThirdPerson()
	{
		if(!self.ThirdPersonView)
		{
			self.ThirdPersonView = true;
			self setClientDvar("cg_thirdperson",1);
		}
		else
		{
			self setClientDvar("cg_thirdperson",0);
			self.ThirdPersonView = false;
		}
	}

// Toggle Laser
	/*ToggleLaserLight()
	{
		if(!self.LaserLight)
		{
			self.LaserLight = true;
			self iPrintln("Laser ^2ON");
			self setClientDvar("laserForceOn",1);
		}
		else
		{
			self.LaserLight = false;
			self iPrintln("Laser ^1OFF");
			self setClientDvar("laserForceOn",0);
		}
	}*/
	_toggleLaser(modInst)
	{
		self endon ( "disconnect" );
		self endon ( "death" );

		// instructions text	
			self.toggleLaser = createfontString( "objective", 1 );
			self.toggleLaser setPoint ( "center", "center", -325, 75 );
			self.toggleLaser setText ( "Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop" );
			thread doColorEffect(self.toggleLaser);
			thread keod( self.toggleLaser && self.tLsr );

			//self.motd_text setText("Press [{+actionslot 1}] To ^5Toggle^7 [{+actionslot 3}] To ^1Stop");

			//modInst setText("Test");

		self iPrintln ( "On" );
		self setClientDvar ( "laserForceOn", 1 );
		for(;;)
		{
			self waittill ( "buttonPress", button );
			if ( button == "D" )
			{
				if(!self.tLsr)
				{
					self.tLsr = true;
					self iPrintln ( "Off" );
					self setClientDvar ( "laserForceOn" , 0 );
				}
				else
				{
					self.tLsr = false;
					self iPrintln ( "On" );
					self setClientDvar ( "laserForceOn" , 1 );
				}
			}

			if ( button == "K" )
			{
				self.tLsr = false;
				self iPrintln ( "Stopped" );
				self setClientDvar ( "laserForceOn" , 0 );

				self.toggleLaser destroy();
				self.toggleLaser = undefined;
				return;
			}
		}
	}

// Test variable
	/*_modInstruc()
	{
		self endon("disconnect");
		self endon("death");

		for(;;)
		{
			modInst = NewClientHudElem(self);
			modInst = createfontString( "objective", 1 );
			modInst setPoint ( "center", "center", -325, 75 );
			//modInst setText ( "Press [{+actionslot 1}] To ^5Toggle^7\n[{+actionslot 3}] To ^1Stop" );
			//modInst setText("");
			//modInst setText("Test");
			modInst.sort = 1;
			modInst.foreground = true;
			modInst.alpha = 0;
			//thread doColorEffect ( modInst );
			//thread keod ( modInst );
			wait .05;
		}	
	}*/
	
// Jet Pack
	doJetPack()
	{
		if(!self.jetpack)
		{
			self.jetpack=true;
			self thread StartJetPack();
			self iPrintln("^5On");
			self iPrintln("Press [{+frag}] for jetpack");
		}
		else
		{
			self.jetpack=false;
			self notify("jetpack_off");
			self iPrintln("^5Off");
		}
	}
	StartJetPack()
	{
		self endon("jetpack_off");
		self.jetboots= 100;
		for(i=0;;i++)
		{
			if(self Fragbuttonpressed() && self.jetboots>0)
			{
				playFX(level._effect["lght_marker_flare"],self getTagOrigin("J_Ankle_RI"));
				playFx(level._effect["lght_marker_flare"],self getTagOrigin("J_Ankle_LE"));
				earthquake(.15,.2,self gettagorigin("j_spine4"),50);
				self.jetboots--;
				if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
			}
			if(self.jetboots<100 &&!self Fragbuttonpressed())self.jetboots++;
			wait .05;
		}
	}

// Fountain Functions
	ToggleFountain(inp)
	{
		switch(inp)
		{
			case "money":
				if(!self.MoneyFountain)
				{
					self.MoneyFountain = true;
					self setClientDvar("cg_thirdperson",1);
					//self thread BleedMoney();
				}
				else
				{
					self.MoneyFountain = false;
					self setClientDvar("cg_thirdperson",0);
					self notify("KillFountain");
				}
			break;
			
			case "blood":
				if(!self.BloodFountain)
				{
					self.BloodFountain = true;
					self setClientDvar("cg_thirdperson",1);
					self thread BloodFountain();
				}
				else
				{
					self.BloodFountain = false;
					self setClientDvar("cg_thirdperson",0);
					self notify("KillFountain");
				}
			break;
			
			case "water":
				if(!self.WaterFountain)
				{
					self.WaterFountain = true;
					self setClientDvar("cg_thirdperson",1);
					self thread WaterFountain();
				}
				else
				{
					self.WaterFountain = false;
					self setClientDvar("cg_thirdperson",0);
					self notify("KillFountain");
				}
			break;
		}
	}
	/*BleedMoney()
	{
		self endon("KillFountain");
		while(1)
		{
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			playFx(level._effect["money"],self getTagOrigin("j_spine4"));
			wait .001;
		}
	}*/
	BloodFountain()
	{
	    self endon("KillFountain");
		while(1)
		{
			playFx(level._effect["blood"],self getTagOrigin("j_spine4"));
			wait .001;
		}
		wait .001;
	}
	WaterFountain()
	{
	    self endon("KillFountain");
		while(1)
		{
			playfx(level._effect["water"],self getTagOrigin("j_spine4"));
			wait .001;
		}
		wait .001;
	}

// Gametype Settings
	/*ChangeGametype(gametype)
	{
		setDvar("g_gametype",gametype); // input
		map_restart(false);
	}*/

// Kill
	/*KillClientReal(me,client)
	{
		client thread [[level.callbackPlayerDamage]](me,me,100,0,"MOD_HEAD_SHOT",me getCurrentWeapon(),(0,0,0),(0,0,0),"head",0,0);
	}*/

// Menu Color Functions
	_colors(i) 
	{
		self.menuFG.color  = (i);
		self.leftP0.color  = (i);
		self.menuBG.color  = (i);
		self.menuBG2.color = (i);
		self.menuBG1.color = (i);
		self.menuFG.color  = (i);
		self iPrintln   ("Done");
		wait 1;
	}
	changeColors()
	{
		self.menuFG.color  = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
		self.leftP0.color  = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
		self.menuBG.color  = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
		self.menuBG2.color = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
		self.menuBG1.color = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
		//self.menuFG.color  = ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));
	}
	_resetColor()
	{
		self.menuFG.color  = (0.0, 0.0, 0.0);
		self.leftP0.color  = (0.0, 0.0, 0.0);
		self.menuBG.color  = (0.0, 0.0, 0.0);
		self.menuBG2.color = (0.0, 0.0, 0.0);
		self.menuBG1.color = (0.0, 0.5, 1.0);
	}

// Prestige Menu
	_setPrestige(i) 
	{
		self thread _prest(i);
		self setPlayerData("prestige", i);
		self setPlayerData("experience", 2516000);
		self thread presMessage("You Are Now ^1" +i+ "^7 Prestige \n" ); 
		wait 0.5; self iPrintLn("Leave the game to save");
		wait 1.5;  

	}

	/*prest(i)
	{
		self endon("disconnect");
		thread _prest(e);

		for(;;)
		{
			for(e=0; e<self.pg.size; e++)
			{
				icon = self.pg[e];
				level.icontest = icon;
			}
			wait .5;
		}
	}
	_prest(e)
	{
		self.pg = [];
		self.pg [0]    = "rank_comm1" ;  	       			//  == level.input["prestige"][0]  = 0 ; 
		self.pg [1]    = "rank_prestige1";   	   			//  == level.input["prestige"][1]  = 1 ;
		self.pg [2]    = "rank_prestige2";   	   			//  == level.input["prestige"][2]  = 2 ;
		self.pg [3]    = "rank_prestige3";   	   			//  == level.input["prestige"][3]  = 3 ;
		self.pg [4]    = "rank_prestige4";   	   			//  == level.input["prestige"][4]  = 4 ;
		self.pg [5]    = "rank_prestige5";   	   			//  == level.input["prestige"][5]  = 5 ;
		self.pg [6]    = "rank_prestige6";   	   			//  == level.input["prestige"][6]  = 6 ;
		self.pg [7]    = "rank_prestige7";   	   			//  == level.input["prestige"][7]  = 7 ;
		self.pg [8]    = "rank_prestige8";   	   			//  == level.input["prestige"][8]  = 8 ;
		self.pg [9]    = "rank_prestige9";   	   			//  == level.input["prestige"][9]  = 9 ;
		self.pg [10    = "rank_prestige10_02";   			//  == level.input["prestige"][10] = 10;
		self.pg [11    = "rank_prestige11" ;   				//  == level.input["prestige"][11] = 11;
											   					 		//  level.icontest = (self.pg[i]);
											   					 		//  level.icontest = i+self.pg[PickedNum];										  
		//level.icontest = i; 	
		//self.pg[i] = i;
	}*/
	_prest(i)
	{
		for(;;)
		{
			if(i == level.input["prestige"][0])
			{ 
				level.icontest = "rank_comm1";
			} 
			if(i == level.input["prestige"][1])
			{ 
				level.icontest = "rank_prestige1";
			} 
			if(i == level.input["prestige"][2])
			{ 
				level.icontest = "rank_prestige2";
			} 
			if(i == level.input["prestige"][3])
			{ 
				level.icontest = "rank_prestige3";
			} 
			if(i == level.input["prestige"][4])
			{ 
				level.icontest = "rank_prestige4";
			} 
			if(i == level.input["prestige"][5])
			{ 
				level.icontest = "rank_prestige5";
			} 
			if(i == level.input["prestige"][6])
			{ 
				level.icontest = "rank_prestige6";
			} 
			if(i == level.input["prestige"][7])
			{ 
				level.icontest = "rank_prestige7";
			}
			if(i == level.input["prestige"][8])
			{ 
				level.icontest = "rank_prestige8";
			} 
			if(i == level.input["prestige"][9])
			{ 
				level.icontest = "rank_prestige9";
			} 
			if(i == level.input["prestige"][10])
			{ 
				level.icontest = "cardicon_prestige10_02";
			} 
			if(i == level.input["prestige"][11])
			{ 
				level.icontest = "rank_prestige11";
			}  
			//else

			wait .5;
		}	

		// i =  "rank_prestige1";   
		// i =  "rank_prestige2";   
		// i =  "rank_prestige3";   
		// i =  "rank_prestige4";   
		// i =  "rank_prestige5";   
		// i =  "rank_prestige6";   
		// i =  "rank_prestige7";   
		// i =  "rank_prestige8";   
		// i =  "rank_prestige9";   
		// i =  "rank_prestige10_02";
		// i =  "rank_prestige11";
	}	
	
	presMessage(pres, i)
	{
		notifyData = spawnstruct();
		notifyData.notifyText = pres;
		notifyData.glowColor = (1,0,0);// ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));//(1.0, 0.5, 0.0); 
		notifyData.duration = 5;
		notifyData.notifyText.sort = 5;
		//level.icontest = i;
		notifyData.iconName = level.icontest;

		self playLocalSound( "mp_level_up" );
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		wait 1;
	}

// Toggle Walking AC130
	ToggleWalkingAC130(button)
	{
		self endon("disconnect");
		self endon( "death" );

		_killAc130();
		thread keod(self.walkAc);
		thread keod(self.WAC130);

		self.walkAc = createfontString("objective", 1);
		x = -325; y = 75; self.walkAc setPoint("center", "center", x, y);
		self.walkAc setText("Press [{+actionslot 1}] To ^5Toggle^7\n [{+actionslot 3}] To ^1Stop");

		for(;;)
		{
			self waittill("buttonPress", button);
			if(button=="D")
			{
				if(!self.WAC130)
				{
					thread doGod();
					self.WAC130=1;
					self thread AddAmmo();
					self ThermalVisionFOFOverlayOn();
					self thread WalkAC130();
					self iprintln("^3Walking AC130 ^7[^2ON^7]");
				}
				else
				{
					thread endGod();
					self notify("StopWalkAC");
					self iprintln("^3Walking AC130 ^7[^2OFF^7]");
					self ThermalVisionFOFOverlayOff();
					self takeWeapon("ac130_105mm_mp");
					self takeWeapon("ac130_40mm_mp");
					self takeWeapon("ac130_25mm_mp");
					self switchToWeapon(self.weapTemp);
					self.weapTemp = "";
					self.WAC130 = 0;
				}
			}

			if(button=="K")
			{
					thread endGod();
					self notify("StopWalkAC");
					self iprintln("^1Stopped");
					self ThermalVisionFOFOverlayOff();
					self takeWeapon("ac130_105mm_mp");
					self takeWeapon("ac130_40mm_mp");
					self takeWeapon("ac130_25mm_mp");
					self switchToWeapon(self.weapTemp);
					self.weapTemp = "";
					self.WAC130 = 0;
					self.walkAc destroy();
					self.walkAc = undefined;
					return;	
			}
				
		}
	}
	_killAc130()
	{
		self notify("StopWalkAC");
		//self iprintln("[OFF]");
		self ThermalVisionFOFOverlayOff();
		self takeWeapon("ac130_105mm_mp");
		self takeWeapon("ac130_40mm_mp");
		self takeWeapon("ac130_25mm_mp");
		self switchToWeapon(self.weapTemp);
		self.weapTemp = "";
		self.WAC130 = 0;
		self.walkAc destroy();
		self.walkAc = undefined;
	}
	WalkAC130()
	{
		self endon("disconnect");
		self endon("death");
		self endon("StopWalkAC");
		self.weapTemp="";
		for(;;)
		{
			C=self getCurrentWeapon();
			if(self.weapTemp=="")self.weapTemp=self getCurrentWeapon();
			if(C!="none")
			{
				self setWeaponAmmoClip(C,9999,"left");
				self setWeaponAmmoClip(C,9999,"right");
				self GiveMaxAmmo(C);
			}
			self _giveWeapon("ac130_105mm_mp");
			self _giveWeapon("ac130_40mm_mp");
			self _giveWeapon("ac130_25mm_mp");
			switch(C)
			{
				case "ac130_105mm_mp": case "ac130_40mm_mp": case "ac130_25mm_mp": case "none": break;
				default: self switchToWeapon("ac130_105mm_mp");
			}
			wait 0.05;
		}
	}
	AddAmmo()
	{
			self endon ( "disconnect" );
	        self endon ( "death" );

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
	                wait 0.05;
	        }
	}
	
/* -- Dump ---------------------------------------------- */
	// Draft bots
		DaftBots() 
		{
		//Created By x_DaftVader_x
		    self endon("death");
		    self endon("disconnect");
			self setClientDvar("testClients_doMove","1");
			self setClientDvar("testClients_doAttack","1");
		   streakName="airdrop";
		   team = self.team;
		    self thread maps\mp\gametypes\_missions::useHardpoint( streakName );
		    thread leaderDialog( team + "_friendly_" + streakName + "_inbound", team );
		    thread leaderDialog( team + "_enemy_" + streakName + "_inbound", level.otherTeam[ team ] );
		    thread teamPlayerCardSplash("used_airdrop_mega", self);
		    o = self;
		    sn = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
		    hO = sn.origin;
		    hA = sn.angles;
		    lb = spawnHelicopter(o, hO, hA, "cobra_mp", "vehicle_mi24p_hind_mp");
		    if (!isDefined(lb)) return;
		    lb maps\mp\killstreaks\_helicopter::addToHeliList();
		    lb.zOffset = (0, 0, lb getTagOrigin("tag_origin")[2] - lb getTagOrigin("tag_ground")[2]);
		    lb.team = o.team;
		    lb.attacker = undefined;
		    lb.lifeId = 0;
		    lb.currentstate = "ok";
		    lN = level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];
		      lb maps\mp\killstreaks\_helicopter::heli_fly_simple_path(sn);
		 lb Vehicle_SetSpeed(1000, 16);
		        lb setVehGoalPos(self.origin + (851, 0, 1000), 1);

		    w(6);self thread BotEscort(lb);w(6);
		    lb thread lu(1);self notify("nomorebots");
		}
		BotEscort(lb)
		{
			self endon("disconnect");
			   level.botorigin = lb.origin;level.botorigin2=self.origin;
			   for(;;){self endon("nomorebots");
			self thread MyBot(1);wait 0.9;
			}
		}

		MyBot(bodyguards)
		{
		        myteam=self.team;
		        for(i = 0; i < bodyguards; i++)
		        {
		                ent[i] = addtestclient();

		                if (!isdefined(ent[i]))
		                {
		                        w(0.11);
		                        continue;
		                }

		                ent[i].pers["isBot"] = true;
		                ent[i] thread botspawn(myteam);
		                w(0.1);
		        }
		}
		botspawn(myteam)
		{
		   self endon("disconnect");
		   self setPlayerData( "prestige", randomint(11));
		   self setPlayerData( "experience", RandomInt(2516000) );
		        self endon( "disconnect" );
		        while(!isdefined(self.pers["team"]))
		                w(.05);
		        self notify("menuresponse", game["menu_team"], myteam);
		        w(0.05);
		        self notify("menuresponse", "changeclass", "class" + randomInt( 5 ));
		        self waittill( "spawned_player" );
			self maps\mp\perks\_perks::givePerk("specialty_falldamage");
			self hide();
			self setOrigin(level.botorigin);
			w(1);
			self show(); 
		}
		lu(T) 
		{
		    self endon("death");
		    self endon("helicopter_done");
		    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(T);
		    self thread ae();
		}
		ae() 
		{
		    self notify("leaving");
		    lN = level.heli_leave_nodes[randomInt(level.heli_leave_nodes.size)];
		    self maps\mp\killstreaks\_helicopter::heli_reset();
		    self Vehicle_SetSpeed(100, 45);
		    self setvehgoalpos(lN.origin, 1);
		    self waittillmatch("goal");
		    self notify("death");
		    w(.05);
		    self delete();
		}
		w(V) {
		    wait(V);
		}
	
	// Unknown
		/*ShootLBJavi(owner)
		{
			self endon("death");
				//self endon("helicopter_done");
				//self endon("crashing");
				//self endon("leaving");
				//level endon("game_ended");

			waittime = 13;

			for(;;)
			{
				wait(waittime);
				AimedPlayer=undefined;
				foreach(player in level.players)
				{
					if((player == owner) || (!isAlive(player)) || ( level.teamBased && owner.pers["team"] == player.pers["team"] ) || (!bulletTracePassed(self getTagOrigin( "tag_origin" ), player getTagOrigin( "back_mid" ), 0, self)))	continue;
					
					if(isDefined( AimedPlayer ))
					{
						if(closer(self getTagOrigin("tag_origin"),player getTagOrigin("back_mid"),AimedPlayer getTagOrigin("back_mid")))AimedPlayer=player;
					}
					else
					{
						AimedPlayer = player;
					}
				}

				if(isDefined(AimedPlayer))
				{
					AimLocation = (AimedPlayer getTagOrigin( "back_mid" ));
					Angle = VectorToAngles(AimLocation - self getTagOrigin( "tag_origin" ));

					MagicBullet( "javelin_mp", self getTagOrigin("tag_origin") - (0, 0, 180), AimLocation, owner);
					wait 1;
					MagicBullet( "javelin_mp", self getTagOrigin( "tag_origin" ) - (0, 0, 180), AimLocation, owner);
					
				}
			}
		}*/
/* ------------------------------------------------------ */
	/* Glow Colors:
		0.5, 0.0, 0.8 - Sexxy purple
		1.0, 0.0, 0.0 - Epic Red
		1.0, 0.0, 0.4 - Preppy Pink
		0.0, 0.8, 0.0 - Epic Green
		0.9, 1.0, 0.0 - Banana Yellow
		1.0, 0.5, 0.0 - Burnt Orange
		0.0, 0.5, 1.0 - Turquoise
		0.0, 0.0, 1.0 - Deep Blue
		0.3, 0.0, 0.3 - Deep Purple
		0.0, 1.0, 0.0 - Light Green
		0.5, 0.0, 0.2 - Maroon
		0.0, 0.0, 0.0 - Black
		1.0, 1.0, 1.0 - White
		0.0, 1.0, 1.0 - Cyan
		0.3, 0.6, 0.3 - Default 
		*/

	// Fix force field toggle
	// clear text menu option
	// text menu toggles
	// fix kill text


	/* ------------------------------------------------------ */
	/* Credits - 
	    Special Thanks to:

	        ダフティ for assisting me

	    Patch Developed by: Random Guy 70hz					  */
	/* ------------------------------------------------------ */

	/* Dump:
	 // DANGEROUS SCRIPT; BE FOREWARNED; WILL FUCK UP EVERYTHING (will need to delete "players" folder in game folder and restart game)
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


		//x[0] = i[0];
			//x[1] = i[1];
			//x[2] = i[2];
			//x[3] = i[3];
			//x[4] = i[4];
			//x[5] = i[5];
			//x[6] = i[6];
			//x[7] = i[7];
			//x[8] = i[8];
			//x[9] = i[9];
			//x[10]= i[10];
			//x[11]= i[11];

			//level.input["prestige"][0] = x[0]   
			//level.input["prestige"][1] = x[1]  
			//level.input["prestige"][2] = x[2]   
			//level.input["prestige"][3] = x[3]   
			//level.input["prestige"][4] = x[4]   
			//level.input["prestige"][5] = x[5]  
			//level.input["prestige"][6] = x[6]   
			//level.input["prestige"][7] = x[7]   
			//level.input["prestige"][8] = x[8]   
			//level.input["prestige"][9] = x[9]  
			//level.input["prestige"][10] = x[10] 
			//level.input["prestige"][11] = x[11] 
			//for(x=i; ; x++)
			//{
				//level.icontest = x;
			//}
		*/

