params ["_vehicle"];


[{
	params ["_args", "_handle"];
	_args params ["_vehicle"];

	if (isNull _vehicle) exitWith { [_handle] call CBA_fnc_removePerFramehandler; };

	private _containerLoaded = _vehicle getVariable ["BWA3_Multi_LoadedContainer", objNull];
	private _containerLoadedCached = _vehicle getVariable ["BWA3_Multi_LoadedContainerCached", objNull];
	private _hookAnimationState = _vehicle animationSourcePhase "bwa3_hook_animation";
	private _hookDown = _hookAnimationState == 1;
	private _hookAnimating = _hookAnimationState < 1 && _hookAnimationState > 0;
	private _hookUp = _hookAnimationState == 0;
	private _hookState = 0;
	private _hookStateBefore =  _vehicle getVariable ["GRAD_hookState", 0];
	if (_hookAnimating) then { _hookState = 1; };
	if (_hookDown) then { _hookState = 2; };

	private _hookStateChanged = false;
	if (_hookState != _hookStateBefore) then {
		_hookStateChanged = true;
	};
	
	// attach stuff from container to vehicle
	if (_hookUp && _hookStateChanged) then {
		private _attachedObjects = attachedObjects _containerLoaded;
		
		{
			private _object = _x;
			if (!isNull (isVehicleCargo _object)) then {
				_object setVariable ["grad_isVehicleCargo", true];
			};
			[_object, _vehicle, true] call BIS_fnc_attachToRelative;
		} forEach _attachedObjects;		
		// "attach stuff to vehicle" call CBA_fnc_notify;

		_containerLoaded setVariable ["GRAD_containerOnVehicle", true, true];
	};

	// attach stuff from vehicle to container
	if (_hookAnimating && _hookStateChanged && _hookStateBefore == 0) then {
		private _attachedObjects = attachedObjects _vehicle;
		
		
		{
			private _object = _x;
			if (_object getVariable ["grad_isVehicleCargo", false]) then {
				_containerLoaded setVehicleCargo _object;
			} else {
				[_object, _containerLoaded, true] call BIS_fnc_attachToRelative;
			};
		} forEach _attachedObjects;		
		// "attach stuff to container" call CBA_fnc_notify;

		_containerLoaded setVariable ["GRAD_containerOnVehicle", false, true];
	};

	_vehicle setVariable ["GRAD_hookState", _hookState];

}, 0, [_vehicle]] call CBA_fnc_addPerFrameHandler;

/*
 "bwa3_hook_animation" <= 0.5

_container attachTo [_vehicle, [0, -1.99, 1.05], "pritsche_complete", true];

// container loaded
	/*
	if (!isNull _containerLoaded && isNull _containerLoadedCached) then {
		_vehicle setVariable ["BWA3_Multi_LoadedContainerCached", _containerLoaded];		
	};

	// container unloaded
	if (isNull _containerLoaded && !isNull _containerLoadedCached) then {
		_vehicle setVariable ["BWA3_Multi_LoadedContainerCached", objNull];		
	};
	*/
