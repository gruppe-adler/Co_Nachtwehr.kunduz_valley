params ["_vehicle"];

private _pallet = "Land_Pallet_F" createVehicle [0,0,0];

private _foodStack = 
[
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.529297,-0.325195,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.156738,-0.332031,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.208984,-0.334961,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.571289,-0.342773,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.598145,0.302734,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.236328,0.3125,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.128418,0.314453,0.16],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.501953,0.321289,0.16],[[0.00442079,-0.99999,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.326172,0.443359,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.362793,-0.00488281,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.370605,-0.446289,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.322754,-0.445313,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.3125,-0.0107422,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.351074,0.399414,0.27],[[0.999976,-0.00698149,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.529297,-0.325195,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.156738,-0.332031,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.208984,-0.334961,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.571289,-0.342773,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.598145,0.302734,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.236328,0.3125,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.128418,0.314453,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.501953,0.321289,0.40],[[0.00442079,-0.99999,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.326172,0.443359,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.362793,-0.00488281,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.370605,-0.446289,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.322754,-0.445313,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.3125,-0.0107422,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.351074,0.399414,0.51],[[0.999976,-0.00698149,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.529297,-0.325195,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.156738,-0.332031,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.208984,-0.334961,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.571289,-0.342773,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.598145,0.302734,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.236328,0.3125,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.128418,0.314453,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.501953,0.321289,0.64],[[0.00442079,-0.99999,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.326172,0.443359,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.362793,-0.00488281,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.370605,-0.446289,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.322754,-0.445313,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.3125,-0.0107422,0.27],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.351074,0.399414,0.27],[[0.999976,-0.00698149,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.529297,-0.325195,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.156738,-0.332031,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.208984,-0.334961,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.571289,-0.342773,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.598145,0.302734,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.236328,0.3125,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.128418,0.314453,0.40],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.501953,0.321289,0.40],[[0.00442079,-0.99999,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.326172,0.443359,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.362793,-0.00488281,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.370605,-0.446289,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.322754,-0.445313,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.3125,-0.0107422,0.51],[[0.999976,-0.00698149,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.351074,0.399414,0.51],[[0.999976,-0.00698149,0],[0,0,1]]]
	],
	[
		["Land_FoodSack_01_full_brown_idap_F",[-0.529297,-0.325195,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.156738,-0.332031,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.208984,-0.334961,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.571289,-0.342773,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.598145,0.302734,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[0.236328,0.3125,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.128418,0.314453,0.64],[[0.00442079,-0.99999,0],[0,0,1]]],
		["Land_FoodSack_01_full_brown_idap_F",[-0.501953,0.321289,0.64],[[0.00442079,-0.99999,0],[0,0,1]]]
	]
];

private _foodBags = [];

{
	{
		_x params ["_classname", "_offset", "_vectorDirAndUp"];

		_offset set [2, (_forEachIndex + 1) * 0.15];
		private _food = _classname createVehicle [0,0,0];
		_food attachTo [_pallet, _offset];
		_food setVectorDirAndUp _vectorDirAndUp;
		_food setVariable ["ace_cargo_canLoad", false, true];
		_foodBags pushBackUnique _food;	
	} forEach _x;

} forEach _foodStack;

_vehicle setVehicleCargo _pallet;

private _pallets = _vehicle getVariable ["GRAD_pallets", []];
_pallets pushBackUnique _pallet;
_vehicle setVariable ["GRAD_pallets", _pallets, true];

_pallet setVariable ["GRAD_food", _foodBags, true];
_pallet setVariable ["ace_cargo_canLoad", true, true];
[_pallet, false, [0,2,1], 0, false] remoteExec ["ace_dragging_fnc_setCarryable", 0, true];
[_pallet, true, [0,2,1], 0, true] remoteExec ["ace_dragging_fnc_setDraggable", 0, true];

systemChat str (_pallet getVariable ["GRAD_food", ""]);

_pallet addAction
[
	"Take FoodBag",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];

		// private _pallets = _target getVariable ["GRAD_pallets", []];
		// private _countPallets = count _pallets;

		// if (_countPallets > 0) then {	
			private _allFood = _target getVariable ["GRAD_food", []];
			private _count = count _allFood;
			if (_count > 0) then {
				private _index = (_count-1);
				private _foodBag = _allFood select _index;
				[_foodBag, true, [0,1,1], 0, false] call ace_dragging_fnc_setCarryable;
				[_caller, _foodBag] call ace_dragging_fnc_startCarry;
				_allFood deleteAt _index;
				_target setVariable ["GRAD_food", _allFood, true];
			};
		// };
	},
	nil,
	1.5,
	true,
	true,
	"",
	"!(_this getVariable ['ace_dragging_isCarrying', false])", // _target, _this, _originalTarget
	2,
	false,
	"",
	""
];


private _civilians = player nearEntities ["Man", 50]; 
 
 { 
  if (side _x == civilian) then { 
   [_x, _pallet] execvm "user\civilianBehaviour\fn_civilianUnload.sqf"; 
  }; 
 } forEach _civilians;