/*
 *  GRAD_civilianProtester_fnc_react
 *
 *  Server-side resolution of the interaction. Picks a weighted-random
 *  outcome and runs it: flee or go hostile.
 *
 *  When a protester goes hostile (draws its weapon), every OTHER protester
 *  reacts in turn: those carrying a weapon draw and go hostile too, and all
 *  the rest flee.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 *      1: OBJECT - the player who interacted
 */

params ["_unit", "_caller"];

if (!isServer) exitWith {};
if (isNull _unit || {!alive _unit}) exitWith {};

// One-shot: ignore further interactions once reacting.
if ((_unit getVariable ["GRAD_protester_state", ""]) != "protesting") exitWith {};

private _weights = _unit getVariable ["GRAD_protester_weights", [40, 20]];
_weights params [["_wFlee", 40], ["_wHostile", 20]];

private _outcome = selectRandomWeighted ["flee", _wFlee, "hostile", _wHostile];

// Resolve this protester's reaction. The third arg is the position to flee
// away from (used for "flee"); we run from the interacting caller here.
[_unit, _outcome, _caller, _caller] call GRAD_civilianProtester_fnc_resolve;

// If this protester turned hostile, the protest breaks: every other protester
// flees, and any that carry a weapon draw and go hostile too.
if (_outcome == "hostile") then {
    {
        if (_x getVariable ["GRAD_protester_state", ""] == "protesting") then {
            private _armed = (primaryWeapon _x != "") || {handgunWeapon _x != ""};
            private _otherOutcome = if (_armed) then { "hostile" } else { "flee" };
            // Flee away from the unit that kicked things off.
            [_x, _otherOutcome, _unit, _caller] call GRAD_civilianProtester_fnc_resolve;
        };
    } forEach (allUnits select {
        (_x getVariable ["GRAD_protester_active", false]) && {_x != _unit} && {alive _x}
    });
};
