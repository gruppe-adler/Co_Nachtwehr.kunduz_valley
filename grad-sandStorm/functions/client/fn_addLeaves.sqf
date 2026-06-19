wind params ["_WindVectorX", "_WindVectorY"];

// leaves/sticks spawn CLOSE to the player and drift, instead of spawning 100m out and
// streaking away at wind*10 (which made them effectively invisible). Lifetime is short
// so they tumble past as near debris rather than ending up far away.

_sticks  = "#particlesource" createVehicleLocal (getpos vehicle player);
_sticks attachto [vehicle player];
_sticks setParticleRandom [0, [10, 10, 7], [2, 2, 2], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
_sticks setParticleCircle [15, [0, 0, 0]];
_sticks setParticleParams [
["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks", 1, 1, 1], "", "SpaceObject", 1, 8, [0,0,0],
[_WindVectorX*1.5, _WindVectorY*1.5, 1], 2, 0.000001, 0.0, 0.1, [0.5 + random 0.5], [[0.68,0.68,0.68,1]], [1.5,1], 13, 13, "", "", vehicle player, 0, true ,1, [[0,0,0,0]]];
_sticks setDropInterval 0.15;

_leaves  = "#particlesource" createVehicleLocal (getpos vehicle player);
_leaves attachto [vehicle player];
_leaves setParticleRandom [0, [10, 10, 7], [2, 2, 2], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
_leaves setParticleCircle [15, [0, 0, 0]];
_leaves setParticleParams [
["\A3\data_f\ParticleEffects\Hit_Leaves\Leaves", 1, 1, 1], "", "SpaceObject", 1, 8, [0,0,0],
[_WindVectorX*1.5, _WindVectorY*1.5, 1], 2, 0.000001, 0.0, 0.1, [0.5 + random 0.5], [[0.68,0.68,0.68,1]], [1.5,1], 13, 13, "", "", vehicle player, 0, true ,1, [[0,0,0,0]]];
_leaves setDropInterval 0.15;

[_sticks, _leaves]