/*
 *  GRAD_convoyControl_fnc_stop
 *
 *  Player-triggered "STOP" command. Called locally from the ACE self-interaction
 *  menu; forwards the state change to the server which owns GRAD_convoy_state.
 *
 *  No parameters.
 */

// Run the authoritative state change on the server.
if (!isServer) exitWith {
    remoteExecCall ["GRAD_convoyControl_fnc_stop", 2];
};

// Only act from a settled START. Ignores re-triggers while already stopped or
// while a previous start/stop is still in its PENDING cooldown.
if !((missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "START") exitWith {};

// Enter the cooldown. While PENDING neither ACE menu entry is shown (both
// conditions test for the settled STOP/START states), so the command can't be
// spammed during the radio chatter. The state settles to STOP below.
missionNamespace setVariable ["GRAD_convoy_state", "PENDING", true];

// Cooldown before the state settles to STOP (seconds).
#define CONVOY_COOLDOWN 8

// Tighter gap the convoy closes up to while stopped (metres).
#define CONVOY_STOP_SEPARATION 8

private _leader = (call GRAD_convoyControl_fnc_getConvoyVehicles) param [0, objNull];

// Halt the LEADER only — leave convoy_stopped = false so the link controller
// keeps running and the followers creep up. maxSpeed 0 makes fn_leadSpeedControl
// stop pushing the leader; limitSpeed 0 brings it to a halt.
Convoy_01 setVariable ["maxSpeed", 0, true];
if (!isNull _leader) then {
    _leader limitSpeed 0;
    _leader forceSpeed 0;
};

// Shrink the link separation so followers close up behind the stationary leader.
// Reset on start (see GRAD_convoyControl_fnc_start).
Convoy_01 setVariable ["convSeparation", CONVOY_STOP_SEPARATION, true];


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
            selectRandom ["GRAD_convoy_stop_01", "GRAD_convoy_stop_02", "GRAD_convoy_stop_03", "GRAD_convoy_stop_04"]
        ];      
    }
, [], 3] call CBA_fnc_waitAndExecute;

// Settle the state to STOP once the cooldown elapses, re-enabling the menu.
[{
    missionNamespace setVariable ["GRAD_convoy_state", "STOP", true];
}, [], CONVOY_COOLDOWN] call CBA_fnc_waitAndExecute;