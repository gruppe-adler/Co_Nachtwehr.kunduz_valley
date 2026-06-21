/*
 *  GRAD_civilianProtester_fnc_protestLoop
 *
 *  Keeps the unit's single protest idle animation looping while its state is
 *  "protesting". Only ever (re-)issues that one anim, so there are no jumps
 *  between different animations. Stops automatically once the unit changes
 *  state (flee/hostile) or dies.
 *  Server-side; switchMove propagates globally.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 */

params ["_unit"];

if (!isServer) exitWith {};
if (isNull _unit) exitWith {};

private _anim = _unit getVariable ["GRAD_protester_anim", ""];
if (_anim == "") exitWith {};

// Start the loop immediately, then refresh it periodically in case the engine
// drops it back to a default stance. Random start offset (0-5s) so multiple
// protesters don't animate in lockstep, plus a small per-unit jitter so they
// don't re-sync.
_unit switchMove _anim;

private _startDelay = 8 + (random 5);
private _period = 8 + (random 2);

[{
    params ["_args", "_handle"];
    _args params ["_unit", "_anim"];

    if (isNull _unit || {!alive _unit} || {(_unit getVariable ["GRAD_protester_state", ""]) != "protesting"}) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    // Re-issue the same loop only if it has fallen out of it (avoids restarting
    // a loop that's already playing, which would cause a visible jump).
    if (animationState _unit != toLower _anim) then {
        _unit switchMove _anim;
    };

}, _period, [_unit, _anim], _startDelay] call CBA_fnc_addPerFrameHandler;
