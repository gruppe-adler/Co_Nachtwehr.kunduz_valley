/*

	creates emitter LOD (droprate) calculation trigger helper

*/


if (player getVariable ["ODE_LODTriggerCreated", false]) exitWith {};

player setVariable ["ODE_LODTriggerCreated", true];


// distance, [defaultDropInterval, fillerDropInterval] - higher = fewer particles.
// Far rings are throttled hard: distant wall is small on screen, so a low spawn
// rate there is barely visible but saves a large slice of the particle budget.
private _LODLevel =
[
	[500,[0.2, 0.2]],
	[1000,[0.4, 0.4]],
	[2000,[1.0, 0.7]],
	[3500,[1.8, 1.0]],
	[7000,[4, 4]]
];

// [500,[0.2, 0.2]],

{
	private _size = _x select 0;

	private _trigger = createTrigger ["EmptyDetector", position player];
	_trigger setTriggerArea [_size, _size, 0, false];

	_trigger attachTo [player];

	private _identifier = format ["ODE_LODTrigger_%1", _forEachIndex];
	player setVariable [_identifier, _trigger];

} forEach _LODLevel;

player setVariable ["ODE_LODTriggerDefinitions", _LODLevel];