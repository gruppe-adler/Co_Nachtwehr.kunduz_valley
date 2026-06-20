/*
 *  GRAD_convoyControl_fnc_addInteraction
 *
 *  Adds a "Convoy" submenu to the player's ACE self-interaction menu with
 *  START and STOP entries. Each entry is shown only when it would change the
 *  current convoy state (START hidden while running, STOP hidden while stopped).
 *
 *  Runs on each client (called from fn_init after ACE is available).
 *
 *  No parameters.
 */

if (!hasInterface) exitWith {};

private _player = ACE_player;

// --- Parent submenu: ACE Self Interaction > Convoy ------------------------
private _convoyMenu = [
    "convoy",                                   // action name
    "Convoy",                                   // display name
    "",                                         // icon (TODO: pick an icon path)
    {},                                         // statement (none, it's a parent)
    { true }                                    // condition
] call ace_interact_menu_fnc_createAction;

[
    "CAManBase",
    1,                                          // self-interaction
    ["ACE_SelfActions"],
    _convoyMenu,
    true                                        // inherit to subclasses (B_Soldier_F etc.)
] call ace_interact_menu_fnc_addActionToClass;

// --- START ---------------------------------------------------------------
private _startAction = [
    "convoy_start",
    "Start convoy",
    "",                                         // TODO: icon
    { systemChat "[convoy] START clicked"; call GRAD_convoyControl_fnc_start },
    { (missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "STOP" }
] call ace_interact_menu_fnc_createAction;

[
    "CAManBase",
    1,
    ["ACE_SelfActions", "convoy"],
    _startAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

// --- STOP ----------------------------------------------------------------
private _stopAction = [
    "convoy_stop",
    "Stop convoy",
    "",                                         // TODO: icon
    { systemChat "[convoy] STOP clicked"; call GRAD_convoyControl_fnc_stop },
    { (missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "START" }
] call ace_interact_menu_fnc_createAction;

[
    "CAManBase",
    1,
    ["ACE_SelfActions", "convoy"],
    _stopAction,
    true
] call ace_interact_menu_fnc_addActionToClass;
