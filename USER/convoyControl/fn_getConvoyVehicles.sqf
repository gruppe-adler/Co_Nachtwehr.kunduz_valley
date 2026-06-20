/*
 *  GRAD_convoyControl_fnc_getConvoyVehicles
 *
 *  Returns the convoy vehicles that are still null-free, alive and mobile,
 *  leader first. Used by start/stop to resolve the current leader.
 *
 *  Returns: ARRAY of OBJECT
 */

private _initialConvoy = [
    multi_barkas,
    multi_firefighter,
    multi_bulldozer,
    multi_tractor,
    multi_fuel,
    multi_material_1,
    multi_material_2
];

private _remainingConvoy = [];

// filter for valid vehicles and store in remainingConvoy
// (continue skips the bad one; exitWith would abort the whole loop)
{
    if (isNull _x || {!alive _x} || {!canMove _x}) then { continue };

    _remainingConvoy pushBack _x;
} forEach _initialConvoy;

_remainingConvoy