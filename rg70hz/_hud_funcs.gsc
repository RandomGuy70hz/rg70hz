// include headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;
	
	// rg70hz  headers
	#include rg70hz\_menu_funcs;
	#include rg70hz\_game_menu_funcs;
	#include rg70hz\_hud_util_funcs;
	#include rg70hz\_main;

// hud functions
motdText()
{
    self endon ( "disconnect" );
    self endon ( "death" );
    level.Version = "^3[^1Development^3]^0";
    thread KillText();

    // Advertise Panels
                    //                  align, relative, x, y,   shader, w,   h,  color,     sort,   alpha )
        self.motd  = createRectangle ( "CENTER", "",     0, 220, "black",    1000, 30, undefined, 99,    .6); // MOTD  background bar
        self.motd2 = createRectangle ( "CENTER", "",     0, 205, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD Bar
        self.motd3 = createRectangle ( "CENTER", "",     0, 235, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD Bar

    // scrolling text function
        x = -1000;
        self.motd_text = self createFontString( "hudBig", .7 );
        self.motd_text setPoint ( "CENTER", "", x, 220 );
        self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       Made by ^:Random Guy 70hz^7" );
        self.motd_text.sort = 2;

    //screen xOffset scrolling function made by ダフティ
        while ( true )
        {
          self endon ("death");
          if ( x > 1000 ) x = -1000; self.motd_text setPoint( "CENTER", "", x, 220 );
          x++;
          //self.motd_text FadeOverTime( 0.2 );
          wait 1/30; // fps - speed
        }
}

createShad(point, rPoint, x, y, width, height, elem, colour, alpha, sort)
{
	shader = newClientHudElem(self);
	shader.alignX = point;
	shader.alignY = rPoint;
	shader.x = x;
	shader.y = y;
	shader.sort = sort;
	shader.alpha = alpha;
	shader.color = colour;
	shader setShader(elem, width, height);
	return shader;
}

createRectangle( align, relative, x, y, shader, width, height, color, sort, alpha )
{
    // shader parameter values
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
/* Credits
    Special Thanks to:

        ダフティ for assisting me

    Patch Developed by: Random Guy 70hz
        */
/* ------------------------------------------------------ */


