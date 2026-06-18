/*

	["borderBottom", "new", _emitter] call GRAD_sandstorm_fnc_addToEmitterArray;

*/

params ["_type", "_sandstormIdentifier", "_emitter"];

private _identifier = format ["GRAD_sandstormEmitterArray_%1_%2", _type, _sandstormIdentifier];

private _existingArray = missionNamespace getVariable [_identifier, []];

_existingArray pushBack _emitter;

// diag_log format ["pushing back %1 in %2 for %3", _emitter, _existingArray, _identifier];
// set value
missionNamespace setVariable [_identifier, _existingArray];