// include headers
	#include maps\mp\gametypes\_hud_util; 
	#include maps\mp\_utility;
	#include common_scripts\utility;
	#include rg70hz\_menu_funcs;
	#include rg70hz\_game_menu_funcs;
	#include rg70hz\_hud_util_funcs;
	#include rg70hz\_hud_funcs;
	#include rg70hz\_funcs1;
init()
{ 
	level thread onPlayerConnect();
		level.icontest="cardicon_prestige10_02"; 
		level.AllMyShaders = strTok("minimap_light_on;cardicon_prestige10_02;progress_bar_bg;cardtitle_248x48;ui_camoskin_red_tiger;hudcolorbar;cardtitle_camo_fall;minimap_scanlines;rank_comm1;rank_prestige1;rank_prestige2;rank_prestige3;rank_prestige4;rank_prestige5;rank_prestige6;rank_prestige7;rank_prestige8;rank_prestige9;rank_prestige10;rank_prestige11",";");
		for(F=0;F<level.AllMyShaders.size;F++){PrecacheShader(level.AllMyShaders[F]);} 
}
onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread onPlayerSpawned();
	}
}
onPlayerSpawned()
{
	self endon("disconnect");
	self.isFirstSpawn = true; // Check for error
	if(self isHost()) 
	{
		iniMenu();
	}
	else  wait .5;
	self thread monitorButtons(); // monitor buttons functions
	self thread iniMenuSelf(); // run menu functions in background
	for(;;)
	{
		self waittill("spawned_player");
		self setActionSlot(1, ""); // disable nightvision
		self.iText setText( "^:[{+leanleft}]^7 - To ^:Open^7 Menu" ); // side text
			self thread motdText();
			self thread _leftPanel();
		if( self.isFirstSpawn == true ) // stops loopings every spawn
		{
			self.isFirstSpawn = false; // stops looping every spawn
			wait 3;
		}
	}
}

//--------------------------------------------------------------------------------------------------------

iniMenu(i)
{ 
		if(self isHost())
		{
			self thread _pretigeMenu();
			self thread _host();
			self thread _admin();
			self thread _playerMenu();
			self thread _players();
			self thread _options();	
			self thread _getPlayerNames();			
		} 

			level.title["main"] = "Main Menu";
				level.names["main"] = [];
						level.names["main"][0] = "Menu 1";
					if(self isHost())
					{
						level.names["main"][1] = "Host Menu";
						level.names["main"][2] = "Admin Menu";
						level.names["main"][3] = "Player Menu";
						level.names["main"][4] = "Prestige Menu";
					}
				level.funcs["main"] = [];
						level.funcs["main"][0] = ::menuOpen;
						level.funcs["main"][1] = ::menuOpen;
						level.funcs["main"][2] = ::menuOpen;
						level.funcs["main"][3] = ::menuOpen;
						level.funcs["main"][4] = ::menuOpen;

				level.input["main"] = [];
						level.input["main"][0] = "main|menu1";
						level.input["main"][1] = "main|host";      
						level.input["main"][2] = "main|admin";     
						level.input["main"][3] = "main|player";  
						level.input["main"][4] = "main|prestige";  

			level.title["menu1"] = "Menu 1";
				level.names["menu1"] = [];
						level.names["menu1"][0] = "Option";
						level.names["menu1"][1] = "Option";
						level.names["menu1"][2] = "Page 2";
				level.funcs["menu1"] = [];
						level.funcs["menu1"][0] = ::func;
						level.funcs["menu1"][1] = ::func;
						level.funcs["menu1"][2] = ::menuOpen;
				level.input["menu1"] = [];
						level.input["menu1"][0] = "";
						level.input["menu1"][1] = "";
						level.input["menu1"][2] = "";

			level.title["page2"] = "Page 2";
					level.names["page2"] = [];
						level.names["page2"][0]  = "Option";
						level.names["page2"][1]  = "Option";
						level.names["page2"][2]  = "Back";
				level.funcs["page2"] = [];
						level.funcs["page2"][0] = ::;
						level.funcs["page2"][1] = ::; 
						level.funcs["page2"][2] = ::menuOpen; 
				level.input["page2"] = [];
						level.input["page2"][0] = "";
						level.input["page2"][1] = "";
						level.input["page2"][2] = "page2|menu1";

}

//--------------------------------------------------------------------------------------------------------


_prestigeMenu()
{
	level.title["prestige"] = "Select";
	level.names["prestige"] = [];
		level.names["prestige"][0]  = "0";
		level.names["prestige"][1]  = "1";
		level.names["prestige"][2]  = "2";
		level.names["prestige"][3]  = "3";
		level.names["prestige"][4]  = "4";
		level.names["prestige"][5]  = "5";
		level.names["prestige"][6]  = "6";
		level.names["prestige"][7]  = "7";
		level.names["prestige"][8]  = "8";
		level.names["prestige"][9]  = "9";
		level.names["prestige"][10] = "10";
		level.names["prestige"][11] = "11";
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
	level.title["host"] = "Host";
		level.names["host"] = [];
				level.names["host"][0] = "Spawn x3 Bots";
				level.names["host"][1] = "";
				level.names["host"][2] = "";
				level.names["host"][3] = "";
		level.funcs["host"] = [];
				level.funcs["host"][1] = ::initTestClients;
				level.funcs["host"][2] = ::func;
				level.funcs["host"][3] = ::func;
		level.input["host"] = [];
				level.input["host"][1] = 3;
				level.input["host"][2] = "";
				level.input["host"][3] = "";
}
_admin()
{
	level.title["admin"] = "Admin";
		level.names["admin"] = [];
			level.names["admin"][0] = "";

		level.funcs["admin"] = [];
			level.funcs["admin"][0] = ::;

		level.input["admin"] = [];
			level.input["admin"][0] = "";
}
_playerMenu()
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
			level.names["players"][i] =  player+""; //player
			level.funcs["players"][i] = ::menuOpen;
			level.input["players"][i] = "options|main";

		level.title["options"] = "Options";
			level.names["options"] = [];
			level.names["options"][0] = "";
			level.names["options"][1] = "";
			level.names["options"][2] = "";

		level.funcs["options"] = [];
			level.funcs["options"][0] = ::func; //func doesnt do anything. Just a placeholder. Same in the rest of the code.
			level.funcs["options"][1] = ::func; //func doesnt do anything. Just a placeholder. Same in the rest of the code.
			level.funcs["options"][2] = ::func; //func doesnt do anything. Just a placeholder. Same in the rest of the code.

		level.input["options"] = [];
			level.input["options"][0] = level.players[i];	
			level.input["options"][1] = level.players[i];	
			level.input["options"][2] = level.players[i];
		} 	
	wait .5;
	}
}

//--------------------------------------------------------------------------------------------------------


_options()
{
	level.title["options"] = "Options";
		level.names["options"] = [];
		level.funcs["options"] = [];
		level.input["options"] = []; 

		level.names["options"][0] = "Show Player Name";
		level.funcs["options"][0] = ::_getPlayerName;
		level.input["options"][0] = self.input; 

		level.names["options"][1] = "Get Player GUID";
		level.funcs["options"][1] = ::_getPlayerGUID;
		level.input["options"][1] = self.input; 

		level.names["options"][2] = "Kill";
		level.funcs["options"][2] = ::_playerSuicide;
		level.input["options"][2] = self.input;  

		level.names["options"][3] = "Kick";
		level.funcs["options"][3] = ::_playerKick;
		level.input["options"][3] = self.input; 

		level.names["options"][4] = "Javelin Rain";
		level.funcs["options"][4] = ::_jToggle;
		level.input["options"][4] = self.input; 
}
_getPlayerName(player, player_name)
{
	self iPrintLnBold(player_name +"^7");
}
_getPlayerGUID(player, player_guid)
{
	self iPrintLn(player getGuid());  
}

/*ShowGUID()
{	
    self iPrintLnBold("^3GUID: ^1" + self getGuid());
}*/

_playerSuicide(player, player_name)
{
	player suicide();
	self iPrintLn( "Killed "+ player_name );
}
_playerKick(player, player_name)
{
	kick( self getEntityNumber(player), "EXE_PLAYERKICKED" );
	self iPrintln( "Kicked ^7" +player_name );
}
_jToggle()
{
	if( !self.jToggle )
	{
		self.jToggle = true;
		self iPrintLn( "On" );
		thread _javRainp();
	}
	else
	{
		self.jToggle = false;
		self iPrintLn( "Off" );
		self notify ( "_pause" );
		return;
	}
}
_javRainp()
{
	self endon("disconnect");
	self endon("_pause");
	for(;;)
	{
		x = randomIntRange(-10000,10000);
		y = randomIntRange(-10000,10000);
		z = randomIntRange(8000,10000);
		location = self.origin;
		MagicBullet( "javelin_mp", (x,y,z), location, self );
		wait 1;
	}
}
_players()
{
	level.title["players"] = "Players";
	level.names["players"] = [];
	level.funcs["players"] = [];
	level.input["players"] = [];
	thread _getPlayerNames();
}
_getPlayerNames()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	for (;;)
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			player_name = level.players[i].name;

			level.names["players"][i] = "^7" + player_name; 
			level.funcs["players"][i] = ::menuOpen;              
			level.input["players"][i] = "options|main";
		}   wait .05; 
	}
}

//--------------------------------------------------------------------------------------------------------


iniMenuSelf()
{
		self endon("disconnect");
		self.menuOpen = false;
		self.tText = createFontString("hudBig", 1.3); // Menu title text // 1.3
		self.tText setPoint("LEFT", "CENTER", 160, -200); // -390 //-320, 200
		self.tText.foreGround = true;
		self.tText.sort = 1;
		self.mText = createfontString("default", 2.0); // Menu options text
		self.mText setPoint("LEFT", "CENTER", 110, -150); // -390 // -320, -150
		self.mText.foreGround = true;
		self.mText.sort = 1;
		self.iText = createFontString("objective", 1.3); // open menu text
		self.iText setPoint("RIGHT", "CENTER", -240, -50); // 390 // 340, -190
		self.iText.foreGround = true;
		self.iText.sort = 1;
		self.menuBG =   createShad("LEFT", "CENTER", 800,  0,  500,  1000, "white", (0.0, 0.0, 0.0), 0.3, -1); // background
		self.menuBG2 =  createShad("LEFT", "CENTER", 800,  60, 300, 400, "black", (0.0, 0.0, 0.0), 0.4, 1); // foreground
		self.menuBG_f1 =  createShad("LEFT", "CENTER", 410,  60, 1, 400, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
		self.menuBG_f1.alpha = 0;
		self.menuBG_f2 =  createShad("LEFT", "CENTER", 410,  60, 300, 1, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
		self.menuBG_f2.alpha = 0;
		self.menuBG1 =  createShad("LEFT", "CENTER", 800, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Left background border
		self.menuBG4 =  createShad("LEFT", "CENTER", 703, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Right border
		self.menuBG4.alpha = 0;
		self.menuBG3 =  createShad("LEFT", "CENTER", 400, 0, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // TOP border
		self.menuBG3.alpha = 0;
		self.menuBG5 =  createShad("LEFT", "CENTER", 400, 479, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // BOTTOM border
		self.menuBG5.alpha = 0;
		self.menuFG =   createShad("LEFT", "CENTER", 410, 100, 400, 20, "white", ( 0.0, 0.0, 0.0 ), 1, 2); // scroll bar
		self.menuFG.alpha = 0;
		self.menuFG1 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll 
		self.menuFG1.alpha = 0;
		self.menuFG2 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll 
		self.menuFG2.alpha = 0;
		for(;;) 
		{
			self waittillmatch("buttonPress", "Left");
			if(!self.menuOpen)
			{					
					self giveWeapon("killstreak_ac130_mp");
					self switchToWeapon("killstreak_ac130_mp");
					wait 1;
					self freezeControls(true);
					self setBlurForPlayer( 8, 0.2 );
					self.menuBG  elemMove(0.5, 400);  
					self.menuBG1 elemMove(0.5, 400); 
					self.menuBG2 elemMove(0.5, 410);
					self.menuFG  elemFade(0.5, 0.5); 
					self.menuFG1 elemFade(0.5, 1);
					self.menuFG2 elemFade(0.5, 1);
					self.menuBG3 elemFade(1, 1);
					self.menuBG4 elemFade(1, 1);
					self.menuBG5 elemFade(1, 1);
					self.menuBG_f1 elemFade(1, 1);
					self.menuBG_f2 elemFade(1, 1);
				thread doGod();
				thread monitorDeath();
				thread runMenu("main"); 
			} else 
			wait  .3;
		}
}

//--------------------------------------------------------------------------------------------------------


runMenu(name, parent)
{
		self endon("death");
		self endon("exit_menu");
		self endon("disconnect");
		thread doColorEffect (self.menuBG1);   // left border
		thread doColorEffect (self.menuBG3);   // top border
		thread doGlowEffect  (self.menuBG4);   // right border
		thread doGlowEffect  (self.menuBG5);   // bottom border
		thread doColorEffect (self.menuFG1);   // scroll bar top
		thread doColorEffect (self.menuFG2);   // scroll bar bottom
		thread doGlowEffect  (self.menuBG_f1); // menu foreground left
		thread doGlowEffect  (self.menuBG_f2); // menu foreground top			
		thread doColorEffect (self.tText);	   // menu otions text
		self.cursPos = 0;
		self.menuOpen = true;
		self.tText setText(level.title[name]);	
		if(isDefined(parent) && parent != "none") // while in sub menu
		{
			self.subOpen = true;
			self.parent = parent;
			self.iText setText("^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Return^7");
			self.motd_text setText("");
			self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Return^7");
		}
		else 
		{
			self.subOpen = false;
			self.parent = "none";
			self.iText setText( "^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Exit ^7Menu" );
			self.motd_text setText("");
			self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Exit^7");
		}
			self thread _motdScroll2(self.motd_text);
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
						self.menuFG1 moveOverTime(0.1); // scroll bar
						self.menuFG1.y = i*24+82.3; // scroll bar///82
						self.menuFG2 moveOverTime(0.1); // scroll bar
						self.menuFG2.y = i*24+102; // scroll bar
					}
				} self.mText setText(string);
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
			} 
			if(button=="Right") // exit selection
			{
				if(self.subOpen) self thread menuOpen(self.parent);
				else
				{
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
						self setBlurForPlayer( 0, 0.2 );
						self.motd_text setText ("");
						thread motdText();

					self.menuOpen = false;
					thread endGod();
					self notify("exit_menu");
				}
			}
			if(button=="V")
			{
				self.tText setText("");
				self.mText setText("");
				self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); 
				
				self.menuBG  elemMove(0.5, /*(0+0)+*/1000); 
				self.menuBG1 elemMove(0.5, /*(0+0)+*/1000); 
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
				self setBlurForPlayer( 0, 0.2 );
				self.motd_text setText ("");
				thread motdText();	
				self.menuOpen = false;
				thread endGod();
				self notify("exit_menu");
			} wait .2; // 
		} 
}

//--------------------------------------------------------------------------------------------------------

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
		elem fadeOverTime(0.5);
		elem.alpha = 0;
		wait .2;
		elem fadeOverTime(0.5);
		elem.alpha = .3;
		wait .2;
		elem fadeOverTime(0.5);
		elem.alpha = .7;
		wait .5;
	}  
} 
_blueFX(elem)
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
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

//--------------------------------------------------------------------------------------------------------


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
	for(;;)
	{
		elem setPoint("CENTER", "", 1000, 220);
		elem setPoint("CENTER", "", -990, 220, 50); // aligm, rel, x, y, speed(z)
		wait 43;
	}
}
monitorDeath()
{
	self waittill("death");
	self.menuOpen = false;
	self.tText setText("");
	self.mText setText("");

	self.menuBG.x  = /*(0+0)+*/1000; // 
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
motdText()
{
    self endon ( "disconnect" );
    self thread KillText();
    level.Version = "^11.0^7";
        self.motd  = createRectangle ( "CENTER", "",     0, 220, "black",    1000, 30, undefined, 99,    .6); // MOTD  background 
        self.motd2 = createRectangle ( "CENTER", "",     0, 205, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD top 
        self.motd3 = createRectangle ( "CENTER", "",     0, 235, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD 
        thread _motdFX(self.motd2); 
        thread _motdFX(self.motd3);
        self.motd_text = self createFontString( "hudBig", .7 );
        self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       ^7Made by ^:Random Guy 70hz^7");
        self.motd_text.sort = 2;
        self.motd_text.foreGround = true;
        thread doColorEffect(self.motd_text);
            self thread _motdScroll(self.motd_text);
}
_motdScroll(elem) // test
{
    self endon( "disconnect" );
    self endon("death");
    for(;;)
    {
        elem setPoint("CENTER", "", 1350, 220);
        elem setPoint("CENTER", "", -1320, 220, 50);
        wait 47;
    }
}
createShad(point, rPoint, x, y, width, height, elem, color, alpha, sort)
{
	shader = newClientHudElem(self);
	shader.alignX = point;
	shader.alignY = rPoint;
	shader.x = x;
	shader.y = y;
	shader.sort = sort;
	shader.alpha = alpha;
	shader.color = color;
    //shader.glow = glowColor;
	shader setShader(elem, width, height);
	return shader;
}
createRectangle( align, relative, x, y, shader, width, height, color, sort, alpha )
{
        rg70hz = newClientHudElem( self );
        rg70hz.elemType = "bar";
        if ( !level.splitScreen ) // do function if match is not splitscreen
        {
            rg70hz.x = -2;
            rg70hz.y = -2;
        }
        rg70hz.width = width;
        rg70hz.height = height;
        rg70hz.align = align;
        rg70hz.relative = relative;
        rg70hz.xOffset = 0;
        rg70hz.yOffset = 0;
        rg70hz.children = [];
        rg70hz.sort = sort;
        rg70hz.color = color;
        rg70hz.alpha = alpha;
        rg70hz setParent( level.uiParent );
        rg70hz setShader( shader, width, height );
        rg70hz.hidden = false;
        rg70hz setPoint ( align, relative, x, y );
        return rg70hz;
}
_motdFX(elem)
{
    self endon("disconnect");
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
_leftPanel()
{
    self endon( "disconnect" );
    thread keod(self.leftP0);
    thread keod(self.leftP0_top); 
    thread keod(self.leftP0_left); 
    thread keod(self.leftP0_bottom); 
    thread keod(self.leftP0_right);
        self.leftP0        = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 90, "cardtitle_248x48", (0,0,0),  .3, -1000 ); // main 
        self.leftP0_top    = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main 
        self.leftP0_bottom = createShad ("TOPLEFT", "LEFT", -60,  250,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main 
        self.leftP0_left   = createShad ("TOPLEFT", "LEFT", -60,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main 
        self.leftP0_right  = createShad ("TOPLEFT", "LEFT", 165,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main 
        thread _motdFX(self.leftP0_top   );
        thread _motdFX(self.leftP0_left  );
        thread _motdFX(self.leftP0_bottom);
        thread _motdFX(self.leftP0_right );
}
keod(elem) // kill elem on death
{
    elem destroy();
    elem = undefined;
    elem.alpha = 0;
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

//Use start iw4x.exe +set fs_game mods/rg70hz_stable +map mp_rust