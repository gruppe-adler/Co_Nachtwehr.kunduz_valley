/*
 *  GRAD_convoyControl_fnc_init
 *
 *  postInit entry point for the convoy control system. Establishes the
 *  authoritative convoy state variable on the server and registers the
 *  ACE self-interaction menu on every client.
 *
 *  The convoy state is held in:
 *      missionNamespace getVariable "GRAD_convoy_state"   ("STOP" | "START")
 *
 *  No parameters.
 */

// Server owns the canonical state. Broadcast so JIP clients pick it up.
if (isServer) then {
    if (isNil "GRAD_convoy_state") then {
        missionNamespace setVariable ["GRAD_convoy_state", "STOP", true];
    };

    // Build the convoy path from the editor-placed marker objects
    // convoy_path_1_1 .. convoy_path_1_30 (in order). Skip any that are
    // missing so a shortened path still works.
    private _convoyPath = [];
    for "_i" from 1 to 30 do {
        private _obj = missionNamespace getVariable [format ["convoy_path_1_%1", _i], objNull];
        if (!isNull _obj) then {
            _convoyPath pushBack (getPosATL _obj);
        };
    };

    // Publish for reference. The NAGAS leader follows its own group waypoints
    // (fn_pathCreator records the leader's track as breadcrumbs for the
    // followers); the followers don't read this directly.
    missionNamespace setVariable ["GRAD_convoy_path", _convoyPath, true];
    
    private _convoyLogic = createCenter sideLogic;
    private _convoyGroup = createGroup _convoyLogic;
    Convoy_01 = _convoyGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
    Convoy_01 setVariable ["maxSpeed", 40];
    Convoy_01 setVariable ["convSeparation", 35];
    Convoy_01 setVariable ["stiffnessCoeff", 0.2];
    Convoy_01 setVariable ["dampingCoeff", 0.6];
    Convoy_01 setVariable ["curvatureCoeff", 0.3];
    Convoy_01 setVariable ["stiffnessLinkCoeff", 0.1];
    Convoy_01 setVariable ["pathFrequecy", 0.05];
    Convoy_01 setVariable ["speedFrequecy", 0.2];
    Convoy_01 setVariable ["speedModeConv", "NORMAL"];
    Convoy_01 setVariable ["behaviourConv", "pushThroughContact"];
    Convoy_01 setVariable ["debug", false];

    publicVariable "Convoy_01";

    // Convoy vehicles, leader first.
    private _convoyVehicles = [multi_barkas, multi_firefighter, multi_bulldozer, multi_tractor, multi_fuel, multi_material_1, multi_material_2];
    private _leader = _convoyVehicles select 0;

    // Route: turn the path (from convoy_path_1_1..30 above) into MOVE waypoints
    // on the leader's group; NAGAS drives the leader along them.
    {
        private _wp = (group _leader) addWaypoint [_x, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointBehaviour "CARELESS";
        _wp setWaypointSpeed "FULL";
    } forEach (missionNamespace getVariable ["GRAD_convoy_path", []]);

    call{ 0 = [Convoy_01, _convoyVehicles] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

    // fn_initConvoy starts the convoy in drive mode (convoy_stopped = false) and
    // the speed controller spins up async. Hold it stopped so the world matches
    // the default GRAD_convoy_state ("STOP"); the ACE menu then drives start/stop.
    // Deferred so fn_initConvoy's own initialisation has set convoy_stopped first.
    [{
        Convoy_01 setVariable ["maxSpeed", 0, true];
        _leader setVariable ["convoy_stopped", true, true];
    }, [], 1] call CBA_fnc_waitAndExecute;
};

// Only player machines need the interaction menu.
if (!hasInterface) exitWith {};

// ACE may not be ready this early; defer until the self-interaction API exists.
[
    { !isNil "ace_interact_menu_fnc_addActionToClass" },
    { call GRAD_convoyControl_fnc_addInteraction },
    []
] call CBA_fnc_waitUntilAndExecute;
