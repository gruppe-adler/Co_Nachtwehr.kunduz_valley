params ["_type", "_sandstormIdentifier"];

private _emittersArray = [_type, _sandstormIdentifier] call GRAD_sandstorm_fnc_getEmitterArray;

// delete unnecessary emitters
{deleteVehicle _x} forEach _emittersArray;

if (GRAD_SANDSTORM_DEBUG) then {
    systemChat format ["deleting emitter array %1", _sandstormIdentifier];
};