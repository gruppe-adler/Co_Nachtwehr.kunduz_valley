params ["_unit"];


[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
[_unit, true, 3 + random 30] call ace_medical_fnc_setUnconscious;
_unit allowDamage false;
	
if (_unit == player) then {
	addCamShake [10, 2, 15];
};


[{
	params ["_unit"];
	_alt = getPosATL _unit select 2;
	_speed = vectorMagnitude velocity _unit;
	_alt < 2 or _speed < .5
},{
	params ["_unit"];

	_unit action ["eject", vehicle _unit];
	if (vehicle _unit != _unit) then {
		moveOut _unit;
	};
	_unit switchMove "";
	_unitVelocity = velocity _unit;
	_unit setVelocity [0,0,0];

	private _ragdoll = [_unit, _unitVelocity] spawn {
        params ["_unit", "_vel", "_rag"];
	    _rag = "Steel_Plate_L_F" createVehicleLocal [0, 0, 0];
	    _rag setObjectTexture [0, ""];
	    _rag setMass 500;
        _magn = 12;

	    _dir = (_vel select 0) atan2 (_vel select 1);
	    _dir2 = (direction _unit) - 10 + random 20;
	    if (_dir2 > 180) then {_dir = _dir - 360;};
	    _dir = (_dir + _dir2) / 2;

	    _rag setDir _dir;
	    _bbr = boundingBoxReal _unit;
	    _unitPos = getPos _unit;

	    _rag setPosATL [
	    	(_unitPos select 0) + sin(_dir + 180), (_unitPos select 1) + cos(_dir + 180),
	    	(abs (((_bbr select 1) select 2) - ((_bbr select 0) select 2)))/2];
	    _rag setVelocity [
	        (sin(_dir)) * _magn + (_vel select 0),
	        (cos(_dir)) * _magn + (_vel select 1),
	        (_vel select 2) + random 1];
	    sleep 0.5;
	    addCamShake [5, 1, 15];
	    deleteVehicle _unit;
    };

	[{
		params ["_unit", "_ragdoll"];
		scriptDone _ragdoll
	},
	{
		params ["_unit"];

		[{
			params ["_unit"];
			isTouchingGround _unit
		},
		{
			params ["_unit"];

			private _cause = ["vehiclecrash", "explosive"] select (round random 1);
			[_unit, random [.3, .7, 1], selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], _cause] call ace_medical_fnc_addDamageToUnit;
				
			[{
				params ["_unit"];

				_unit allowDamage true;
				[_unit, false] call ace_medical_fnc_setUnconscious;

			}, [_unit], 3 + random 10] call CBA_fnc_waitAndExecute;

		}, [_unit]] call CBA_fnc_waitUntilAndExecute;

	}, [_unit, _ragdoll]] call CBA_fnc_waitUntilAndExecute;

}, [_unit]] call CBA_fnc_waitUntilAndExecute;