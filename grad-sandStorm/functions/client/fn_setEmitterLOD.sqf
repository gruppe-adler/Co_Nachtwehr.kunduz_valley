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

for "_i" from 0 to (_LODCount-1) do {
	
	(_LODDefinitions select _i) params ["_triggerSize", "_dropRate"];
	_dropRate params ["_dropRateDefault", "_dropRateFiller"];

	private _triggerIdentifier = format ["ODE_LODTrigger_%1", _i];
	private _trigger = player getVariable [_triggerIdentifier, objNull];
	// inAreaArray already returns the subset of the working copy inside this ring
	private _positionsForThisLOD = _arrayWorkingCopy inAreaArray _trigger;
	_arrayWorkingCopy = _arrayWorkingCopy - _positionsForThisLOD;

	//systemChat format ["positions %1 in _positionsForThisLOD %2", count _positionsForThisLOD, _i];
	//diag_log format ["positions %1 in _positionsForThisLOD %2", count _positionsForThisLOD, _i];
	{
	  	[_x, _helperObject, [_dropRateDefault, _dropRateFiller] select (_type == "filler")] call GRAD_sandstorm_fnc_adjustEmitter;
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