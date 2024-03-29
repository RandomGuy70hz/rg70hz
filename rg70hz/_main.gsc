// include headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;
	
	// rg70hz  headers
	#include rg70hz\_menu_funcs;
	#include rg70hz\_game_menu_funcs;
	#include rg70hz\_hud_util_funcs;
	#include rg70hz\_hud_funcs;
 
// **Only tested on [1440x900] so best to use on these settings until released **

//main functions
init()
{ 
	level thread onPlayerConnect();
	/* Precaches */
		level.icontest="cardicon_prestige10_02"; 
		level.AllMyShaders = strTok("minimap_light_on;cardicon_prestige10_02;progress_bar_bg;cardtitle_248x48;ui_camoskin_red_tiger;hudcolorbar;cardtitle_camo_fall;minimap_scanlines;rank_comm1;rank_prestige1;rank_prestige2;rank_prestige3;rank_prestige4;rank_prestige5;rank_prestige6;rank_prestige7;rank_prestige8;rank_prestige9;rank_prestige10;rank_prestige11",";");
		for(F=0;F<level.AllMyShaders.size;F++){PrecacheShader(level.AllMyShaders[F]);}  
		//remove all invisible boundries from every map 
			/*ents = getEntArray();
	    	for ( index = 0; index < ents.size; index++ )
	    	{
	        	if(isSubStr(ents[index].classname, "trigger_hurt"))
	        	ents[index].origin = (0, 0, 9999999);
	    	}*/
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

		// fx functions
			self thread motdText();
			self thread _leftPanel();
			//self thread _toggleLaser();
			//self thread _modInstruc();

		// needed so welcome msg doesnt thread after every spawn/death
		if( self.isFirstSpawn == true ) // stops loopings every spawn
		{
			self.isFirstSpawn = false; // stops looping every spawn
			wait 3;
			//self myMessage( "Welcome ^:" +self.name+"^7 To My Mod\n" ); // plays msg on spawn
		}
	}
}


/* open me...

                              Made by:
  ___                 _                ___               ____  __   _
 | _ \ __ _  _ _   __| | ___  _ __    / __| _  _  _  _  |__  |/  \ | |_   ___
 |   // _` || ' \ / _` |/ _ \| '  \  | (_ || || || || |   / /| () || ' \ |_ /
 |_|_\\__,_||_||_|\__,_|\___/|_|_|_|  \___| \_,_| \_, |  /_/  \__/ |_||_|/__|
                                                  |__/
                         
                Wouldn't be possible without help from  ダフティ*/

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
	*/
/* ------------------------------------------------------ */