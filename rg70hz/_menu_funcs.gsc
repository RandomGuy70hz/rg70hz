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
	iniMenu(i)
	{ 
		// menu threads
			if(self isHost())
			{
				self thread _pretigeMenu();
				self thread _host();
				self thread _admin();
				//self thread _playerMenu();
			} 

		// menus
			// main menu
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
							//level.names["main"][6] = "Players [^1"+level.players.size+"^7]";
							//level.names["main"][7] = "Visions";
						}

					level.funcs["main"] = [];
							level.funcs["main"][0] = ::menuOpen;
							level.funcs["main"][1] = ::menuOpen;
							level.funcs["main"][2] = ::menuOpen;
							level.funcs["main"][3] = ::menuOpen;
							level.funcs["main"][4] = ::menuOpen;
							level.funcs["main"][5] = ::menuOpen; // player menu
							//level.funcs["main"][6] = ::menuOpen;
							//level.funcs["main"][7] = ::menuOpen;
					level.input["main"] = [];
							level.input["main"][0] = "sub3|main";      // account menu
							level.input["main"][1] = "sub2|main";      // fun menu
							level.input["main"][2] = "menucolor|main"; // color menu
							level.input["main"][3] = "prestige|main";  // prestige menu
							level.input["main"][4] = "sub1|main";      // host menu
							level.input["main"][5] = "admin|main";     // admin menu
							//level.input["main"][6] = "players|main";   // player menu
							//level.input["main"][6] = "visions|main";
			
			// text menu
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
			
			// fun menu	
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
							level.funcs["sub2"][0] = ::_toggleFire;
							level.funcs["sub2"][1] = ::toggleGods;
							level.funcs["sub2"][2] = ::_toggleFF;
							level.funcs["sub2"][3] = ::killSelf;
							level.funcs["sub2"][4] = ::toggleAimbot;
							level.funcs["sub2"][5] = ::toggleDS;
							level.funcs["sub2"][6] = ::_infAmmoToggle;
							level.funcs["sub2"][7] = ::noRecoilToggle;
							level.funcs["sub2"][8] = ::doQuake;
							level.funcs["sub2"][9] = ::invis;
							level.funcs["sub2"][10] = ::spawnPavelow;
							level.funcs["sub2"][11] = ::menuOpen;
							level.funcs["sub2"][12] = ::_toggleBM;
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
							level.input["sub2"][11] = "subsub1|sub2";
							level.input["sub2"][12] = "";
							level.input["sub2"][13] = "";
							level.input["sub2"][14] = "sub22|sub2";
				level.title["sub22"] = "Fun Mods: 2";
						level.names["sub22"] = [];
							level.names["sub22"][0] = "Test";
							level.names["sub22"][1] = "Flashing Player";
							level.names["sub22"][2] = "Toggle Third Person";
							level.names["sub22"][3] = "Laser Sight";
							level.names["sub22"][4] = "Jet Pack";
							level.names["sub22"][5] = "Fountain";
							level.names["sub22"][6] = "Menu Colors";
							level.names["sub22"][7] = "Walking AC-130";
							//level.names["sub22"][8] = "";
							//level.names["sub22"][9] = "";
							//level.names["sub22"][10] = "";
							//level.names["sub22"][11] = "";
						level.funcs["sub22"] = [];
							level.funcs["sub22"][0] = ::test;
							level.funcs["sub22"][1] = ::ToggleFlashingPlayer;
							level.funcs["sub22"][2] = ::ToggleThirdPerson;
							level.funcs["sub22"][3] = ::_toggleLaser ;
							level.funcs["sub22"][4] = ::doJetPack ;
							level.funcs["sub22"][5] = ::ToggleFountain ;
							level.funcs["sub22"][6] = ::menuOpen;
							level.funcs["sub22"][7] = ::ToggleWalkingAC130;
							//level.funcs["sub22"][8] = :: 
							//level.funcs["sub22"][9] = :: 
							//level.funcs["sub22"][10] = :: 
							//level.funcs["sub22"][11] = :: 
						level.input["sub22"] = [];
							level.input["sub22"][0] = "";
							level.input["sub22"][1] = "";
							level.input["sub22"][2] = "";
							level.input["sub22"][3] = "";
							level.input["sub22"][4] = "";
							level.input["sub22"][5] = "";
							level.input["sub22"][6] = "menucolor|main";
							level.input["sub22"][7] = "";
							//level.input["sub22"][8] = "";
							//level.input["sub22"][9] = "";
							//level.input["sub22"][10] = "";
							//level.input["sub22"][11] = "";
			
			// account menu
				level.title["sub3"] = "Account";
					level.names["sub3"] = [];
							level.names["sub3"][0] = "Derank";
							level.names["sub3"][1] = "Level 70";
							level.names["sub3"][2] = "Unlock All";
							level.names["sub3"][3] = "Suicide";
							level.names["sub3"][4] = "Fast Restart";
							level.names["sub3"][5] = "End Game";
							level.names["sub3"][6] = "Visions Menu";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";
							//level.names["sub3"][] = "";

					level.funcs["sub3"] = [];
							level.funcs["sub3"][0] = ::doUnStats;
							level.funcs["sub3"][1] = ::doLvl70;
							level.funcs["sub3"][2] = ::completeAllChallenges;
							level.funcs["sub3"][3] = ::killSelf;
							level.funcs["sub3"][4] = ::fastRst;
							level.funcs["sub3"][5] = ::endGme;
							level.funcs["sub3"][6] = ::menuOpen; 
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::
							//level.funcs["sub3"][] = ::

					level.input["sub3"] = [];
							level.input["sub3"][0] = "";
							level.input["sub3"][1] = "";
							level.input["sub3"][2] = "";
							level.input["sub3"][3] = "";
							level.input["sub3"][4] = "";
							level.input["sub3"][5] = "";
							level.input["sub3"][6] = "visions|main";
							//level.input["sub3"][7] = "prestige|main";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
							//level.input["sub3"][] = "";
			
			// vision menu
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
			
			// menu color settings menu	
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
							level.input["menucolor"][13] = "menucolor2|menucolor"; // - Page 2       	

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
							level.funcs["menucolor2"][2] = ::_resetColor;
							level.funcs["menucolor2"][3] = ::_colors;

							level.input["menucolor2"][0] = (0.0, 1.0, 1.0); // - Cyan   ;
							level.input["menucolor2"][1] = (0.3, 0.6, 0.3); // - Default;
							level.input["menucolor2"][2] = ""             ; // - Random ;
							level.input["menucolor2"][3] = ""; // - Reset  ;
	}
	_pretigeMenu()
	{
		level.title["prestige"] = "Select";

		level.names["prestige"] = [];
			level.names["prestige"][0]  = "^30";
			level.names["prestige"][1]  = "^31";
			level.names["prestige"][2]  = "^32";
			level.names["prestige"][3]  = "^33";
			level.names["prestige"][4]  = "^34";
			level.names["prestige"][5]  = "^35";
			level.names["prestige"][6]  = "^36";
			level.names["prestige"][7]  = "^37";
			level.names["prestige"][8]  = "^38";
			level.names["prestige"][9]  = "^39";
			level.names["prestige"][10] = "^310";
			level.names["prestige"][11] = "^311";

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
			level.input["prestige"][0]  =  0 ;      	  	
			level.input["prestige"][1]  =  1 ;    
			level.input["prestige"][2]  =  2 ;    
			level.input["prestige"][3]  =  3 ;    
			level.input["prestige"][4]  =  4 ;    
			level.input["prestige"][5]  =  5 ;    
			level.input["prestige"][6]  =  6 ;    
			level.input["prestige"][7]  =  7 ;    
			level.input["prestige"][8]  =  8 ;    
			level.input["prestige"][9]  =  9 ;    
			level.input["prestige"][10] =  10;  
			level.input["prestige"][11] =  11;    
	}
	_host()
	{
		level.title["sub1"] = "Host";
			level.names["sub1"] = [];
					level.names["sub1"][0] = "";	//"Players [^1"+level.players.size+"^7]";
					level.names["sub1"][1] = "Spawn x1 Bots";
					level.names["sub1"][2] = "Spawn x3 Bots";
					level.names["sub1"][3] = "Spawn x5 Bots";
					level.names["sub1"][4] = "Teleport All";
					level.names["sub1"][5] = "Toggle Bots Move";// check for errors
					level.names["sub1"][6] = "Toggle Bots Attack";
					level.names["sub1"][7] = "Kick Bots";
					level.names["sub1"][8] = "Toggle Aimbot";
						//level.names["sub1"][9] = "Aimbot Off";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";
						//level.names["sub1"][] = "";

			level.funcs["sub1"] = [];
					//level.funcs["sub1"][0] = ::menuOpen;
					level.funcs["sub1"][1] = ::initTestClients;
					level.funcs["sub1"][2] = ::initTestClients;
					level.funcs["sub1"][3] = ::initTestClients;
					level.funcs["sub1"][4] = ::Teleport2;
					level.funcs["sub1"][5] = ::MoveBots; // check for errors
					level.funcs["sub1"][6] = ::AttackBots;
					level.funcs["sub1"][7] = ::KickBot;
					level.funcs["sub1"][8] = ::toggleAimbot;
						//level.funcs["sub1"][9] = ::toggleAimbot;
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::
						//level.funcs["sub1"][] = ::

			level.input["sub1"] = [];
					//level.input["sub1"][0] = "players|sub1";
					level.input["sub1"][1] = 1;
					level.input["sub1"][2] = 3;
					level.input["sub1"][3] = 5;
					level.input["sub1"][4] = "";
					level.input["sub1"][5] = ""; // name, parent
					level.input["sub1"][6] = "";
					level.input["sub1"][7] = "";
					level.input["sub1"][8] = "";
						//level.input["sub1"][9] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
						//level.input["sub1"][] = "";
	}
	_admin()
	{
		level.title["admin"] = "Admin";

			level.names["admin"] = [];
				level.names["admin"][0] = "Test";
				//level.names["admin"][1] = "Players";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";
				//level.names["admin"][] = "";

			level.funcs["admin"] = [];
				level.funcs["admin"][0] = ::test;
				//level.funcs["admin"][1] = ::menuOpen;
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::
				//level.funcs["admin"][] = ::

			level.input["admin"] = [];
				level.input["admin"][0] = "";
				//level.input["admin"][1] = "players|sub1";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
				//level.input["admin"][] = "";
	}
	/*_playerMenu()
	{
		self endon( "disconnect" );
		self endon("death");

		level.title["players"] = "Players [^1"+level.players.size+"^7]";
			level.names["players"] = [];
			level.funcs["players"] = [];
			level.input["players"] = [];
		for(;;)
		{
			for( i = 0; i <= level.players.size; i++ )
			{
				player = level.players[i].name;
				play = level.players[i];
				//guy = play;
				//name = guy getTrueName();
		
				level.names["players"][i] =  player+"^7"; //player
				level.funcs["players"][i] = ::menuOpen;
				level.input["players"][i] = "options|main";
				
				level.title["options"] = "Options";
				level.names["options"] = [];
				level.names["options"][0] = "Kill";
				level.names["options"][1] = "Kick";
				level.names["options"][2] = "Show ^1GUID^7";
				level.names["options"][3] = "Test";
				level.names["options"][4] = "^:Javelin ^7Rain";
				level.names["options"][5] = "Set Player On Fire";
					//level.names["options"][6] = "";
					//level.names["options"][7] = "";
					//level.names["options"][8] = "";
					//level.names["options"][9] = "";
					//level.names["options"][10] = "";
					//level.names["options"][11] = "";
					//level.names["options"][12] = "";

				level.funcs["options"] = [];
				level.funcs["options"][0] = ::killPlayer;
				level.funcs["options"][1] = ::kickPlayer;
				level.funcs["options"][2] = ::ShowGUID;
				level.funcs["options"][3] = ::test;
				level.funcs["options"][4] = ::javirain;
				level.funcs["options"][5] =  ::_toggleFireP;
					//level.funcs["options"][6] =  ::
					//level.funcs["options"][7] =  ::
					//level.funcs["options"][8] =  ::
					//level.funcs["options"][9] =  ::
					//level.funcs["options"][10] = ::
					//level.funcs["options"][11] = ::
					//level.funcs["options"][12] = ::

				level.input["options"] = [];
				level.input["options"][0] = level.players[i];	
				level.input["options"][1] = level.players[i];	
				level.input["options"][2] = level.players[i];	
				level.input["options"][3] = level.players[i]; 
				level.input["options"][4] = level.players[i]; 
				level.input["options"][5] = "";
					//level.input["options"][6] =  level.players[i];
					//level.input["options"][7] =  level.players[i];
					//level.input["options"][8] =  level.players[i];
					//level.input["options"][9] =  level.players[i];
					//level.input["options"][10] = level.players[i];
					//level.input["options"][11] = level.players[i];
					//level.input["options"][12] = level.players[i];
			} 
				
		wait .5;
		}
	}*/

// draw menu functions
	iniMenuSelf()
	{
		// events & variables	
			self endon("disconnect");
			self.menuOpen = false;

		// menu title text
			self.tText = createFontString("hudBig", 1.3); // Menu title text // 1.3
			self.tText setPoint("LEFT", "CENTER", 160, -200); // -390 //-320, 200
			self.tText.foreGround = true;
			self.tText.sort = 1;

		// menu options text
			self.mText = createfontString("default", 2.0); // Menu options text
			self.mText setPoint("LEFT", "CENTER", 110, -150); // -390 // -320, -150
			self.mText.foreGround = true;
			self.mText.sort = 1;
		

		// menu controls text
			self.iText = createFontString("objective", 1.3); // open menu text
			self.iText setPoint("RIGHT", "CENTER", -240, -50); // 390 // 340, -190
			self.iText.foreGround = true;
			self.iText.sort = 1;

		//  main menu backgrounds
		    		 //	  createShad(  point,  rPoint,   x,    y, width, height, elem, color,  alpha, sort)
			self.menuBG =   createShad("LEFT", "CENTER", 800,  0,  500,  1000, "white", (0.0, 0.0, 0.0), 0.3, -1); // background
			self.menuBG2 =  createShad("LEFT", "CENTER", 800,  60, 300, 400, "black", (0.0, 0.0, 0.0), 0.4, 1); // foreground

			self.menuBG_f1 =  createShad("LEFT", "CENTER", 410,  60, 1, 400, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
			self.menuBG_f1.alpha = 0;
			self.menuBG_f2 =  createShad("LEFT", "CENTER", 410,  60, 300, 1, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
			self.menuBG_f2.alpha = 0;

									//  point,  rPoint,  x,   y, w, h,     elem       			rgb,    a, s
			self.menuBG1 =  createShad("LEFT", "CENTER", 800, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Left background border

			self.menuBG4 =  createShad("LEFT", "CENTER", 703, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Right border
			self.menuBG4.alpha = 0;

			self.menuBG3 =  createShad("LEFT", "CENTER", 400, 0, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // TOP border
			self.menuBG3.alpha = 0;
			self.menuBG5 =  createShad("LEFT", "CENTER", 400, 479, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // BOTTOM border
			self.menuBG5.alpha = 0;
	
		// scroll bar
		                            //  point,  rPoint,  x,   y,    w, h,    elem          rgb,         a, s
			self.menuFG =   createShad("LEFT", "CENTER", 410, 100, 400, 20, "white", ( 0.0, 0.0, 0.0 ), 1, 2); // scroll bar
			self.menuFG.alpha = 0;

			self.menuFG1 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll bar top 0.0, 0.5, 1.0
			self.menuFG1.alpha = 0;
			self.menuFG2 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll bar bottom 0.0, 0.5, 1.0
			self.menuFG2.alpha = 0;

		// main loop
			for(;;) 
			{
				self waittillmatch("buttonPress", "Left");
				if(!self.menuOpen)
				{
					// latop menu
						self giveWeapon("killstreak_ac130_mp");
						self switchToWeapon("killstreak_ac130_mp");
						wait 1;

					// fx
						self freezeControls(true);
						//self VisionSetNakedForPlayer ( "contingency_thermal_inverted", 2.5 );
						self setBlurForPlayer( 8, 0.2 ); // 4, 0.2 

					// main backgrounds move into frame
						self.menuBG  elemMove(0.5, 400);  // bring menu into frame
						self.menuBG1 elemMove(0.5, 400); // time, input
						self.menuBG2 elemMove(0.5, 410);

					// ^ fades into frame
						self.menuFG  elemFade(0.5, 0.5); // scroll bar
						self.menuFG1 elemFade(0.5, 1);
						self.menuFG2 elemFade(0.5, 1);

						self.menuBG3 elemFade(1, 1);
						self.menuBG4 elemFade(1, 1);
						self.menuBG5 elemFade(1, 1);

						self.menuBG_f1 elemFade(1, 1);
						self.menuBG_f2 elemFade(1, 1);
					
					thread monitorDeath();
					thread runMenu("main"); 
				} else 
				wait  .3;
			}
	}
	runMenu(name, parent)
	{
		// events
			self endon("death");
			self endon("exit_menu");
			self endon("disconnect");

		// fx here
			//thread doGlowEffect(self.leftP0); // left border panel; under minimap
			//thread doColorEffect(self.leftP0_top);
			//thread doColorEffect(self.leftP0_bottom);
			//thread doColorEffect(self.leftP0_left);
			//thread doColorEffect(self.leftP0_right);
			thread doColorEffect(self.menuBG1);  // left border
			thread doColorEffect(self.menuBG3);  // top border
			thread doGlowEffect (self.menuBG4);  // right border
			thread doGlowEffect (self.menuBG5);  // bottom border
			thread doColorEffect (self.menuFG1);  // scroll bar top
			thread doColorEffect (self.menuFG2);  // scroll bar bottom
			thread doGlowEffect(self.menuBG_f1); // menu foreground left
			thread doGlowEffect(self.menuBG_f2); // menu foreground top			
			thread doColorEffect (self.tText);

		// variables
			self.cursPos = 0;
			self.menuOpen = true;
			self.tText setText(level.title[name]);

		// parent conditions	
			if(isDefined(parent) && parent != "none") // while in sub menu
			{
				self.subOpen = true;
				self.parent = parent;
				self.iText setText("^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Return^7");
				self.motd_text setText("");
				self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Return^7");
				//self thread _motdScroll2(self.motd_text);
			}
			else // while in main menu
			{
				self.subOpen = false;
				self.parent = "none";
				self.iText setText( "^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Exit ^7Menu" );
				self.motd_text setText("");
				self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Exit^7");
				//self thread _motdScroll2(self.motd_text);
			}

			//if(self.menuOpen)
			//{
				//self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Return^7");
				self thread _motdScroll2(self.motd_text);
			//}

		// main loop
			for(;;)
			{
				// scroll bar & menu options text
					string = "";
					for(i=0; i<level.names[name].size; i++)
					{	
						string += level.names[name][i] + "\n";
						if(self.cursPos == i) 
						{
							self.menuFG moveOverTime(0.1); // scroll bar
							self.menuFG.y = i*24+82; // scroll bar
							self.menuFG1 moveOverTime(0.1); // scroll bar
							self.menuFG1.y = i*24+82.3; // scroll bar///82
							self.menuFG2 moveOverTime(0.1); // scroll bar
							self.menuFG2.y = i*24+102; // scroll bar
							thread _updateMenu();
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
						//fx 
							self.tText setText(""); // Menu title text
							self.mText setText(""); // menu options text
							self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // left screen text
							
							self.menuBG  elemMove(0.5, /*(0+0)+*/1000); // go off screen on menu close
							self.menuBG1 elemMove(0.5, /*(0+0)+*/1000); // time, pos
							self.menuBG2 elemMove(0.5, /*(0+0)+*/1000);

							self.menuFG    elemFade(.2, 0);
							self.menuFG1   elemFade(.2, 0);
							self.menuFG2   elemFade(.2, 0);

							self.menuBG3   elemFade(.2, 0);
							self.menuBG4   elemFade(.2, 0);
							self.menuBG5   elemFade(.2, 0);

							self.menuBG_f1 elemFade(.2, 0);
							self.menuBG_f2 elemFade(.2, 0);
						
							self switchToWeapon(self getLastWeapon());
							self freezeControls(false);
							//self visionSetNakedForPlayer(getDvar("mapname"), 1.5);
							self setBlurForPlayer( 0, 0.2 );

							// self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       ^7Made by ^:Random Guy 70hz^7");
							// thread _motdScroll(self.motd_text);
							self.motd_text setText ("");
							thread motdText();

						self.menuOpen = false;
						self notify("exit_menu");
					}
				}
				if(button=="V") // exit menu
				{
					self.tText setText("");
					self.mText setText("");
					self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // switch to +leanleft
					
					self.menuBG  elemMove(0.5, /*(0+0)+*/1000); // go off screen on menu close
					self.menuBG1 elemMove(0.5, /*(0+0)+*/1000); // time, pos
					self.menuBG2 elemMove(0.5, /*(0+0)+*/1000);

					self.menuFG elemFade(0.5, 0);
					self.menuFG1 elemFade(0.5, 0);
					self.menuFG2 elemFade(0.5, 0);


					self.menuBG3 elemFade(0.5, 0);
					self.menuBG4 elemFade(0.5, 0);
					self.menuBG5 elemFade(0.5, 0);
					

					self.menuBG_f1 elemFade(0.5, 0);
					self.menuBG_f2 elemFade(0.5, 0);

					self switchToWeapon(self getLastWeapon());
					self freezeControls(false);

					//self visionSetNakedForPlayer(getDvar("mapname"), 1.5);
					self setBlurForPlayer( 0, 0.2 );

					// self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       ^7Made by ^:Random Guy 70hz^7");
					// thread _motdScroll(self.motd_text);
					self.motd_text setText ("");
					thread motdText();

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
	doColorEffect(elem)
	{
		self endon("exit_menu");
		self endon("death");

			r = randomInt(255);
			r_bigger = true;

			g = randomInt(255);
			g_bigger = false;

			b = randomInt(255);
			b_bigger = true;

		for(;;)
		{
			if(r_bigger == true) 
			{
				r += 10;
				if( r > 254 )
				{
					r_bigger = false;
				}
			}
			else
			{
				r -= 10;
				if( r < 2 )
				{
					r_bigger = true;
				}
			}
			if( g_bigger == true )
			{
				g += 10;
				if( g > 254 )
				{
					g_bigger = false;
				}
			}
			else
			{
				g -= 10;
				if( g < 2 )
				{
					g_bigger = true;
				}
			}
			if(b_bigger==true)
			{
				b += 10;
				if( b > 254 )
				{
					b_bigger = false;
				}
			}
			else
			{
				b -= 10;
				if( b < 2 )
				{
					b_bigger = true;
				}
			}
			elem.color = ((r/255),(g/255),(b/255));
			wait 0.01;
		}
	}
	doGlowEffect(elem)
	{
		self endon("exit_menu");
		self endon("death");
	    for(;;)
	    {
	        //wait .1;
	       	//elem fadeOverTime(0.5);
	        //elem.alpha = randomfloatrange( 0, 1 ); 

	        //self.menuFG1 elemFade(0.5, 0);
			//self.menuFG2 elemFade(0.5, 0);
			//self thread elemFade(0.5, 0);
			elem fadeOverTime(0.5);
			elem.alpha = 0;
			wait .2;
			//self.menuFG1 elemFade(0.5, .3);
			//self.menuFG2 elemFade(0.5, .3);
			//self thread elemFade(0.5, .3);
			elem fadeOverTime(0.5);
			elem.alpha = .3;
			wait .2;
			//self.menuFG1 elemFade(0.5, .7);
			//self.menuFG2 elemFade(0.5, .7);
			//self thread elemFade(0.5, .7);
			elem fadeOverTime(0.5);
			elem.alpha = .7;

			//self.menuFG1 fadeOverTime(0.5);
			//self.menuFG2 fadeOverTime(0.5);
			
			wait .5;
	    }  
	} 
	_blueFX(elem)
	{
		self endon("disconnect");
		self endon("death");

		for(;;)
		{
		    /*elem fadeOverTime(.2);
			elem.color = (0.0, 0.5, 1.0);
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.0, 0.0, 1.0 );
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.3, 0.0, 0.3);
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.0, 1.0, 1.0);
			wait .2;*/

			elem fadeOverTime(.2);
			elem.color = easyColor(56,105,250);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(61,107,245);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(66,110,240);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(71,112,235);
			wait .3;
			
			
			elem fadeOverTime(.2);
			elem.color = easyColor(76,115,230);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(82,117,224);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(87,120,219);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(92,122,214);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(97,125,209);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(102,127,204);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(112,133,194);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(107,130,199);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(117,135,189);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(122,138,184);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(128,140,179);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(133,143,173);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(138,145,168);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(143,148,163);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(148,150,158);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(153,153,153);
			wait .3;

		}
	}
	_blackNblue(elem)
	{
		self endon( "disconnect" );
		self endon( "death" );

		for(;;)
		{
			elem fadeOverTime(0.2);
			elem.color = (0,0,0);
			wait .2;
			elem fadeOverTime(0.2);
			elem.color = (0.0, 0.5, 1.0 );
			wait .2;
		}
	}
	_motdScroll2(elem) // test
	{
	    self endon("death");
	    self endon("exit_menu");
	    self endon( "disconnect" );

	    // test 
	    for(;;)
	    {
	        elem setPoint("CENTER", "", 1000, 220);
	        elem setPoint("CENTER", "", -990, 220, 50); // aligm, rel, x, y, speed(z)
	        wait 43;
	    }
	    //screen xOffset scrolling function made by ダフティ
	        //x = -1000;
	        //self.motd_text setPoint ( "CENTER", "", x, 220 );
	        /*while ( true )
	        {
	          self endon ("death");
	          if ( x > 1000 ) x = -1000; self.motd_text setPoint( "CENTER", "", x, 220 );
	          x++;
	          //self.motd_text FadeOverTime( 0.2 );
	          wait 1/30; // fps - speed
	        }*/

	        // test
	            //x = -1000;
	            //elem setPoint ( "CENTER", "", x, 220 );
	            /*while ( true )
	            {
	              self endon ("death");
	              if ( x > 1000 ) x = -1000; elem setPoint( "CENTER", "", x, 220 );
	              x++;
	              //elem FadeOverTime( 0.2 );
	              wait 1/30; // fps - speed
	            }*/
	}

// monitor functions
	monitorDeath()
	{
		self waittill("death");
		self.menuOpen = false;
		self.tText setText("");
		self.mText setText("");

		self.menuBG.x  = /*(0+0)+*/1000; // (0+0)+1000) //(-320+385)-385 // go here on death
		self.menuBG1.x = /*(0+0)+*/1000; //
		self.menuBG2.x = /*(0+0)+*/1000; //

		self.menuFG.alpha  = 0;
		self.menuFG1.alpha = 0;
		self.menuFG2.alpha = 0;

		self.menuBG3.alpha  = 0;
		self.menuBG4.alpha  = 0;

		self.menuBG_f1.alpha = 0;
		self.menuBG_f2.alpha = 0;
	}
	monitorButtons()
	{
		buttons = strTok( "Up|+forward,Down|+back,Left|+leanleft,Right|+leanright,S|+gostand,V|+melee,Att|+attack,F|+actionslot 2,K|+actionslot 3,D|+actionslot 1", ","	); //
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




/* ---------------------Footer------------------------- */
	
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
	/* Code Dump -

			// in debug
			/*_playerOptions(player)
			{
				level.title["options"] = "Options";
				level.names["options"] = [];
					level.names["options"][0] = "Kill";
					level.names["options"][1] = "Kick";
					level.names["options"][2] = "Show ^1GUID^7";
					level.names["options"][3] = "Test";
				level.funcs["options"] = [];
					level.funcs["options"][0] = ::killPlayer;
					level.funcs["options"][1] = ::kickPlayer;
					level.funcs["options"][2] = ::ShowGUID;
					level.funcs["options"][3] = ::test;
				level.input["options"] = [];
					level.input["options"][0] = player;	
					level.input["options"][1] = player;	
					level.input["options"][2] = player;	
					level.input["options"][3] = player;
			}*/
			/*playerMenu()
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
							play = level.players[i];
							//name = ::getTrueName;
							//guy = name;

							// player menu
							level.names["players"][i] = "^7"+player+"^7 ^0>>^7"; //
							level.funcs["players"][i] = ::menuOpen;              //
							level.input["players"][i] = "playerOptions|players"; //  

								//level.input["players"][0] = "playerOptions";
								//level.input["players"][1] = "playerOptions";
								//level.input["players"][2] = "playerOptions";
								//level.input["players"][3] = "playerOptions";
								//level.input["players"][4] = "playerOptions";
								//level.input["players"][5] = "playerOptions";
								//level.input["players"][6] = "playerOptions";
								//level.input["players"][7] = "playerOptions"; 

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
									level.input["playerOptions"][13] = level.players[i];        
					} 
					wait .5; 
				}
			}*/
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
	/* ------------------------------------------------------ */


































