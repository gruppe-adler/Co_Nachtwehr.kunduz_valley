params ["_vehicle"];

if (_vehicle getVariable ["GRAD_survivableCrash_shotDown", false]) exitWith {};

if (isEngineOn _vehicle && 
    (_vehicle isKindOf "Helicopter")
    ) then {

    private _damage = _vehicle getHitPointDamage "HitEngine";

    if (_damage < 0.8) then {
        _damage = _damage + 0.02;
        _vehicle setHitPointDamage ["HitEngine", _damage];
    } else {
        systemChat "executing oncrash";
        diag_log "executing oncrash";
        _x setVariable ["GRAD_survivableCrash_shotDown", true, true];
    	[_x] call GRAD_survivableCrash_fnc_onCrash;
	};
};