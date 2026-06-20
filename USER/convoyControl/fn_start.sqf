/*
 *  GRAD_convoyControl_fnc_start
 *
 *  Player-triggered "START" command. Called locally from the ACE self-interaction
 *  menu; forwards the state change to the server which owns GRAD_convoy_state.
 *
 *  No parameters.
 */

// Run the authoritative state change on the server.
if (!isServer) exitWith {
    remoteExecCall ["GRAD_convoyControl_fnc_start", 2];
};

// Already moving — nothing to do.
if ((missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "START") exitWith {};

missionNamespace setVariable ["GRAD_convoy_state", "START", true];
diag_log "[convoy] fn_start running on server";

// Normal cruise values (must match the originals set in fn_init).
#define CONVOY_CRUISE_SEPARATION 35
#define CONVOY_CRUISE_MAXSPEED 40

// Radio confirmation: random start callout to every player.
private _sound = selectRandom ["GRAD_convoy_start_01", "GRAD_convoy_start_02", "GRAD_convoy_start_03", "GRAD_convoy_start_04"];
_sound remoteExec ["playSound", 0];

private _leader = (call GRAD_convoyControl_fnc_getConvoyVehicles) param [0, objNull];

// Reset the link separation we shrank in fn_stop, then release the leader.
Convoy_01 setVariable ["convSeparation", CONVOY_CRUISE_SEPARATION, true];
Convoy_01 setVariable ["maxSpeed", CONVOY_CRUISE_MAXSPEED, true];

// convoy_stopped is the global halt; ensure it's clear so everyone drives.
if (!isNull _leader) then {
    _leader setVariable ["convoy_stopped", false, true];
    _leader forceSpeed -1;   // undo the manual stop applied in fn_stop
};