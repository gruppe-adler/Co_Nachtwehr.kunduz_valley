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






["CO NACHTWEHR - Transmissions", "01 BRIEFING", {
    params ["_position", "_object"];
    [] remoteExec ["FA_Zeus_fnc_transmission_01_briefing", 2];
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

["CO NACHTWEHR - Scenario Flow", "Blow up Bridge", {
    params ["_position", "_object"];
    
     ["USER\scripts\blowUpBridge.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
}] call zen_custom_modules_fnc_register;

["CO NACHTWEHR - Scenario Flow", "Manual Trigger - Ambush 1", {
    params ["_position", "_object"];
    missionNamespace setVariable ["grad_startAmbush_1", true, true];
}] call zen_custom_modules_fnc_register;

["CO NACHTWEHR - Scenario Flow", "Manual Trigger - Ambush 2", {
    params ["_position", "_object"];
    missionNamespace setVariable ["grad_startAmbush_2", true, true];
}] call zen_custom_modules_fnc_register;

["CO NACHTWEHR - Scenario Flow", "Manual Trigger - Ambush 3", {
    params ["_position", "_object"];
    missionNamespace setVariable ["grad_startAmbush_3", true, true];
}] call zen_custom_modules_fnc_register;
