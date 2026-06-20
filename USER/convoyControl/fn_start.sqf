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

// Only act from a settled STOP. Ignores re-triggers while already moving or
// while a previous start/stop is still in its PENDING cooldown.
if !((missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "STOP") exitWith {};

// Enter the cooldown. While PENDING neither ACE menu entry is shown (both
// conditions test for the settled STOP/START states), so the command can't be
// spammed during the radio chatter. The state settles to START below.
missionNamespace setVariable ["GRAD_convoy_state", "PENDING", true];
diag_log "[convoy] fn_start running on server";

// Cooldown before the state settles to START (seconds).
#define CONVOY_COOLDOWN 8

// Normal cruise values (must match the originals set in fn_init).
#define CONVOY_CRUISE_SEPARATION 35
#define CONVOY_CRUISE_MAXSPEED 40


[
    {
        {
            _x params ["_audioID"];

            private _duration = getNumber (missionConfigFile >> "CfgSounds" >> _audioID >> "duration");
            private _avatar = getText (missionConfigFile >> "CfgSounds" >> _audioID >> "avatar");
            private _text = getArray (missionConfigFile >> "CfgSounds" >> _audioID >> "customsubtitle") select 1;
            private _object = getText (missionConfigFile >> "CfgSounds" >> _audioID >> "object");

            [[_object, _text, _audioID, _duration, _avatar], "user\rscMessage\createMessageRsc.sqf"] remoteExec ["bis_fnc_execVM"];

        } forEach [
            selectRandom ["GRAD_convoy_start_01", "GRAD_convoy_start_02", "GRAD_convoy_start_03", "GRAD_convoy_start_04"]
        ];
    }
, [], 3] call CBA_fnc_waitAndExecute;

// Settle the state to START once the cooldown elapses, re-enabling the menu.
[{
    missionNamespace setVariable ["GRAD_convoy_state", "START", true];
}, [], CONVOY_COOLDOWN] call CBA_fnc_waitAndExecute;


private _leader = (call GRAD_convoyControl_fnc_getConvoyVehicles) param [0, objNull];

// Reset the link separation we shrank in fn_stop, then release the leader.
Convoy_01 setVariable ["convSeparation", CONVOY_CRUISE_SEPARATION, true];
Convoy_01 setVariable ["maxSpeed", CONVOY_CRUISE_MAXSPEED, true];

// convoy_stopped is the global halt; ensure it's clear so everyone drives.
if (!isNull _leader) then {
    _leader setVariable ["convoy_stopped", false, true];
    _leader forceSpeed -1;   // undo the manual stop applied in fn_stop
};