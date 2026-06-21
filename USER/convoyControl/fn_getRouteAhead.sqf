/*
 *  GRAD_convoyControl_fnc_getRouteAhead
 *
 *  Returns the portion of the convoy route the convoy has NOT yet driven, so a
 *  reassembled convoy resumes from where it got to instead of restarting at the
 *  origin.
 *
 *  The route is the editor path published by fn_init as GRAD_convoy_path
 *  (an ordered ARRAY of positions, origin first). We find the route point
 *  nearest the current leader and return everything from there onward.
 *
 *  Note: this is the LEADER's group waypoint route (what NAGAS actually drives),
 *  not the fn_pathCreator breadcrumb trail (which is internal follower spacing).
 *
 *  Returns: ARRAY of positions (route still ahead). Empty if no route/leader.
 */

private _route  = missionNamespace getVariable ["GRAD_convoy_path", []];
private _leader = (call GRAD_convoyControl_fnc_getConvoyVehicles) param [0, objNull];

if (_route isEqualTo [] || isNull _leader) exitWith { _route };

private _leaderPos = getPosATL _leader;

// Index of the route point closest to the leader.
private _nearestIdx = 0;
private _nearestDist = 1e39;
{
    private _d = _leaderPos distance _x;
    if (_d < _nearestDist) then {
        _nearestDist = _d;
        _nearestIdx = _forEachIndex;
    };
} forEach _route;

// Resume from the nearest point. We don't skip it: re-issuing the point the
// leader is sitting on is harmless and avoids overshooting a corner if the
// leader stopped just short of it.
_route select [_nearestIdx, (count _route) - _nearestIdx]
