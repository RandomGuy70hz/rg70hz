// include headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;
	
	// rg70hz  headers
	#include rg70hz\_menu_funcs;
	#include rg70hz\_game_menu_funcs;
	#include rg70hz\_main;
	#include rg70hz\_hud_funcs;
 

// hud util functions
	
// easy functions
	easyColor( r, g, b )
	{
		// awesome function
			return (r/255, g/255, b/255);
	}
	/*easyCutHeight(height)
	{
		return height/2;
	}
	easyCutWidth(width)
	{
		return width/2;
	}*/

KillText()
{
    self endon ("disconnect");
    self waittill ( "death" );

    self.motd_text destroy();
    self.motd_text = undefined;

	// left panel
		//self.leftP0        destroy();	self.leftP0        = undefined;  //self.leftP0.alpha        = 0;
		//self.leftP0_top    destroy();	self.leftP0_top    = undefined;  //self.leftP0_top.alpha    = 0;
		//self.leftP0_bottom destroy();	self.leftP0_bottom = undefined;	 //self.leftP0_bottom.alpha = 0;
		//self.leftP0_left   destroy();	self.leftP0_left   = undefined;  //self.leftP0_left.alpha   = 0;
		//self.leftP0_right  destroy();	self.leftP0_right  = undefined;  //self.leftP0_right.alpha  = 0;

	//self.combatHighOverlay destroy();
    //self.combatHighOverlay = undefined;

    //self.aimbotIn destroy();
	//self.aimbotIn = undefined;
}

myMessage( hintText )
{
	notifyData = spawnstruct();
	notifyData.notifyText = hintText;
	notifyData.glowColor = (0.5, 0.0, 0.8);//Change Color
	notifyData.duration = 7;
	notifyData.iconName = level.icontest;
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
	wait 1;
	self playLocalSound( "mp_level_up" );
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

