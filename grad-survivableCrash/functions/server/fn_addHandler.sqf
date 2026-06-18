/*
	damage handling is done potentially on any client the vehicle is local to
*/

params ["_vehicle"];

// safecheck to prevent double assigning
if (_vehicle getVariable ["GRAD_survivableCrash_isHandled", false]) exitWith {};
_vehicle setVariable ["GRAD_survivableCrash_isHandled", true];

_vehicle setVariable ["ace_cookoff_enable", false, true];

_vehicle addEventHandler ["HandleDamage", {
	params [
		"_unit", 
		"_selection", 
		"_damage", 
		"_source", 
		"_projectile", 
		"_hitIndex", 
		"_instigator", 
		"_hitPoint"
	];

	if (!local _unit) exitWith {};

	private _returnVal = _damage;
	private _health = 0;

	// ignore any damage after vehicle is shot down
	if (!(_unit getVariable ["GRAD_survivableCrash_shotDown", false])) exitWith {
		0
	};


	// detect health
	if(_hitIndex == -1) then {
		_health = damage _unit;
	} else {
		_health = _unit getHit hitSelection;
	};

	// ignore if damage is maxed out
	// if(_health >= 1) exitWith { 0 };


	// trigger shotdown
	if (_health + _damage > 0.88) then { // this is wrong and needs to be fixed
		if (_index == -1 or hitSelection == "hull_hit") then {
			_returnVal = 0;
		
			if (!(_unit getVariable ["GRAD_survivableCrash_shotDown", false])) then {
				_unit setVariable ["GRAD_survivableCrash_shotDown", true, true];

				systemChat "entering oncrash";
				diag_log "entering oncrash";
				// effects are managed by server
	    		[_unit] remoteExecCall ["GRAD_survivableCrash_fnc_onCrash", 2];
			};
		};
	};
	_returnVal
}];
