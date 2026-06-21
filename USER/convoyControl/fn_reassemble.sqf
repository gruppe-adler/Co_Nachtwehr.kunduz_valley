/*
 *  GRAD_convoyControl_fnc_reassemble
 *
 *  Tears the running NAGAS convoy down and rebuilds it from whatever vehicles
 *  are still alive and mobile, then puts it back on its route from where it
 *  left off. Use after the convoy has been shot up / wedged and the followers
 *  have lost cohesion or the leader is dead.
 *
 *  Sequence:
 *    1.  Snapshot the route still ahead of the convoy (see _fnc_getRouteAhead),
 *        before we lose the current leader reference.
 *    2.  Terminate the old convoy: set convoy_terminate on the convoy vehicles,
 *        which breaks every NAGAS loop/FSM (fn_pathCreator, fn_*SpeedControl, the
 *        driver/dynamic/behaviour FSMs all spin on !convoy_terminate). Release
 *        forced speeds so the survivors can be driven again.
 *    3.  Collect the survivors (alive, non-null, canMove) leader-first via
 *        _fnc_getConvoyVehicles.
 *    4.  Rebuild the new leader's group waypoints from the saved route-ahead.
 *    5.  Re-register the convoy with fn_initConvoy and re-apply the current
 *        START/STOP world state so we don't lurch into motion if we were halted.
 *
 *  Server-only authority; safe to call from a client (forwards to server).
 *
 *  No parameters.
 */

if (!isServer) exitWith {
    remoteExecCall ["GRAD_convoyControl_fnc_reassemble", 2];
};

// --- Cruise constants (must match fn_init / fn_start) ----------------------
#define CONVOY_CRUISE_SEPARATION 35
#define CONVOY_CRUISE_MAXSPEED   40

// 1. ---- Snapshot the route still ahead, using the current leader's position -
private _routeAhead = call GRAD_convoyControl_fnc_getRouteAhead;

// 2. ---- Terminate the old convoy -------------------------------------------
// convoy_terminate lives on whichever vehicle was the leader when fn_initConvoy
// last ran. That may differ from the current survivor leader (old leader could
// be the dead one), so flag every original convoy vehicle to be safe.
{
    if (isNull _x) then { continue };
    _x setVariable ["convoy_terminate", true, true];
    // Hand control back to the (now un-driven) survivors.
    _x forceSpeed -1;
    _x limitSpeed -1;
} forEach [
    multi_barkas, multi_firefighter, multi_bulldozer,
    multi_tractor, multi_fuel, multi_material_1, multi_material_2
];

// The NAGAS loops sleep up to ~pathFrequecy/speedFrequecy before they notice the
// flag and exit. Give them a beat to unwind before we re-init, otherwise an old
// loop and the new one fight over forceSpeed on the same vehicles.
[{
    params ["_routeAhead"];

    // 3. ---- Collect survivors ----------------------------------------------
    private _survivors = call GRAD_convoyControl_fnc_getConvoyVehicles;

    if (count _survivors < 2) exitWith {
        diag_log format ["[convoy] reassemble aborted: only %1 vehicle(s) left", count _survivors];
        systemChat "Convoy reassemble: not enough vehicles left.";
    };

    private _leader = _survivors select 0;

    // 4. ---- Rebuild the leader's route waypoints ---------------------------
    // Clear any stale waypoints on the new leader's group, then lay the
    // route-ahead back down as MOVE waypoints (same as fn_init does at start).
    private _grp = group _leader;
    while { (count (waypoints _grp)) > 0 } do { deleteWaypoint ((waypoints _grp) select 0) };

    {
        private _wp = _grp addWaypoint [_x, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointBehaviour "CARELESS";
        _wp setWaypointSpeed "FULL";
    } forEach _routeAhead;

    // Keep GRAD_convoy_path in sync with the route we just re-laid, so a later
    // reassemble trims from the trimmed route rather than the original.
    missionNamespace setVariable ["GRAD_convoy_path", _routeAhead, true];

    // 5. ---- Re-register and restore the START/STOP world state -------------
    Convoy_01 setVariable ["convSeparation", CONVOY_CRUISE_SEPARATION, true];
    Convoy_01 setVariable ["maxSpeed", CONVOY_CRUISE_MAXSPEED, true];

    // Re-spin the NAGAS system on the survivors. Same entry point fn_init uses;
    // fn_initConvoy resets convoy_terminate = false and restarts every loop/FSM.
    call { 0 = [Convoy_01, _survivors] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

    // fn_initConvoy always starts in drive mode. If the convoy was STOPped, hold
    // it stopped so reassembling doesn't make it bolt. Deferred so initConvoy has
    // set convoy_stopped = false first (matches fn_init's own deferred halt).
    private _wasStopped = !((missionNamespace getVariable ["GRAD_convoy_state", "STOP"]) isEqualTo "START");
    if (_wasStopped) then {
        [{
            params ["_leader"];
            Convoy_01 setVariable ["maxSpeed", 0, true];
            _leader setVariable ["convoy_stopped", true, true];
        }, [_leader], 1] call CBA_fnc_waitAndExecute;
    };

    diag_log format ["[convoy] reassembled with %1 vehicles, %2 route points ahead",
        count _survivors, count _routeAhead];
    systemChat format ["Convoy reassembled: %1 vehicles.", count _survivors];

}, [_routeAhead], 1] call CBA_fnc_waitAndExecute;
