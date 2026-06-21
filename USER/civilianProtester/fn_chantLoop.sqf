/*
 *  GRAD_civilianProtester_fnc_chantLoop
 *
 *  Makes the protester shout a random crowd chant (Rus1..Rus20) roughly every
 *  10 seconds while its state is "protesting". The interval is jittered per
 *  shout so the crowd doesn't chant in lockstep. Stops automatically once the
 *  unit changes state (flee/hostile) or dies.
 *
 *  Server-side. say3D has LOCAL effect only, so each shout is remoteExec'd to
 *  all machines (JIP-skipped) to be heard by every client.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 */

params ["_unit"];

if (!isServer) exitWith {};
if (isNull _unit) exitWith {};

private _chants = [
    "Rus1","Rus2","Rus3","Rus4","Rus5","Rus6","Rus7","Rus8","Rus9","Rus10",
    "Rus11","Rus12","Rus13","Rus14","Rus15","Rus16","Rus17","Rus18","Rus19","Rus20"
];

// Schedule one shout, then re-arm with a fresh ~10s (+/-) delay. Using a
// one-shot waitAndExecute chain (rather than a fixed-period handler) lets each
// protester pick a new random gap every time, so the crowd stays desynced.
private _fnc_shout = {
    params ["_unit", "_chants", "_fnc_shout"];

    if (isNull _unit || {!alive _unit} || {(_unit getVariable ["GRAD_protester_state", ""]) != "protesting"}) exitWith {};

    // say3D is local-effect only — push it to every client. The "false" JIP
    // arg means a player joining later won't replay a stale shout.
    [_unit, selectRandom _chants, 100] remoteExec ["say3D", 0, false];

    // ~10s with randomness (7-13s) until the next shout.
    private _delay = 7 + (random 6);
    [_fnc_shout, [_unit, _chants, _fnc_shout], _delay] call CBA_fnc_waitAndExecute;
};

// Stagger the first shout (0-10s) so they don't all start together.
[_fnc_shout, [_unit, _chants, _fnc_shout], random 10] call CBA_fnc_waitAndExecute;
