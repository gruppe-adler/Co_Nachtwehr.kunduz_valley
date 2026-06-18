params ["_veh"];

private _items = getItemCargo _veh;
private _magazines = getMagazineCargo _veh;
private _weapons = getWeaponCargo _veh;
private _backpacks = getBackpackCargo _veh;

private _position = position _veh;
private _radius = 15;
private _chance = 2;


{
	if (random _chance > 1) then {
		private _holder = [_position, _radius] call GRAD_survivableCrash_fnc_spawnHolder;
	 	_holder addItemCargoGlobal [typeOf _x, 1];
	 	_veh removeItem _x;
	};
} forEach _items;

{
	if (random _chance > 1) then {
	 	private _holder = [_position, _radius] call GRAD_survivableCrash_fnc_spawnHolder;
	 	_holder addMagazineCargoGlobal [typeOf _x, 1];
	 	_veh removeItem _x;
	};
} forEach _magazines;

{
	if (random _chance > 1) then {
	 	private _holder = [_position, _radius] call GRAD_survivableCrash_fnc_spawnHolder;
	 	_holder addWeaponCargoGlobal [typeOf _x, 1];
	 	_veh removeItem _x;
	};
} forEach _weapons;

{
	if (random _chance > 1) then {
	 	private _holder = [_position, _radius] call GRAD_survivableCrash_fnc_spawnHolder;
	 	_holder addBackpackCargoGlobal [typeOf _x, 1];
	 	_veh removeItem _x;
	};
} forEach _backpacks;