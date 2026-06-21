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

    // _damage is the ABSOLUTE resulting damage for this selection (already
    // includes prior damage), not a delta — so clamping it to _cap is correct
    // regardless of how hurt the vehicle already was.

    // Two paths can destroy the vehicle and both must be capped:
    //   - the overall/structural pass:  _selection "" / _hitIndex -1
    //   - the structural hull hitpoint reaching 1.0 ("hull"/"hit" on most
    //     vehicles); a single hard hit here can kill the vehicle even while the
    //     overall pass is clamped.
    // Everything else (wheels, tracks, engine, fuel, glass) passes through so the
    // vehicle still degrades and loses mobility — which is what retires it from
    // the convoy.
    private _isStructural =
        _selection isEqualTo ""
        || _hitIndex isEqualTo -1
        || (toLowerANSI _hitPoint) in ["hull", "hit", "hithull", "hithull_1"];

    if (_isStructural) exitWith {
        // Cap at _cap, but never return LESS than the damage already on this
        // selection — HandleDamage also fires for unrelated hitpoints, and on
        // those passes _damage for the structural selection can read below the
        // current value; returning it would heal the vehicle. Clamp to
        // [current, cap] so it only ever holds or climbs, up to the cap.
        private _current = if (_selection isEqualTo "" || _hitIndex isEqualTo -1) then {
            damage _unit
        } else {
            _unit getHitIndex _hitIndex
        };

        (_damage min _cap) max _current
    };

    // Per-part (mobility/cosmetic) damage passes through unchanged.
    _damage
}];
