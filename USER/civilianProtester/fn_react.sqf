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
 *  The crowd only turns violent once it's been worked up: nobody can go hostile
 *  until GRAD_protester_hostileThreshold (default 15) protesters have been
 *  provoked. Before that, every interaction just makes the person flee. Set the
 *  threshold in the editor / init.sqf, e.g.:
 *      missionNamespace setVariable ["GRAD_protester_hostileThreshold", 10];
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

// Count how many protesters have been provoked so far (mission-wide). The crowd
// stays peaceful at first: nobody pulls a weapon until enough people have been
// stirred up, so the very first person talked to just flees. Only once the
// provocation count reaches the threshold can the hostile outcome roll.
private _provoked = (missionNamespace getVariable ["GRAD_protester_provokedCount", 0]) + 1;
missionNamespace setVariable ["GRAD_protester_provokedCount", _provoked, true];
private _hostileThreshold = missionNamespace getVariable ["GRAD_protester_hostileThreshold", 15];

private _outcome = if (_provoked < _hostileThreshold) then {
    "flee"
} else {
    private _weights = _unit getVariable ["GRAD_protester_weights", [40, 20]];
    _weights params [["_wFlee", 40], ["_wHostile", 20]];
    selectRandomWeighted ["flee", _wFlee, "hostile", _wHostile]
};

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
