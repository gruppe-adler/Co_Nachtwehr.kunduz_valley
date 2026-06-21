/*
 *  GRAD_civilianProtester_fnc_resolve
 *
 *  Applies a single reaction outcome (flee or hostile) to one protester.
 *  Factored out of fn_react so the same behavior can be applied both to the
 *  protester that was interacted with and to the other protesters that react
 *  once the first one turns hostile.
 *
 *  Runs on the server.
 *
 *  Parameters:
 *      0: OBJECT - the protester to resolve
 *      1: STRING - the outcome: "flee" | "hostile"
 *      2: OBJECT - the object to flee away from (used by "flee")
 *      3: OBJECT - the player who started the interaction (hostile target)
 */

params ["_unit", "_outcome", "_awayFrom", "_caller"];

if (!isServer) exitWith {};
if (isNull _unit || {!alive _unit}) exitWith {};

// One-shot per unit: ignore if this protester already left the protest state.
if ((_unit getVariable ["GRAD_protester_state", ""]) != "protesting") exitWith {};

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

// Fully hand the unit back to the AI so it can actually move. enableAI "PATH"
// restores the engine pathing subsystem; clearing lambs_danger_disableAI lifts
// LAMBS Danger's movement/danger suppression (set on these units in the
// editor) — without this the unit keeps its weapon/anim change but never paths,
// which is why only some of the crowd appeared to flee.
_unit enableAI "PATH";
_unit enableAI "MOVE";
_unit setVariable ["lambs_danger_disableAI", false, true];

switch (_outcome) do {

    // ---- FLEE -------------------------------------------------------------
    case "flee": {
        // Break out of the protest "_out" transition immediately — that anim is
        // full-body and locks the unit, so doMove wouldn't take effect until it
        // finished, which is why some of the crowd appeared frozen. Reset to the
        // default stance on every machine so they can start running at once.
        [_unit, ""] remoteExec ["switchMove", 0];

        _unit setBehaviour "AWARE";
        _unit setSpeedMode "FULL";
        _unit forceSpeed -1;
        _unit allowFleeing 1;

        // Run to a point ~80m away from the threat.
        private _dir = [_awayFrom, _unit] call BIS_fnc_dirTo;
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
