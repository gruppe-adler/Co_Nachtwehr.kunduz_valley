[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };

  {
    private _curator = _x;
    
      _curator addEventHandler ["CuratorGroupPlaced", {
          params ["", "_group"];

          ["GRAD_missionControl_setServerAsOwner", [_group]] call CBA_fnc_serverEvent;
      }];

      _curator addEventHandler ["CuratorObjectPlaced", {
          params ["", "_object"];

          if (_object isKindOf "CAManBase") then {
             if (count units _object == 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group _object]] call CBA_fnc_serverEvent;
             };
          } else {
             if (count crew _object > 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
             };
         };

      }];

  } forEach allCurators;
};



["Fallen Angel - Ambient", "Music Radio",
    {
      // Get all the passed parameters
      params ["_position", "_object"];
      _position = ASLToAGL _position;

      private _radio = (selectRandom ["land_gm_euro_furniture_radio_01", "jbad_radio_b", "Land_FMradio_F"]) createVehicle [0,0,0];
      _radio setPos _position;
      _radio setDir (random 360);

      private _music = (selectRandom ["arabicsong1", "arabicsong2", "arabicsong3"]);
      private _source = createSoundSource [_music, _position, [], 0];
      [_source, _music, _radio, false] call grad_ambient_fnc_soundSourceHelper;
      
      {
        _x addCuratorEditableObjects [[_radio], false];
      } forEach allCurators;

    }] call zen_custom_modules_fnc_register;


["Fallen Angel - Reinforcements", "Unarmed Vodnik", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_GAZ_Vodnik", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;

["Fallen Angel - Reinforcements", "Unarmed Tigr", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_Tigr", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;

["Fallen Angel - Reinforcements", "Unarmed Offroad", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_Offroad_Unarmed", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;

["Fallen Angel - Reinforcements", "Unarmed Kamaz", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_Kamaz_Covered", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;

["Fallen Angel - Reinforcements", "Unarmed GAZ-66", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_Gaz66_Covered", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;

["Fallen Angel - Reinforcements", "Unarmed UAZ", {
	params ["_position", "_object"];

	["UK3CB_CSAT_B_O_UAZ_Closed", ASLToAGL _position] call FA_fnc_spawnReinforcements;
}] call zen_custom_modules_fnc_register;






["CO NACHTWEHR - Transmissions", "00 SEND IT", {
    params ["_position", "_object"];
    [] remoteExec ["FA_fnc_transmission_00_copy", 2];
}] call zen_custom_modules_fnc_register;

["CO NACHTWEHR - Transmissions", "00 COPY THAT, STAND BY", {
    params ["_position", "_object"];
    [] remoteExec ["FA_fnc_transmission_00_standby", 2];
}] call zen_custom_modules_fnc_register;


 ["CO NACHTWEHR - Sandstorm", "Clickpos going to EAST",
  {
    params ["_position", "_object"];

     [_position, 3000, 20, 90] remoteExec ["GRAD_sandStorm_fnc_createSandWall",2];

  }] call zen_custom_modules_fnc_register;

  ["CO NACHTWEHR - Sandstorm", "Clickpos going to WEST",
  {
    params ["_position", "_object"];

     [_position, 3000, 20, 270] remoteExec ["GRAD_sandStorm_fnc_createSandWall",2];

  }] call zen_custom_modules_fnc_register;

  ["CO NACHTWEHR - Sandstorm", "Clickpos going to NORTH",
  {
    params ["_position", "_object"];

     [_position, 3000, 20, 0] remoteExec ["GRAD_sandStorm_fnc_createSandWall",2];

  }] call zen_custom_modules_fnc_register;

  ["CO NACHTWEHR - Sandstorm", "Clickpos going to SOUTH",
  {
    params ["_position", "_object"];

     [_position, 3000, 20, 180] remoteExec ["GRAD_sandStorm_fnc_createSandWall",2];

  }] call zen_custom_modules_fnc_register;