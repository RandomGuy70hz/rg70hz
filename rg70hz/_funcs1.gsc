//headers
    #include maps\mp\gametypes\_hud_util;
    #include maps\mp\_utility;
    #include common_scripts\utility;

    #include rg70hz\_menu_funcs;
        #include rg70hz\_game_menu_funcs;
        #include rg70hz\_hud_util_funcs;
        #include rg70hz\_hud_funcs;
        #include rg70hz\_main;


/* quick cmds:
        rg70hz[v2].bat
        taskkill /F /IM iw4x.exe /T
*/

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

// mod functions
    _getPlayerName(player_name)
    {
        self iPrintLnBold(player_name +"^7");
    }
    _getPlayerGUID(player)
    {
        self iPrintLn(player getGuid());  
    }
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








/* quick cmds:
        rg70hz[v2].bat
        taskkill /F /IM iw4x.exe /T
*/
/* debug
    _options()
    {
        level.names["players"][i] = "^7" + guy; // player_name;
        level.funcs["players"][i] = ::menuOpen
        level.input["players"][i] = "options|main";

        // player options
        level.title["options"] = guy + "`s Options";
        level.names["options"] = [];
        level.funcs["options"] = [];
        level.input["options"] = [];

        level.names["options"][0] = "Show Player Name";
        level.names["options"][1] = "Get Player GUID";
        level.names["options"][2] = "Kill";
        level.names["options"][3] = "Kick";
        level.names["options"][4] = "Test";
        level.names["options"][5] = "Test";

        //level.funcs["options"][0] = ::
        //level.funcs["options"][1] = ::
        //level.funcs["options"][2] = ::
        //level.funcs["options"][3] = ::
        //level.funcs["options"][4] = ::
        //level.funcs["options"][5] = ::

        level.input["options"][0] = "";
        level.input["options"][1] = "";
        level.input["options"][2] = "";
        level.input["options"][3] = "";
        level.input["options"][4] = "";
        level.input["options"][5] = "";
    }
    _updatePlayerMenu()
    {
    }
    _openPlayerMenu()
    {
    }
    _playerVariables()
    {
        //level.plmenu_open = 0;   
    }
    */

