/*
    Outer distance-blocking ring - "the horizon is gone" rendering.

    A persistent particle source ATTACHED to the player that emits a dense ring of
    large, slow, WIND-INDEPENDENT dust at a fixed radius all around the camera. Its job
    is to guarantee that distant view is fully blocked no matter the wind: the interior
    volume drifts away too fast to occlude reliably, so this stationary wall backs it up.

    Because it is attached to the player and has near-zero move velocity, the ring stays
    at the same radius regardless of wind direction/strength. Not culled, NVG-proof.

    Returns the emitter so the caller can delete it on exit.

    _emitter = call GRAD_sandstorm_fnc_createParticleRing;
*/

private _src = "#particlesource" createVehicleLocal (getPosATL player);
_src attachTo [player, [0, 0, 2]];

private _radius = 45;   // distance of the wall from the player

// spawn particles in a ring of this radius around the source
_src setParticleCircle [_radius, [0, 0, 0]];
_src setParticleRandom [
    2,                  // life
    [6, 6, 4],          // position spread (thickness of the wall)
    [0, 0, 0],          // velocity spread - NONE, so wind cannot scatter it
    0,                  // rotation
    2,                  // size variance
    [0, 0, 0, 0.1],     // colour
    0, 0
];

_src setParticleParams [
    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1,
    4,                          // lifeTime (long, so the wall is continuous)
    [0, 0, 8],                  // position offset (centre the tall wall around eye level)
    [0, 0, 0],                  // move velocity - fully stationary
    0,                          // rotationVel
    0.05,                       // weight (near-zero so the wall does NOT fall out of view)
    0,                          // volume (0 = wind cannot carry it)
    0,                          // rubbing - 0 so wind does not push it
    [30, 45, 55, 60],           // size over life - large, tall billboards
    [
        [0,0,0,0],
        [0.05,0.04,0.03,0.7],
        [0.06,0.05,0.04,0.8],
        [0.05,0.04,0.03,0.7],
        [0,0,0,0]
    ],
    [1], 0, 0, "", "", _src
];

_src setDropInterval 0.004;     // very dense - fully occlude the horizon

_src
