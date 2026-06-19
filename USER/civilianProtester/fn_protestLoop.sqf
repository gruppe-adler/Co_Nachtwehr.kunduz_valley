/*
 *  GRAD_civilianProtester_fnc_protestLoop
 *
 *  Cycles the protest idle animations while the unit's state is "protesting".
 *  Stops automatically once the unit changes state (flee/cower/hostile) or dies.
 *  Server-side; switchMove propagates globally.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 */

params ["_unit"];

if (!isServer) exitWith {};
if (isNull _unit) exitWith {};

private _anims = _unit getVariable ["GRAD_protester_anims", []];
if (_anims isEqualTo []) exitWith {};

// Random start offset (0-5s) so multiple protesters don't animate in lockstep,
// plus a small per-unit jitter on the cycle period so they don't re-sync.
private _startDelay = random 5;
private _period = 8 + (random 2);

[{
    params ["_args", "_handle"];
    _args params ["_unit", "_anims"];

    if (isNull _unit || {!alive _unit} || {(_unit getVariable ["GRAD_protester_state", ""]) != "protesting"}) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    // Avoid restarting an anim that's already playing.
    private _current = animationState _unit;
    private _candidates = _anims select {_x != _current};
    if (_candidates isEqualTo []) then { _candidates = _anims; };

    _unit switchMove (selectRandom _candidates);

}, _period, [_unit, _anims], _startDelay] call CBA_fnc_addPerFrameHandler;
