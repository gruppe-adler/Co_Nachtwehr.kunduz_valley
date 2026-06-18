params ["_multi"];

[{
    (_this animationSourcePhase "bwa3_hook_animation") == 1 &&
    isEngineOn _this
}, {
    [_this, false] remoteExec ["engineOn", _this];
    ["Please raise hook before driving.", 1.5, [1, 0, 0, 1], true] remoteExec ["CBA_fnc_notify", _this];

    [_this] call grad_missionControl_fnc_multiDisableDriveHookedDown;
}, _multi] call CBA_fnc_waitUntilAndExecute;
