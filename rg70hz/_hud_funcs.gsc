// headers
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
    //self endon ( "death" );

    self thread KillText();
    level.Version = "^11.0^7";

    // Advertise Panels
                    //                  align, relative, x, y,   shader, w,   h,  color,     sort,   alpha )
        self.motd  = createRectangle ( "CENTER", "",     0, 220, "black",    1000, 30, undefined, 99,    .6); // MOTD  background bar
        self.motd2 = createRectangle ( "CENTER", "",     0, 205, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD top Bar
        self.motd3 = createRectangle ( "CENTER", "",     0, 235, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD bottom Bar

    // test color function
        thread _motdFX(self.motd2); 
        thread _motdFX(self.motd3);

    // scrolling motd text 
        self.motd_text = self createFontString( "hudBig", .7 );
        self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       ^7Made by ^:Random Guy 70hz^7");
        self.motd_text.sort = 2;
        self.motd_text.foreGround = true;

        thread doColorEffect(self.motd_text);

        // scroll function
            self thread _motdScroll(self.motd_text);

        /*for(;;)
        {
            self.motd_text setPoint("CENTER", "", 1350, 220);
            self.motd_text setPoint("CENTER", "", -1320, 220, 50);
            
            wait 47;
        }*/
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
}
_motdScroll(elem) // test
{
    self endon( "disconnect" );
    self endon("death");

    /*for(;;)
    {
        self.motd_text setPoint("CENTER", "", 1350, 220);
        self.motd_text setPoint("CENTER", "", -1320, 220, 50);
        wait 47;
    }*/
    
    // test 
    for(;;)
    {
        elem setPoint("CENTER", "", 1350, 220);
        elem setPoint("CENTER", "", -1320, 220, 50);
        wait 47;
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
        //rg70hz.glow = glowColor;
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

    // variable definitons
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
    //thread KillText();
    
    thread keod(self.leftP0);
    thread keod(self.leftP0_top); 
    thread keod(self.leftP0_left); 
    thread keod(self.leftP0_bottom); 
    thread keod(self.leftP0_right);

    // left panel under minimap
                                    //    point,   rPoint,   x,   y,    w,   h,  elem,               color,   alpha,  sort
        self.leftP0        = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 90, "cardtitle_248x48", (0,0,0),  .3, -1000 ); // main background
        self.leftP0_top    = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
        self.leftP0_bottom = createShad ("TOPLEFT", "LEFT", -60,  250,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
        self.leftP0_left   = createShad ("TOPLEFT", "LEFT", -60,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
        self.leftP0_right  = createShad ("TOPLEFT", "LEFT", 165,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main background

    // fx
        // thread doGlowEffect(self.leftP0);
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

/* ------------------- Footer -------------------- */
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


