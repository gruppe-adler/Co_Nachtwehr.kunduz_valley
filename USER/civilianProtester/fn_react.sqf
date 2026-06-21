/*
 *  GRAD_civilianProtester_fnc_react
 *
 *  Server-side resolution of the interaction. Picks a weighted-random
 *  outcome and runs it: flee, cower, or go hostile.
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

private _weights = _unit getVariable ["GRAD_protester_weights", [40, 40, 20]];
_weights params [["_wFlee", 40], ["_wCower", 40], ["_wHostile", 20]];

private _outcome = selectRandomWeighted ["flee", _wFlee, "cower", _wCower, "hostile", _wHostile];
_unit setVariable ["GRAD_protester_state", _outcome, true];

// Play a reaction voiceline (stub) depending on outcome.
[_unit, _outcome] call GRAD_civilianProtester_fnc_reactVoice;

// Stop the protest idle loop by playing its matching "_out" transition, so we
// leave the loop cleanly instead of snapping to the default stance.
private _protestAnim = _unit getVariable ["GRAD_protester_anim", ""];
private _outAnim = switch (_protestAnim) do {
    case "Acts_JetsMarshallingStraight_loop": { "Acts_JetsMarshallingStraight_out" };
    case "Acts_Kore_IdleNoWeapon_loop":       { "Acts_Kore_IdleNoWeapon_out" };
    default { "" };
};
if (_outAnim != "") then { _unit switchMove _outAnim; } else { _unit switchMove ""; };
_unit enableAI "PATH";

switch (_outcome) do {

    // ---- FLEE -------------------------------------------------------------
    case "flee": {
        _unit setBehaviour "AWARE";
        _unit setSpeedMode "FULL";
        _unit forceSpeed -1;
        _unit allowFleeing 1;

        // Run to a point ~80m away from the caller.
        private _dir = [_caller, _unit] call BIS_fnc_dirTo;
        private _fleePos = _unit getPos [80, _dir];
        _fleePos = [_fleePos, 0, 25, 1, 0, 0.3, 0] call BIS_fnc_findSafePos;
        _unit doMove _fleePos;

        // Re-issue the move a few times so they keep running.
        [{
            params ["_args", "_handle"];
            _args params ["_unit", "_fleePos", "_count"];
            if (isNull _unit || {!alive _unit} || {_count > 6} || {_unit distance _fleePos < 10}) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };
            _unit doMove _fleePos;
            _args set [2, _count + 1];
        }, 4, [_unit, _fleePos, 0]] call CBA_fnc_addPerFrameHandler;
    };

    // ---- COWER ------------------------------------------------------------
    case "cower": {
        _unit disableAI "PATH";
        _unit setBehaviour "CARELESS";
        // Stay in place using the calm idle loop (only the two allowed anims).
        _unit switchMove "Acts_Kore_IdleNoWeapon_loop";
    };

    // ---- HOSTILE ----------------------------------------------------------
    case "hostile": {
        // Move to the opposing side so they actually engage players.
        [_unit] join grpNull;
        private _grp = createGroup [east, true];
        [_unit] joinSilent _grp;

        _unit setCaptive false;

        // Give a weapon if unarmed.
        if (primaryWeapon _unit == "" && {handgunWeapon _unit == ""}) then {
            _unit addMagazines ["16Rnd_9x21_Mag", 3];
            _unit addWeapon "hgun_Rook40_F";
        };

        // Draw and engage.
        private _wpn = primaryWeapon _unit;
        if (_wpn == "") then { _wpn = handgunWeapon _unit; };
        if (_wpn != "") then { _unit selectWeapon _wpn; };

        _unit setBehaviour "COMBAT";
        _unit setCombatMode "RED";
        _unit enableAI "TARGET";
        _unit enableAI "AUTOTARGET";
        _unit forceSpeed -1;

        if (alive _caller) then {
            _unit doTarget _caller;
            _unit doFire _caller;
        };
    };
};
