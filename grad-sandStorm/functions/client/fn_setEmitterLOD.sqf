/*

	calculates drop rate

	trigger intersects with trigger

*/


params ["_type", "_helperObject", "_sandstormIdentifier"];


private _LODDefinitions = player getVariable ["ODE_LODTriggerDefinitions", []];
private _LODCount = count _LODDefinitions;

// systemChat format ["_arrayOriginal %1", _arrayOriginal];
// diag_log format ["_arrayOriginal %1", _arrayOriginal];

private _arrayOriginal = [_type, _sandstormIdentifier] call GRAD_sandstorm_fnc_getEmitterArray;
private _arrayWorkingCopy = +_arrayOriginal;

// View-cone culling: the wall is a full ring but the player only ever sees the
// arc they are facing. Emitters outside the view cone are disabled regardless of
// distance, which keeps the engine particle budget for what is actually on screen
// and stops the popping caused by exceeding the global cap.
private _camPos = positionCameraToWorld [0,0,0];
private _camDir = (positionCameraToWorld [0,0,1]) vectorDiff _camPos;
private _camHeading = (_camDir select 0) atan2 (_camDir select 1);
// half-angle of the cone; generous so turning doesn't pop the wall in late
private _halfCone = 80;
// emitters closer than this are never cone-culled: when you turn, nearby
// particles must already be present or they pop in obviously up close
private _nearKeepDist = 250;
// far-side cull: kill the arc on the OPPOSITE side of the ring from the viewer.
// The cutoff is measured relative to the storm centre, not an absolute radius, so
// it adapts to where the player stands:
//   - outside looking in -> camToCentre ~= radius, cutoff ~= 1.5*radius (keeps the
//     visible far rim, only trims what is genuinely beyond the storm)
//   - inside the storm    -> camToCentre small, cutoff ~= 0.5*radius (culls the
//     opposite wall, which is occluded by the near wall)
private _stormRadius = missionNamespace getVariable [format ["GRAD_sandstorm_radius_%1", _sandstormIdentifier], 1e9];
private _camToCentre = _camPos distance2D (getPosWorld _helperObject);
private _farCullDist = _camToCentre + (_stormRadius * 0.5);

for "_i" from 0 to (_LODCount-1) do {

	(_LODDefinitions select _i) params ["_triggerSize", "_dropRate"];
	_dropRate params ["_dropRateDefault", "_dropRateFiller"];

	private _triggerIdentifier = format ["ODE_LODTrigger_%1", _i];
	private _trigger = player getVariable [_triggerIdentifier, objNull];
	// inAreaArray already returns the subset of the working copy inside this ring
	private _positionsForThisLOD = _arrayWorkingCopy inAreaArray _trigger;
	_arrayWorkingCopy = _arrayWorkingCopy - _positionsForThisLOD;

	private _interval = [_dropRateDefault, _dropRateFiller] select (_type == "filler");

	{
		// vector + distance from the camera (the actual viewpoint) to this emitter.
		// getPosWorld returns true world coords even though the emitter is attached
		// to the helper object (getPos/getPosVisual would give attach-relative coords).
		private _toEmitter = (getPosWorld _x) vectorDiff _camPos;
		private _camDist = _toEmitter distance2D [0,0,0];
		private _heading = (_toEmitter select 0) atan2 (_toEmitter select 1);
		private _delta = abs (((_heading - _camHeading) + 540) mod 360 - 180);

		// keep if: near (avoid pop-in) OR (within the view cone AND not the far arc)
		if (_camDist < _nearKeepDist || (_delta <= _halfCone && _camDist <= _farCullDist)) then {
			[_x, _helperObject, _interval] call GRAD_sandstorm_fnc_adjustEmitter;
		} else {
			// off-screen or far side: stop it to save the particle budget
			_x setDropInterval 5;
			_x enableSimulation false;
		};
	} forEach _positionsForThisLOD;
};

// emitters outside every LOD ring: throttle to a moderate interval AND stop
// simulation. A huge interval (e.g. 10000) is not used here because the source
// has to finish its current tick before speeding back up, which leaves a long
// gap when the emitter re-enters range. A moderate cap keeps re-entry snappy.
if (count _arrayWorkingCopy > 0) then {
	{
		_x setDropInterval 5;
		_x enableSimulation false;
	} forEach _arrayWorkingCopy;
};