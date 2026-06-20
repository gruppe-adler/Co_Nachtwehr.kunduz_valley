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

