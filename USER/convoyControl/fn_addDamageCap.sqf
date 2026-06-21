/*
 *  GRAD_convoyControl_fnc_addDamageCap
 *
 *  Caps a convoy vehicle's overall damage so it can be wrecked and immobilised
 *  but never fully destroyed (which would leave an undriveable, un-reassemblable
 *  husk). Per-part damage (wheels, engine, fuel) still passes through so the
 *  vehicle visibly degrades and can lose mobility; only the global hull value is
 *  clamped.
 *
 *  Runs on EVERY machine (remoteExec'd globally from fn_init with JIP), so the
 *  handler exists wherever the vehicle happens to be local now or after a
 *  locality change (remote driving). HandleDamage only fires on the local
 *  machine, so exactly one registered copy acts; the rest no-op.
 *
 *  Parameters:
 *      0: OBJECT - convoy vehicle
 *
 *  No return.
 */

params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {};

// Per-machine guard against double assignment. NOT broadcast: each machine must
// register its own HandleDamage handler exactly once.
if (_vehicle getVariable ["GRAD_convoy_damageCapped", false]) exitWith {};
_vehicle setVariable ["GRAD_convoy_damageCapped", true];

// Highest overall damage we let the vehicle reach. Below 1 so it never blows up.
// Set locally on each machine; read inside the handler on whichever is local.
_vehicle setVariable ["GRAD_convoy_maxDamage", 0.88];

_vehicle addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "", "", "_hitIndex", "", "_hitPoint"];

    // HandleDamage must be handled where the vehicle is local.
    if (!local _unit) exitWith {};

    private _cap = _unit getVariable ["GRAD_convoy_maxDamage", 0.88];

    // The overall/structural damage is reported on the "" (empty) selection /
    // hitIndex -1 pass. Clamp only that; leave individual hitpoints alone so the
    // vehicle can still take component damage and become immobile.
    if (_selection isEqualTo "" || _hitIndex isEqualTo -1) exitWith {
        _damage min _cap
    };

    // Per-part damage passes through unchanged.
    _damage
}];
