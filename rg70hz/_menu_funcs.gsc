/*
	To inlcude:
		- Main menu
		- Account Menu
		- Fun Menu 
		- Menu Settings
		- Vip
		- Admin
		- Host
		  - gametype
		  - gamemode
		 	 - zombies
		 	 - rpg
		  - Player Menu
*/

// include headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;

	// rg70hz  headers
	#include rg70hz\_main;
	#include rg70hz\_game_menu_funcs;
	#include rg70hz\_hud_util_funcs;
	#include rg70hz\_hud_funcs;


// menu functions
iniMenu()
{
	level.title["main"] = "Main Menu";
		level.names["main"] = [];
				level.names["main"][0] = "Sub Menu 1";
				level.names["main"][1] = "Fun Menu";
				level.names["main"][2] = "Self Menu";
				level.names["main"][3] = "Visions";
				level.names["main"][4] = "Players"; // player menu
		level.funcs["main"] = [];
				level.funcs["main"][0] = ::menuOpen;
				level.funcs["main"][1] = ::menuOpen;
				level.funcs["main"][2] = ::menuOpen;
				level.funcs["main"][3] = ::menuOpen;
				level.funcs["main"][4] = ::menuOpen; // player menu
		level.input["main"] = [];
				level.input["main"][0] = "sub1|main";
				level.input["main"][1] = "sub2|main";
				level.input["main"][2] = "sub3|main";
				level.input["main"][3] = "visions|main";
				level.input["main"][4] = "players|main"; // player menu

	level.title["sub1"] = "Sub Menu 1";
		level.names["sub1"] = [];
				level.names["sub1"][0] = "Teleport All";
				level.names["sub1"][1] = "Spawn x1 Bots";
				level.names["sub1"][2] = "Spawn x3 Bots";
				level.names["sub1"][3] = "Spawn x5 Bots";
				level.names["sub1"][4] = "Show Health bar";
				level.names["sub1"][5] = "Text Menu" ;// check for errors
		level.funcs["sub1"] = [];
				level.funcs["sub1"][0] = ::Teleport2;
				level.funcs["sub1"][1] = ::initTestClients;
				level.funcs["sub1"][2] = ::initTestClients;
				level.funcs["sub1"][3] = ::initTestClients;
				level.funcs["sub1"][4] = ::toggleHealthBar;
				level.funcs["sub1"][5] = ::menuOpen; // check for errors
		level.input["sub1"] = [];
				level.input["sub1"][0] = "";
				level.input["sub1"][1] = 1;
				level.input["sub1"][2] = 3;
				level.input["sub1"][3] = 5;
				level.input["sub1"][4] = self.input;
				level.input["sub1"][5] = "subsub1|sub1"; // name, parent

	level.title["subsub1"] = "Advertising Menu";	// maybe add to host menu and a foreach function // advertising menu in host menu?
		level.names["subsub1"] = [];
				level.names["subsub1"][0] = "Text";
				level.names["subsub1"][1] = "Kill Text";
				level.names["subsub1"][2] = "Spinning Text";
				level.names["subsub1"][3] = "^:3D ^7Text";
				level.names["subsub1"][4] = "Test";
				level.names["subsub1"][5] = "Test" ;// check for errors
		level.funcs["subsub1"] = [];
				level.funcs["subsub1"][0] = ::doTxt;
				level.funcs["subsub1"][1] = ::spamText;
				level.funcs["subsub1"][2] = ::doSpinningText;
				level.funcs["subsub1"][3] = ::tDText;
				level.funcs["subsub1"][4] = ::test;
				level.funcs["subsub1"][5] = ::test; // check for errors

		level.input["subsub1"] = [];
				level.input["subsub1"][0] = "";
				level.input["subsub1"][1] = "";
				level.input["subsub1"][2] = "";
				level.input["subsub1"][3] = "";
				level.input["subsub1"][4] = "";
				level.input["subsub1"][5] = ""; // check for errors

	level.title["sub2"] = "Fun Menu";
			level.names["sub2"] = [];
				level.names["sub2"][0]  = "Set On Fire";
				level.names["sub2"][1]  = "God Mode";
				level.names["sub2"][2]  = "Force Field";
				level.names["sub2"][3]  = "Suicide";
				level.names["sub2"][4]  = "Unfair Aimbot";
				level.names["sub2"][5]  = "Auto Drop Shot";
				level.names["sub2"][6]  = "Infinite Ammo";
				level.names["sub2"][7]  = "No Recoil";
				level.names["sub2"][8]  = "Earth Quake";
				level.names["sub2"][9]  = "Invisible";
				level.names["sub2"][10] = "Pet Pavelow";
				level.names["sub2"][11] = "Text Menu"; //javirain  LockMenu()
				level.names["sub2"][12] = "Bleed Money";

		level.funcs["sub2"] = [];
				level.funcs["sub2"][0] = ::FireOn;
				level.funcs["sub2"][1] = ::toggleGods;
				level.funcs["sub2"][2] = ::field;
				level.funcs["sub2"][3] = ::killSelf;
				level.funcs["sub2"][4] = ::autoAim;
				level.funcs["sub2"][5] = ::toggleDS;
				level.funcs["sub2"][6] = ::doAmmo;
				level.funcs["sub2"][7] = ::noRecoilToggle;
				level.funcs["sub2"][8] = ::doQuake;
				level.funcs["sub2"][9] = ::invis;
				level.funcs["sub2"][10] = ::spawnPavelow;
				level.funcs["sub2"][11] = ::menuOpen;
				level.funcs["sub2"][12] = ::toggleBM;

		level.input["sub2"] = [];
				level.input["sub2"][0] =  "";
				level.input["sub2"][1] =  "";
				level.input["sub2"][2] =  "";
				level.input["sub2"][3] =  "";
				level.input["sub2"][4] =  "";
				level.input["sub2"][5] =  "";
				level.input["sub2"][6] =  "";
				level.input["sub2"][7] =  "";
				level.input["sub2"][8] =  "";
				level.input["sub2"][9] =  "";
				level.input["sub2"][10] = "";
				level.input["sub2"][11] = "subsub1|sub2";
				level.input["sub2"][12] = "";


	level.title["sub3"] = "Self Menu";
		level.names["sub3"] = [];
				level.names["sub3"][0] = "^1Derank^7";
				level.names["sub3"][1] = "Level ^370^7";
				level.names["sub3"][2] = "Unlock All";
				level.names["sub3"][3] = "^1Suicide^7";
				level.names["sub3"][4] = "Fast Restart";
				level.names["sub3"][5] = "End Game";
				level.names["sub3"][6] = "^6Visions ^7Menu";
				//level.names["sub3"][7] = "^1Restart ^7Map";
		level.funcs["sub3"] = [];
				level.funcs["sub3"][0] = ::doUnStats;
				level.funcs["sub3"][1] = ::doLvl70;
				level.funcs["sub3"][2] = ::completeAllChallenges;
				level.funcs["sub3"][3] = ::killPlayer;
				level.funcs["sub3"][4] = ::fastRst;
				level.funcs["sub3"][5] = ::endGme;
				level.funcs["sub3"][6] = ::menuOpen; 
				//level.funcs["sub3"][7] = ::slowRst;
		level.input["sub3"] = [];
				level.input["sub3"][0] = "";
				level.input["sub3"][1] = "";
				level.input["sub3"][2] = "";
				level.input["sub3"][3] = "";
				level.input["sub3"][4] = "";
				level.input["sub3"][5] = "";
				level.input["sub3"][6] = "visions|sub3";
				//level.input["sub3"][7] = "";

	level.title["visions"] = "Visions";
			level.names["visions"] = []; 
				level.names["visions"][0] = "Blackout";
				level.names["visions"][1] = "Thermal";
				level.names["visions"][2] = "Nuke";
				level.names["visions"][3] = "Black Test ";
				level.names["visions"][4] = "AC 130 Inverted";
				level.names["visions"][5] = "Cobra Sunset";
				level.names["visions"][6] = "End Game";
				level.names["visions"][7] = "EMP";
				level.names["visions"][8] = "Grayscale";
				level.names["visions"][9] = "Strike";
				level.names["visions"][10] = "Armada Water";
				level.names["visions"][11] = "School";
				level.names["visions"][12] = "^1Reset";
				level.names["visions"][13] = "Main Menu";
			level.funcs["visions"] = [];
				level.funcs["visions"][0] = ::Vis; 
				level.funcs["visions"][1] = ::Vis; 
				level.funcs["visions"][2] = ::Vis; 
				level.funcs["visions"][3] = ::Vis; 
				level.funcs["visions"][4] = ::Vis; 
				level.funcs["visions"][5] = ::Vis; 
				level.funcs["visions"][6] = ::Vis; 
				level.funcs["visions"][7] = ::Vis; 
				level.funcs["visions"][8] = ::Vis; 
				level.funcs["visions"][9] = ::Vis;
				level.funcs["visions"][10] = ::Vis; 
				level.funcs["visions"][11] = ::Vis; 
				level.funcs["visions"][12] = ::Vis; 
				level.funcs["visions"][13] = ::menuOpen;
			level.input["visions"] = [];
				level.input["visions"][0]  = "blackout";
				level.input["visions"][1]  = "thermal_mp";
				level.input["visions"][2]  = "mpnuke";
				level.input["visions"][3]  = "blacktest";
				level.input["visions"][4]  = "ac130_inverted";
				level.input["visions"][5]  = "cobra_sunset3";
				level.input["visions"][6]  = "end_game";
				level.input["visions"][7]  = "dcemp_emp";
				level.input["visions"][8]  = "grayscale";
				level.input["visions"][9]  = "strike";
				level.input["visions"][10] = "armada_water";
				level.input["visions"][11] = "school";
				level.input["visions"][12] = getDvar("mapname"); //"mapname";
				level.input["visions"][13] = "main";

	thread playerMenu(); 
}

/*playerOptions(player)
{
	// player options menu
		level.title["playerOptions"] = "Options"; 
		
		level.names["playerOptions"] = [];
		level.funcs["playerOptions"] = [];
		level.input["playerOptions"] = [];
		//
		level.names["playerOptions"][0] = "^7Kick ^7"+player;
		level.names["playerOptions"][1] = "^7Kill ^7"+player;
		level.names["playerOptions"][2] = "^7Give "+player+ "^7 Money^7";
		level.names["playerOptions"][3] = "^7Show "+player+"^7`s GUID^7";
			
		level.funcs["playerOptions"][0] = ::kickPlayer; // player options menu
		level.funcs["playerOptions"][1] = ::killPlayer;
		level.funcs["playerOptions"][2] = ::BleedMoney;
		level.funcs["playerOptions"][3] = ::ShowGUID;
		
		level.input["playerOptions"][0] = player;//level.players[i]; 
		level.input["playerOptions"][1] = player;//level.players[i];
		level.input["playerOptions"][2] = player;//level.players[i];
		level.input["playerOptions"][3] = player;//level.players[i];
}*/

playerMenu()
{
	self endon("disconnect");
	self endon("death");

	level.title["players"] = "Players";
	level.names["players"] = [];
	level.funcs["players"] = [];
	level.input["players"] = [];
	
	for(;;)
	{
		
		for (i=0; i<level.players.size; i++)
		{
			player = level.players[i].name;
			p = getTrueName();

			// player menu
			level.names["players"][i] = "^7"+player + "^7 ^6>>^7"; // level.players.size-1
			level.funcs["players"][i] = ::menuOpen; //level.names[name].size-1//
			level.input["players"][i] = "playerOptions|players";// name, parent
			
			// player options menu
			level.title["playerOptions"] = "Options"; 
			level.names["playerOptions"] = [];
			level.funcs["playerOptions"] = [];
			level.input["playerOptions"] = [];
			//
			level.names["playerOptions"][0] = "^7Kick ^7";
			level.names["playerOptions"][1] = "^7Kill ^7";
			level.names["playerOptions"][2] = "^7Give Money^7";
			level.names["playerOptions"][3] = "^7Show ^7GUID^7";
			level.names["playerOptions"][4] = "^7Set on Fire^7";
			level.names["playerOptions"][5] = "^7Teleport Player^7";
			level.names["playerOptions"][6] = "^7Set Fire For Game^7";
			level.names["playerOptions"][7] = "^7Send To Space^7";
			level.names["playerOptions"][8] = "^7God Mode^7";
			level.names["playerOptions"][9] = "^7Force Field^7";
			level.names["playerOptions"][10] = "^7Javi ^:Rain^7";
			level.names["playerOptions"][11] = "^7Invisibility^7";
			level.names["playerOptions"][12] = "^7Show Health Bar^7"; 

			level.funcs["playerOptions"][0] = ::kickPlayer; // player options menu
			level.funcs["playerOptions"][1] = ::killPlayer;
			level.funcs["playerOptions"][2] = ::toggleBM;
			level.funcs["playerOptions"][3] = ::ShowGUID;
			level.funcs["playerOptions"][4] = ::FireOn;
			level.funcs["playerOptions"][5] = ::Teleport3;
			level.funcs["playerOptions"][6] = ::toggleFire;
			level.funcs["playerOptions"][7] = ::sendToSpace;
			level.funcs["playerOptions"][8] = ::toggleGod;
			level.funcs["playerOptions"][9] = ::toggleField; 
			level.funcs["playerOptions"][10] = ::javiRain;
			level.funcs["playerOptions"][11] = ::invis;
			level.funcs["playerOptions"][12] = ::toggleHealthBar;

			level.input["playerOptions"][0]  = level.players[i]; 
			level.input["playerOptions"][1]  = level.players[i];
			level.input["playerOptions"][2]  = level.players[i];
			level.input["playerOptions"][3]  = level.players[i];
			level.input["playerOptions"][4]  = level.players[i];
			level.input["playerOptions"][5]  = level.players[i];
			level.input["playerOptions"][6]  = level.players[i];
			level.input["playerOptions"][7]  = level.players[i];
			level.input["playerOptions"][8]  = level.players[i];
			level.input["playerOptions"][9]  = level.players[i];
			level.input["playerOptions"][10] = level.players[i];
			level.input["playerOptions"][11] = level.players[i];
			level.input["playerOptions"][12] = level.players[i];

		}wait .3; 
	}
}

iniMenuSelf()
{
	// events & variables	
		self endon("disconnect");
		self.menuOpen = false;

	// menu title text
		self.tText = createFontString("hudBig", 1.5); // Menu title text // 1.3
		self.tText setPoint("LEFT", "CENTER", 160, -200); // -390 //-320, 200
		self.tText.foreGround = true;
		self.tText.sort = 3;

	// menu options text
		self.mText = createfontString("default", 2.0); // Menu options text
		self.mText setPoint("LEFT", "CENTER", 110, -150); // -390 // -320, -150
		self.mText.foreGround = true;
		self.mText.sort = 3;

	// left menu small border
	    		 //	  createShad(   point,   rPoint,     x,    y,  width, height, elem,    			 colour,  		alpha, sort)
		self.leftP0 = createShad ("TOPLEFT", "LEFT",    -60,  160,  225,    90, "cardtitle_248x48",  (0.0, 0.8, 0.0),  0.3, -1000 ); // main background
		self.leftP0.alpha = 0;

	// menu controls text
		self.iText = createFontString("objective", 1.3); // open menu text
		self.iText setPoint("RIGHT", "CENTER", -240, -50); // 390 // 340, -190
		self.iText.foreGround = true;
		self.iText.sort = 3;

	// random text at bottom
		/*self.top_text = self createFontString( "hudBig", 0.7 );
	    self.top_text setPoint( "RIGHT", "RIGHT",   -50, 230 );
	    self.top_text setText ( "^:Veni^7, ^:Vidi^7, ^:Vici^7" );
	    self.top_text.sort = 1;
	    self.top_text.alpha = 0;*/

	//  main menu backgrounds
	    		 //	  createShad(  point,  rPoint,  x,   y, width, height, elem,   colour,  alpha, sort)
		self.menuBG =  createShad("LEFT", "CENTER", 800, 0, 500, 1000, "white",   (0.0, 0.8, 0.0), 0.3, -1); // background
		self.menuBG2 =  createShad("LEFT", "CENTER", 800, 60, 300, 400, "black",  (0.0, 0.8, 0.0), 0.4, 1); // foreground

		self.menuBG1 =  createShad("LEFT", "CENTER", 800, 0, 2, 1000, "black", undefined, undefined, 1); // 

	// scroll bar
		self.menuFG =   createShad("LEFT",   "CENTER",  400,   100,   400,   20,    "white",  (0.0, 0.8, 0.0), 1, 2); // scroll bar
		self.menuFG.alpha = 0;

	// main loop
		for(;;) 
		{
			self waittillmatch("buttonPress", "Left");
			if(!self.menuOpen)
			{
				self giveWeapon("killstreak_ac130_mp");
				self switchToWeapon("killstreak_ac130_mp");
				wait 1;
				self freezeControls(true);
				//self VisionSetNakedForPlayer ( "contingency_thermal_inverted", 2.5 );
				self setBlurForPlayer( 4, 0.2 ); 

				self.menuBG elemMove(0.5, 400);  // bring menu into frame
				self.menuBG1 elemMove(0.5, 400);
				self.menuBG2 elemMove(0.5, 410);

				self.leftP0 elemFade(0.2, 0.5); // fade menu into frame
				self.menuFG elemFade(0.5, 0.5);
				self.top_text elemFade(0.5, 1);

				thread monitorDeath();
				thread runMenu("main"); 
			} else //self iPrintln("^0null^7");
			wait  .3;
		}
}

runMenu(name, parent)
{
	// events
	self endon("death");
	self endon("exit_menu");
	self endon("disconnect");

	// variables
	self.cursPos = 0;
	self.menuOpen = true;
	self.tText setText(level.title[name]);

	// parent conditions	
	if(isDefined(parent) && parent != "none") // while in sub menu
	{
		self.subOpen = true;
		self.parent = parent;
		self.iText setText("^:[{+forward}][{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Return^7");
	}
	else // while in main menu
	{
		self.subOpen = false;
		self.parent = "none";
		self.iText setText( "^:[{+forward}][{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Exit ^7Menu" );
	}

	// main loop
	for(;;)
	{
		string = "";
		for(i=0; i<level.names[name].size; i++)
		{	
			string += level.names[name][i] + "\n";
			if(self.cursPos == i)
			{
				self.menuFG moveOverTime(0.1); // scroll bar
				self.menuFG.y = i*24+82; // scroll bar
			}
		} self.mText setText(string);

	//button monitor
		self waittill("buttonPress", button); // button monitor
		if(button=="Up") 	// scroll up
		{
			self.cursPos--;
			self playLocalSound("mouse_over"); // check for error
			if(self.cursPos<0) self.cursPos = level.names[name].size-1;
		}
		if(button=="Down")  // scroll down
		{
			self.cursPos++;
			self playLocalSound("mouse_over"); // check for error
			if(self.cursPos>level.names[name].size-1) self.cursPos = 0;
		}
		if(button=="S") 	// select option 
		{
			self thread [[level.funcs[name][self.cursPos]]](level.input[name][self.cursPos]);
			//
		} 
		if(button=="Right") // exit selection
		{
			if(self.subOpen) self thread menuOpen(self.parent);
			else
			{
				self.tText setText(""); // Menu title text
				self.mText setText(""); // menu options text
				self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // left screen text
				
				self.menuBG  elemMove(0.5, (0+0)+1000); // go off screen on menu close
				self.menuBG1 elemMove(0.5, (0+0)+1000); // time, pos
				self.menuBG2 elemMove(0.5, (0+0)+1000);

				self.leftP0 elemFade(0.2, 0); // fade off screen when menu closed
				self.menuFG   elemFade(0.5, 0);
				self.top_text elemFade(0.5, 0); // time, alpha
				

				self switchToWeapon(self getLastWeapon());
				self freezeControls(false);
				//self visionSetNakedForPlayer(getDvar("mapname"), 1.5);
				self setBlurForPlayer( 0, 0.2 );
				self.menuOpen = false;
				self.pMenuOpen = false; //
				self notify("exit_menu");
			}
		}
		if(button=="V") // exit menu
		{
			self.tText setText("");
			self.mText setText("");
			self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // switch to +leanleft
			
			self.menuBG elemMove(0.5, (0+0)+1000); // go off screen on menu close
			self.menuBG1 elemMove(0.5, (0+0)+1000); // time, pos
			self.menuBG2 elemMove(0.5, (0+0)+1000);

			self.leftP0 elemFade(0.2, 0); // fade off screen when menu closed
			self.menuFG elemFade(0.5, 0);
			self.top_text elemFade(0.5, 0); // time, alpha
			

			self switchToWeapon(self getLastWeapon());
			self freezeControls(false);
			//self visionSetNakedForPlayer(getDvar("mapname"), 1.5);
			self setBlurForPlayer( 0, 0.2 );
			self.menuOpen = false;
			self notify("exit_menu");
		} wait .2; // 
	} // end main loop
}


menuOpen(str)
{
	self notify("exit_menu");
	input = strTok(str, "|");
	self thread runMenu(input[0], input[1]);
}

elemFade(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

elemMove(time, input)
{
	self moveOverTime(time); 
	self.x = input;
}

monitorDeath()
{
	self waittill("death");
	self.menuOpen = false;
	self.tText setText("");
	self.mText setText("");
	self.menuBG.x = (0+0)+1000; // (0+0)+1000) //(-320+385)-385 // go here on death
	self.menuBG1.x = (0+0)+1000; //
	self.menuBG2.x = (0+0)+1000; //
	self.menuFG.alpha = 0;
	self.leftP0.alpha = 0;
	self.top_text.alpha = 0;
}

monitorButtons()
{
	buttons = strTok( "Up|+forward,Down|+back,Left|+leanleft,Right|+leanright,S|+gostand,V|+melee,Att|+attack,F|+use", ","	); //
	foreach(button in buttons)
	{
		btn = strTok(button, "|");
		self thread monitorActions(btn[0], btn[1]);
	}
}

monitorActions(button, action)
{
	self endon("disconnect");
	self notifyOnPlayerCommand(button, action);
	for(;;)
	{
		self waittillmatch(button);
		self notify("buttonPress", button);
		level thread monitorButtons( ::updateMenu, "connected" ); // check maybe not needed
		wait .3;
	}
}

// test functions beginning
updateMenu() 
{
	//drawMenu(self.cycle, self.scroll);
	runMenu(self.cursPos);
}
// test function end
//end of menu functions


// self setBlurForPlayer( 0, 0.2 ); // on close
// self setBlurForPlayer( 4, 0.2 ); // on open
// self iPrintLn("GUID: " + self getGuid());

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
/* ------------------------------------------------------ */


/* ------------------------------------------------------ */
/* Code Dump

	// toggle
	TestToggle()
	{
		while ( true )
		{
			if(!self.godMode)
			{
				self.godMode = true;
				self.god_mode = true;
				self thread iniGod();
				self iPrintLnBold("God Mode [^1On^7]");
			}
			else 
			{
				self.godMode = false;
				if(isDefined(self.god_mode))
				{
					self.god_mode = undefined;
					self notify("disable_god");
					self iPrintLnBold("God Mode [^1OFF^7]");

				}
			}
			wait .5;
		}
	}

	// god mode
	iniGod()
	{
		self endon ( "disconnect" );
		self endon ( "death" );
		self endon("disable_god");
		self.maxhealth = 90000;
		self.health = self.maxhealth;
			while ( true ) 
			{
				//wait .4;
				if ( self.health < self.maxhealth )
				self.health = self.maxhealth;
				wait .5;

			}
	}

	//
/* ------------------------------------------------------ */

/* ------------------------------------------------------ */
/* Developer Notes:
	- Basically the hud functions and util run in background with menu,
	  and fade in when menu opened and button pressed.

	- Really love this menu and the way it's designed
	- Neat little functions in between
	- Goal is to be as efficient as possible with as little code as possible
	- Am a beginner developer learning as I go
	- This menu function was originally found on se7ensins with no title
	- Was heavily moedified by me. Basically kept basic structure

find a way to list player names in player menu
	*/
/* ------------------------------------------------------ */