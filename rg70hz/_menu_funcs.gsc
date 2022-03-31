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
		//thread playerMenu();
		//thread _admin();
		//thread _pretigeMenu();
		//thread _host();

		level.title["main"] = "Main Menu";
			level.names["main"] = [];
					level.names["main"][0] = "Account";
					level.names["main"][1] = "Fun Menu";
					level.names["main"][2] = "Menu Colors";
					level.names["main"][3] = "Prestige Menu";
					
				if(self isHost())
				{
					level.names["main"][4] = "Host";
					level.names["main"][5] = "Admin";
					level.names["main"][6] = "Players["+level.players.size+"]";
					//level.names["main"][7] = "Visions";
				}

			level.funcs["main"] = [];
					level.funcs["main"][0] = ::menuOpen;
					level.funcs["main"][1] = ::menuOpen;
					level.funcs["main"][2] = ::menuOpen;
					level.funcs["main"][3] = ::menuOpen;
					level.funcs["main"][4] = ::menuOpen;
					level.funcs["main"][5] = ::menuOpen; // player menu
					level.funcs["main"][6] = ::menuOpen;
					//level.funcs["main"][7] = ::menuOpen;
			level.input["main"] = [];
					level.input["main"][0] = "sub3|main";      // account menu
					level.input["main"][1] = "sub2|main";      // fun menu
					level.input["main"][2] = "menucolor|main"; // color menu
					level.input["main"][3] = "prestige|main";  // prestige menu
					level.input["main"][4] = "sub1|main";      // host menu
					level.input["main"][5] = "admin|main";     // admin menu
					level.input["main"][6] = "players|main";   // player menu
					//level.input["main"][6] = "visions|main";
	
		level.title["subsub1"] = "Text Menu";
			level.names["subsub1"] = [];
					level.names["subsub1"][0] = "Zig Zag Text";
					level.names["subsub1"][1] = "Kill Text";
					level.names["subsub1"][2] = "Spinning Text";
					level.names["subsub1"][3] = "^:3D ^7Text";
					level.names["subsub1"][4] = "Test";
					level.names["subsub1"][5] = "Test" ;// check for errors
			level.funcs["subsub1"] = [];
					level.funcs["subsub1"][0] = ::doTxt;
					level.funcs["subsub1"][1] = ::spamToggle;
					level.funcs["subsub1"][2] = ::doSpinningText;
					level.funcs["subsub1"][3] = ::tdToggle;
					level.funcs["subsub1"][4] = ::test;
					level.funcs["subsub1"][5] = ::test; // check for errors
			level.input["subsub1"] = [];
					level.input["subsub1"][0] = "";
					level.input["subsub1"][1] = "";
					level.input["subsub1"][2] = "";
					level.input["subsub1"][3] = "";
					level.input["subsub1"][4] = "";
					level.input["subsub1"][5] = ""; // check for errors
		level.title["sub2"] = "Fun";
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
					level.names["sub2"][13] = "Clone Yourself";
					level.names["sub2"][14] = "^7Page 2";

			level.funcs["sub2"] = [];
					level.funcs["sub2"][0] = ::FireOn;
					level.funcs["sub2"][1] = ::toggleGods;
					level.funcs["sub2"][2] = ::field;
					level.funcs["sub2"][3] = ::killSelf;
					level.funcs["sub2"][4] = ::toggleAimbot;
					level.funcs["sub2"][5] = ::toggleDS;
					level.funcs["sub2"][6] = ::doAmmo;
					level.funcs["sub2"][7] = ::noRecoilToggle;
					level.funcs["sub2"][8] = ::doQuake;
					level.funcs["sub2"][9] = ::invis;
					level.funcs["sub2"][10] = ::spawnPavelow;
					level.funcs["sub2"][11] = ::menuOpen;
					level.funcs["sub2"][12] = ::toggleBM;
					level.funcs["sub2"][13] = ::CloneMe;
					level.funcs["sub2"][14] = ::menuOpen;

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
					level.input["sub2"][11] = "subsub1|main";
					level.input["sub2"][12] = "";
					level.input["sub2"][13] = "";
					level.input["sub2"][14] = "sub22|main";
		level.title["sub22"] = "Fun Mods: 2";
				level.names["sub22"] = [];
					level.names["sub22"][0] = "Test";
					level.names["sub22"][1] = "Flashing Player";
					level.names["sub22"][2] = "Toggle Third Person";
					level.names["sub22"][3] = "Toggle Laser";
					level.names["sub22"][4] = "Jet Pack";
					level.names["sub22"][5] = "Fountain";
					level.names["sub22"][6] = "Menu Colors";
					//level.names["sub22"][7] = "";
					//level.names["sub22"][8] = "";
					//level.names["sub22"][9] = "";
					//level.names["sub22"][10] = "";
					//level.names["sub22"][11] = "";
				level.funcs["sub22"] = [];
					level.funcs["sub22"][0] = ::test;
					level.funcs["sub22"][1] = ::ToggleFlashingPlayer;
					level.funcs["sub22"][2] = ::ToggleThirdPerson;
					level.funcs["sub22"][3] = ::ToggleLaserLight ;
					level.funcs["sub22"][4] = ::doJetPack ;
					level.funcs["sub22"][5] = ::ToggleFountain ;
					level.funcs["sub22"][6] = ::menuOpen;
					//level.funcs["sub22"][7] = :: ;
					//level.funcs["sub22"][8] = :: ;
					//level.funcs["sub22"][9] = :: ;
					//level.funcs["sub22"][10] = :: ;
					//level.funcs["sub22"][11] = :: ;
				level.input["sub22"] = [];
					level.input["sub22"][0] = "";
					level.input["sub22"][1] = "";
					level.input["sub22"][2] = "";
					level.input["sub22"][3] = "";
					level.input["sub22"][4] = "";
					level.input["sub22"][5] = "";
					level.input["sub22"][6] = "menucolor|main";
					//level.input["sub22"][7] = "";
					//level.input["sub22"][8] = "";
					//level.input["sub22"][9] = "";
					//level.input["sub22"][10] = "";
					//level.input["sub22"][11] = "";
		level.title["sub3"] = "Account";
			level.names["sub3"] = [];
					level.names["sub3"][0] = "Derank";
					level.names["sub3"][1] = "Level 70";
					level.names["sub3"][2] = "Unlock All";
					level.names["sub3"][3] = "Suicide";
					level.names["sub3"][4] = "Fast Restart";
					level.names["sub3"][5] = "End Game";
					level.names["sub3"][6] = "Visions Menu";
					level.names["sub3"][7] = "^:Prestige^7 Menu";
			level.funcs["sub3"] = [];
					level.funcs["sub3"][0] = ::doUnStats;
					level.funcs["sub3"][1] = ::doLvl70;
					level.funcs["sub3"][2] = ::completeAllChallenges;
					level.funcs["sub3"][3] = ::killSelf;
					level.funcs["sub3"][4] = ::fastRst;
					level.funcs["sub3"][5] = ::endGme;
					level.funcs["sub3"][6] = ::menuOpen; 
					level.funcs["sub3"][7] = ::menuOpen;
			level.input["sub3"] = [];
					level.input["sub3"][0] = "";
					level.input["sub3"][1] = "";
					level.input["sub3"][2] = "";
					level.input["sub3"][3] = "";
					level.input["sub3"][4] = "";
					level.input["sub3"][5] = "";
					level.input["sub3"][6] = "visions|main";
					level.input["sub3"][7] = "prestige|main";
	
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
		level.title["menucolor"] = "Menu Colors";
				level.names["menucolor"] = [];
					level.names["menucolor"][0]  = "Sexxy purple"; 
					level.names["menucolor"][1]  = "Epic Red";
					level.names["menucolor"][2]  = "Preppy Pink";
					level.names["menucolor"][3]  = "Epic Green";
					level.names["menucolor"][4]  = "Banana Yellow";
					level.names["menucolor"][5]  = "Burnt Orange";
					level.names["menucolor"][6]  = "Turquoise";
					level.names["menucolor"][7]  = "Deep Blue";
					level.names["menucolor"][8]  = "Deep Purple";
					level.names["menucolor"][9]  = "Light Green";
					level.names["menucolor"][10] = "Maroon";
					level.names["menucolor"][11] = "Black";
					level.names["menucolor"][12] = "White";
					level.names["menucolor"][13] = "Page 2";   

				level.funcs["menucolor"] = [];
						level.funcs["menucolor"][0]  = ::_colors;
						level.funcs["menucolor"][1]  = ::_colors;
						level.funcs["menucolor"][2]  = ::_colors;
						level.funcs["menucolor"][3]  = ::_colors;
						level.funcs["menucolor"][4]  = ::_colors;
						level.funcs["menucolor"][5]  = ::_colors;
						level.funcs["menucolor"][6]  = ::_colors;
						level.funcs["menucolor"][7]  = ::_colors;
						level.funcs["menucolor"][8]  = ::_colors;
						level.funcs["menucolor"][9]  = ::_colors;
						level.funcs["menucolor"][10] = ::_colors;
						level.funcs["menucolor"][11] = ::_colors;
						level.funcs["menucolor"][12] = ::_colors;
						level.funcs["menucolor"][13] = ::menuOpen;

				level.input["menucolor"] = [];
					level.input["menucolor"][0]  = (0.5, 0.0, 0.8);   // - Sexxy purple  
					level.input["menucolor"][1]  = (1.0, 0.0, 0.0);   // - Epic Red      
					level.input["menucolor"][2]  = (1.0, 0.0, 0.4);   // - Preppy Pink   
					level.input["menucolor"][3]  = (0.0, 0.8, 0.0);   // - Epic Green    
					level.input["menucolor"][4]  = (0.9, 1.0, 0.0);   // - Banana Yellow 
					level.input["menucolor"][5]  = (1.0, 0.5, 0.0);   // - Burnt Orange  
					level.input["menucolor"][6]  = (0.0, 0.5, 1.0);   // - Turquoise     
					level.input["menucolor"][7]  = (0.0, 0.0, 1.0);   // - Deep Blue     
					level.input["menucolor"][8]  = (0.3, 0.0, 0.3);   // - Deep Purple   
					level.input["menucolor"][9]  = (0.0, 1.0, 0.0);   // - Light Green   
					level.input["menucolor"][10] = (0.5, 0.0, 0.2);   // - Maroon        
					level.input["menucolor"][11] = (0.0, 0.0, 0.0);   // - Black         
					level.input["menucolor"][12] = (1.0, 1.0, 1.0);   // - White         
					level.input["menucolor"][13] = "menucolor2|main"; // - Page 2       	

				level.title["menucolor2"] = "Page 2";
					level.names["menucolor2"] = [];
					level.funcs["menucolor2"] = [];
					level.input["menucolor2"] = [];

					level.names["menucolor2"][0] = "Cyan";   
					level.names["menucolor2"][1] = "Default";
					level.names["menucolor2"][2] = "Random"; 
					level.names["menucolor2"][3] = "Reset";  

					level.funcs["menucolor2"][0] = ::_colors;
					level.funcs["menucolor2"][1] = ::_colors;
					level.funcs["menucolor2"][2] = ::changeColors;
					level.funcs["menucolor2"][3] = ::_colors;

					level.input["menucolor2"][0] = (0.0, 1.0, 1.0); // - Cyan   ;
					level.input["menucolor2"][1] = (0.3, 0.6, 0.3); // - Default;
					level.input["menucolor2"][2] = ""             ; // - Random ;
					level.input["menucolor2"][3] = (1.0, 0.0, 0.4); // - Reset  ;
	}
	_host()
	{
		level.title["sub1"] = "Host";
			level.names["sub1"] = [];
					level.names["sub1"][0] = "Teleport All";
					level.names["sub1"][1] = "Spawn x1 Bots";
					level.names["sub1"][2] = "Spawn x3 Bots";
					level.names["sub1"][3] = "Spawn x5 Bots";
					level.names["sub1"][4] = "Show Health bar";
					level.names["sub1"][5] = "Fun Text" ;// check for errors
					level.names["sub1"][6] = "Players";
			level.funcs["sub1"] = [];
					level.funcs["sub1"][0] = ::Teleport2;
					level.funcs["sub1"][1] = ::initTestClients;
					level.funcs["sub1"][2] = ::initTestClients;
					level.funcs["sub1"][3] = ::initTestClients;
					level.funcs["sub1"][4] = ::toggleHealthBar;
					level.funcs["sub1"][5] = ::menuOpen; // check for errors
					level.funcs["sub1"][6] = ::menuOpen;
			level.input["sub1"] = [];
					level.input["sub1"][0] = "";
					level.input["sub1"][1] = 1;
					level.input["sub1"][2] = 3;
					level.input["sub1"][3] = 5;
					level.input["sub1"][4] = self.input;
					level.input["sub1"][5] = "subsub1|main"; // name, parent
					level.input["sub1"][6] = "players|main";
	}
	_admin()
	{
		self endon("disconnect");

		level.title["admin"] = "Admin";
			level.names["admin"] = [];
			level.names["admin"][0] = "Test";
			level.names["admin"][1] = "Player";
			level.funcs["admin"] = [];
			level.funcs["admin"][0] = ::test;
			level.funcs["admin"][1] = ::menuOpen;
			level.input["admin"] = [];
			level.input["admin"][0] = "";
			level.input["admin"][1] = "players|main";
	}
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

				// player menu
				level.names["players"][i] = "^7"+ player + "^7 ^0>>^7"; // level.players.size-1
				level.funcs["players"][i] = ::menuOpen;                 //level.names[name].size-1//
				level.input["players"][i] = "playerOptions|main";       // + "playerOptions|main";// name, parent
				
				// player options menu Title
				level.title["playerOptions"] = "Options"; 

				// option names
					level.names["playerOptions"] = [];
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
					level.names["playerOptions"][13] = "^7Flash Player^7"; 
				// option functions
					level.funcs["playerOptions"] = [];
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
					level.funcs["playerOptions"][13] = ::ToggleFlashingPlayerp;
				// option inputs
					level.input["playerOptions"] = [];
					level.input["playerOptions"][0]  = player;//level.players[i]; 
					level.input["playerOptions"][1]  = player;//level.players[i];
					level.input["playerOptions"][2]  = player;//level.players[i];
					level.input["playerOptions"][3]  = player;//level.players[i];
					level.input["playerOptions"][4]  = player;//level.players[i];
					level.input["playerOptions"][5]  = player;//level.players[i];
					level.input["playerOptions"][6]  = player;//level.players[i];
					level.input["playerOptions"][7]  = player;//level.players[i];
					level.input["playerOptions"][8]  = player;//level.players[i];
					level.input["playerOptions"][9]  = player;//level.players[i];
					level.input["playerOptions"][10] = player;//level.players[i];
					level.input["playerOptions"][11] = player;//level.players[i];
					level.input["playerOptions"][12] = player;//level.players[i];
					level.input["playerOptions"][13] = player;//level.players[i];

			} wait .05; 
		}
	}
	_pretigeMenu(e)
	{
		level.title["prestige"] = "Prestige";
			level.names["prestige"] = [];
			level.names["prestige"][0] = "Prestige 0";
			level.names["prestige"][1] = "Prestige 1";
			level.names["prestige"][2] = "Prestige 2";
			level.names["prestige"][3] = "Prestige 3";
			level.names["prestige"][4] = "Prestige 4";
			level.names["prestige"][5] = "Prestige 5";
			level.names["prestige"][6] = "Prestige 6";
			level.names["prestige"][7] = "Prestige 7";
			level.names["prestige"][8] = "Prestige 8";
			level.names["prestige"][9] = "Prestige 9";
			level.names["prestige"][10] = "Prestige 10";
			level.names["prestige"][11] = "Prestige 11";

		    level.funcs["prestige"] = [];
			level.funcs["prestige"][0]  = ::_setPrestige;
			level.funcs["prestige"][1]  = ::_setPrestige;
			level.funcs["prestige"][2]  = ::_setPrestige;
			level.funcs["prestige"][3]  = ::_setPrestige;
			level.funcs["prestige"][4]  = ::_setPrestige;
			level.funcs["prestige"][5]  = ::_setPrestige;
			level.funcs["prestige"][6]  = ::_setPrestige;
			level.funcs["prestige"][7]  = ::_setPrestige;
			level.funcs["prestige"][8]  = ::_setPrestige;
			level.funcs["prestige"][9]  = ::_setPrestige;
			level.funcs["prestige"][10] = ::_setPrestige;
			level.funcs["prestige"][11] = ::_setPrestige;

			level.input["prestige"] = [];
			level.input["prestige"][0]  =  0 ; // "rank_comm1"    ;     	  	
			level.input["prestige"][1]  =  1 ; // "rank_prestige1";   
			level.input["prestige"][2]  =  2 ; // "rank_prestige2";   
			level.input["prestige"][3]  =  3 ; // "rank_prestige3";   
			level.input["prestige"][4]  =  4 ; // "rank_prestige4";   
			level.input["prestige"][5]  =  5 ; // "rank_prestige5";   
			level.input["prestige"][6]  =  6 ; // "rank_prestige6";   
			level.input["prestige"][7]  =  7 ; // "rank_prestige7";   
			level.input["prestige"][8]  =  8 ; // "rank_prestige8";   
			level.input["prestige"][9]  =  9 ; // "rank_prestige9";   
			level.input["prestige"][10]  = 10; // "rank_prestige10_02";  
			level.input["prestige"][11] =  11; // "rank_prestige11";  
	}

// draw menu functions
	iniMenuSelf()
	{
		// events & variables	
			self endon("disconnect");
			self.menuOpen = false;

		// menu title text
			self.tText = createFontString("hudBig", 1.5); // Menu title text // 1.3
			self.tText setPoint("LEFT", "CENTER", 160, -200); // -390 //-320, 200
			self.tText.foreGround = true;
			self.tText.sort = 1;

		// menu options text
			self.mText = createfontString("default", 2.0); // Menu options text
			self.mText setPoint("LEFT", "CENTER", 110, -150); // -390 // -320, -150
			self.mText.foreGround = true;
			self.mText.sort = 1;


		// left menu small border
		    		 //	  createShad(   point,   rPoint,     x,    y,  width, height, elem,    			 colour,  		alpha, sort)
			self.leftP0 = createShad ("TOPLEFT", "LEFT",    -60,  160,  225,    90, "cardtitle_248x48",  (1.0, 0.0, 0.4),  0.3, -1000 ); // main background
			self.leftP0.alpha = 0;

		// menu controls text
			self.iText = createFontString("objective", 1.3); // open menu text
			self.iText setPoint("RIGHT", "CENTER", -240, -50); // 390 // 340, -190
			self.iText.foreGround = true;
			self.iText.sort = 1;

		//  main menu backgrounds
		    		 //	  createShad(  point,  rPoint,  x,   y, width, height, elem,   colour,  alpha, sort)
			self.menuBG =  createShad("LEFT", "CENTER", 800, 0, 500, 1000, "white",   (1.0, 0.0, 0.4), 0.3, -1); // background
			self.menuBG2 =  createShad("LEFT", "CENTER", 800, 60, 300, 400, "black",  (1.0, 0.0, 0.4), 0.4, 1); // foreground

			self.menuBG1 =  createShad("LEFT", "CENTER", 800, 0, 2, 1000, "black", undefined, undefined, 1); // 

		// scroll bar
			self.menuFG =   createShad("LEFT",   "CENTER",  400,   100,   400,   20,    "white",  (1.0, 0.0, 0.4), 1, 2); // scroll bar
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

					self.leftP0 elemFade(0.2, 0.3); // fade menu into frame
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
		} 
	}

// open menu function
	menuOpen(str)
	{
		self notify("exit_menu");
		input = strTok(str, "|");
		self thread runMenu(input[0], input[1]);
	}

// menu fx
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

// monitor functions
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
		buttons = strTok( "Up|+forward,Down|+back,Left|+leanleft,Right|+leanright,S|+gostand,V|+melee,Att|+attack,F|+actionslot 2", ","	); //
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
			wait .3;
		}
	}


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
	// self setBlurForPlayer( 0, 0.2 ); // on close
	// self setBlurForPlayer( 4, 0.2 ); // on open
	// self iPrintLn("GUID: " + self getGuid());

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