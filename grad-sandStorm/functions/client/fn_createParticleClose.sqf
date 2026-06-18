/*
    used to spawn random particles inside sandstorm, not hitting player in best case

    these are one-shot `drop` particles: they self-expire after their lifetime,
    so there is nothing to track or clean up.
*/

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
        [0.01], 0.1,  0.1, "", "", objNull
    ];
};
