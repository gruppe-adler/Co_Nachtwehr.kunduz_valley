/*
    Overhead dust cap - blocks the sky directly above the player.

    The interior volume spreads dust evenly through a cube, so the thin slice right
    above the head is too sparse to occlude the sky. This is a dedicated dense disc of
    particles a few metres overhead so looking straight up shows dust, not stars.

    Persistent, player-attached, wind-locked, NVG-proof. Returns the emitter.

    _emitter = call GRAD_sandstorm_fnc_createParticleOverhead;
*/

private _src = "#particlesource" createVehicleLocal (getPosATL player);
_src attachTo [player, [0, 0, 9]];   // sits well above the head

// wide flat disc overhead
_src setParticleCircle [5, [0, 0, 0]];
_src setParticleRandom [
    1.5,            // life
    [12, 12, 3],    // position spread - wide & flat (a ceiling, not a column)
    [0, 0, 0],      // velocity spread - none
    0,              // rotation
    2,              // size variance
    [0, 0, 0, 0.1], // colour
    0, 0
];

_src setParticleParams [
    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1,
    2.5,                        // lifeTime
    [0, 0, 0],                  // position (relative to the already-raised source)
    [0, 0, 0],                  // move velocity - stationary
    0,                          // rotationVel
    0.05,                       // weight (near-zero so it does not fall away)
    0,                          // volume
    0,                          // rubbing
    [10, 14, 18, 14],           // size over life - large so the ceiling reads solid
    [
        [0,0,0,0],
        [0.05,0.04,0.03,0.6],
        [0.06,0.05,0.04,0.7],
        [0.05,0.04,0.03,0.6],
        [0,0,0,0]
    ],
    [1], 0, 0, "", "", _src
];

_src setDropInterval 0.004;     // dense ceiling

_src
