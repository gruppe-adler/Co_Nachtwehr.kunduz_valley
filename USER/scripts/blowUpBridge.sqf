private _pos = getPos bridge;

if (isServer) then 
{
    [_pos] spawn {
        params ["_pos"];

        {
            _x setDamage 1;
            sleep (random 0.8);
        } forEach [bridge_IED_1, bridge_IED_2, bridge];

        private _explosion = "gm_rocket_luna_he_3r9" createVehicle _pos;
        _explosion setVelocity [0,0,-100];
            
        ["USER\scripts\revealAndHideMarkers.sqf"] remoteExec ["execvm", 0, true];

        "test_EmptyObjectForFireBig" createVehicle position bridge_end1;
        "test_EmptyObjectForFireBig" createVehicle position bridge_end2;
    };
};
