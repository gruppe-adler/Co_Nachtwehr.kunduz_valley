/*
 *  GRAD_convoyControl_fnc_addDamageCap
 *  Convoy vehicle can be wrecked and immobilised but never destroyed.
 *  Runs on every machine (remoteExec'd globally + JIP). HandleDamage only fires
 *  where the vehicle is local, so exactly one copy ever acts.
 *  Param 0: OBJECT - convoy vehicle.
 */

params [["_vehicle", objNull, [objNull]]];
if (isNull _vehicle) exitWith {};

_vehicle addEventHandler ["HandleDamage", {
    params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    if (isNull _instigator) then {_damage = _veh getHit _selection};
    private _hit = toLowerAnsi _hitPoint;
    if ("body" in _hit || "hull" in _hit || _hit isEqualTo "") then {
        _damage = _damage min 0.89;
    };

    // Fuel tank - never destroyed. Fuel leaks in proportion to this hitpoint's
    // damage, so 0 = no leak at all.
    if ("fuel" in _hit) then {
        _damage = _damage min 0;
    };
    _damage
}];
