/*
 *  GRAD_civilianProtester_fnc_initProtester
 *
 *  Turns a placed civilian unit into an animated protester that players can
 *  interact with. On interaction a random outcome fires:
 *      - flee      : drops protest, runs away from the interacting player
 *      - cower      : crouches/cowers in place
 *      - hostile    : draws a weapon and goes hostile toward players
 *
 *  Call from the unit's init field (runs everywhere, sets up on server):
 *      [this] call GRAD_civilianProtester_fnc_initProtester;
 *
 *  Optional second argument: weights array [flee, cower, hostile]
 *      [this, [40, 40, 20]] call GRAD_civilianProtester_fnc_initProtester;
 *
 *  Parameters:
 *      0: OBJECT  - the civilian unit
 *      1: ARRAY   - (optional) outcome weights [flee, cower, hostile], default [40,40,20]
 */

params [
    ["_unit", objNull, [objNull]],
    ["_weights", [40, 40, 20], [[]]]
];

if (isNull _unit) exitWith {
    diag_log "[civilianProtester] called with null unit";
};

// CfgFunctions may not be parsed yet when placed-unit init lines run.
// Defer until the function (and CBA) are available, then run on the server.
if (isNil "GRAD_civilianProtester_fnc_protestLoop") exitWith {
    [{ !isNil "GRAD_civilianProtester_fnc_protestLoop" && {!isNil "CBA_fnc_addPerFrameHandler"} }, {
        params ["_args"];
        _args call GRAD_civilianProtester_fnc_initProtester;
    }, [_unit, _weights]] call CBA_fnc_waitUntilAndExecute;
};

// ---- Tunables -------------------------------------------------------------
// Protest idle animations. Each protester picks ONE of these and loops only
// that one (no cycling between different anims, so there are no visible jumps).
// Allowed loops and their matching "_out" transitions:
//   Acts_JetsMarshallingStraight_loop -> Acts_JetsMarshallingStraight_out
//   Acts_Kore_IdleNoWeapon_loop       -> Acts_Kore_IdleNoWeapon_out
private _protestAnims = [
    "Acts_JetsMarshallingStraight_loop",
    "Acts_Kore_IdleNoWeapon_loop"
];
// ---------------------------------------------------------------------------

// Mark so we don't double-init and so other scripts can detect protesters.
if (_unit getVariable ["GRAD_protester_active", false]) exitWith {};
_unit setVariable ["GRAD_protester_active", true, true];

// Run setup authoritatively on the server.
if (!isServer) exitWith {};

// Pick one loop animation for this unit and stick with it.
private _protestAnim = selectRandom _protestAnims;

_unit setVariable ["GRAD_protester_state", "protesting", true];
_unit setVariable ["GRAD_protester_anim", _protestAnim, true];
_unit setVariable ["GRAD_protester_weights", _weights, true];

// Pacify so it behaves like a civilian until provoked.
_unit setCaptive true;
_unit disableAI "PATH";
_unit setBehaviour "CARELESS";

// Kick off the protest animation loop (server-side; switchMove is global).
[_unit] call GRAD_civilianProtester_fnc_protestLoop;

// Add the interaction action to every machine via remoteExec.
[_unit] remoteExec ["GRAD_civilianProtester_fnc_addAction", 0, _unit];
