if (isServer) then {

  ["BWA3_Multi_Tropen", "init", {
      params ["_multi"];
      [_multi] call grad_missionControl_fnc_multiDisableDriveHookedDown;
      [_multi] call grad_missionControl_fnc_multiAttachManagement; // todo test
  }, true, [], true] call CBA_fnc_addClassEventHandler;

};
