private _manuallyAddedVehicles = missionNamespace getVariable ["GRAD_survivableCrash_vehicles", []];

{
	if (_x isKindOf "Air") then {
		[_x] call GRAD_survivableCrash_fnc_addHandler;
	};
} forEach vehicles + _manuallyAddedVehicles;