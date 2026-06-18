["Initialize"] call BIS_fnc_dynamicGroups;



// multi loading
[multi_bulldozer_object, multi_bulldozer_flatbed] call BIS_fnc_attachToRelative;
// multi_bulldozer setVehicleCargo multi_bulldozer_flatbed; 
multi_bulldozer setVariable ["BWA3_Multi_LoadedContainer", multi_bulldozer_flatbed, true]; 
multi_bulldozer_flatbed attachTo [multi_bulldozer, [0, -1.99, 1.05], "pritsche_complete", true];


[multi_tractor_object, multi_tractor_flatbed] call BIS_fnc_attachToRelative;
// multi_tractor setVehicleCargo multi_tractor_flatbed; 
multi_tractor setVariable ["BWA3_Multi_LoadedContainer", multi_tractor_flatbed, true]; 
multi_tractor_flatbed attachTo [multi_tractor, [0, -1.99, 1.05], "pritsche_complete", true];


private _convoyLogic = createCenter sideLogic;
private _convoyGroup = createGroup _convoyLogic;
Convoy_01 = _convoyGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
Convoy_01 setVariable ["maxSpeed", 40];
Convoy_01 setVariable ["convSeparation", 35];
Convoy_01 setVariable ["stiffnessCoeff", 0.2];
Convoy_01 setVariable ["dampingCoeff", 0.6];
Convoy_01 setVariable ["curvatureCoeff", 0.3];
Convoy_01 setVariable ["stiffnessLinkCoeff", 0.1];
Convoy_01 setVariable ["pathFrequecy", 0.05];
Convoy_01 setVariable ["speedFrequecy", 0.2];
Convoy_01 setVariable ["speedModeConv", "NORMAL"];
Convoy_01 setVariable ["behaviourConv", "pushThroughContact"];
Convoy_01 setVariable ["debug", false];

publicVariable "Convoy_01";

call{ 0 = [Convoy_01,[multi_barkas, multi_firefighter,multi_bulldozer,multi_tractor,multi_fuel,multi_material_1,multi_material_2]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };