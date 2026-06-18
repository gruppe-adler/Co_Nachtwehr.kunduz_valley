/*
    used to spawn random particles inside sandstorm, not hitting player in best case
*/

private _existingEmitters = missionNameSpace getVariable ["GRAD_sandstorm_closeEmitters", []];

{
  deleteVehicle _x;
} forEach _existingEmitters;

// leave a gap, so player is not likely to be hit by a particle
private _offsets = [
    random -180,
    random -120,
    random -40,
    random -20,
    random 20,
    random 40,
    random 120,
    random 180
];

private _emitters = [];
private _distance = ((speed (vehicle player)) + 5) * (5 + random 5);


wind params ["_WindVectorX", "_WindVectorY"];

for "_i" from 0 to (count _offsets - 1) do 
{ 
    private _offset = _offsets select _i;
    private _size = 7 + random 8;

    private _position = (position player) getPos [_distance, windDir - 180 + _offset];

    drop [
        ["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 0], "", "Billboard", 1, 10,  _position,  
        [_WindVectorX/2,_WindVectorY/2,5],  0, 0,10,0.0001,[_size,_size,_size,_size,_size],  
        [ [0,0,0,0], [.38, .33, .2, 0.5], [.38, .33, .2, 0.5], [.38, .33, .2, 0.5],[0,0,0,0]  ],   
        [0.01], 0.1,  0.1, "", "", _emitter 
    ];
    /*
    private _emitter = "#particlesource" createVehicleLocal _position;
    _emitter setParticleParams 
    _emitter setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
    _emitter setDropInterval (random 2);
    _emitters pushBack _emitter;
    */
};

missionNameSpace setVariable ["GRAD_sandstorm_closeEmitters", _emitters];
