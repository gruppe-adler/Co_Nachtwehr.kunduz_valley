/*
    Interior dust volume - "I am inside the storm" rendering.

    Instead of the ring wall (which is far away and view-culled when you stand inside
    the storm), this is a single persistent particle source ATTACHED to the player that
    continuously fills the space around the camera with dust. It cannot be culled and is
    rendered by night-vision exactly like normal view, so the obscuration is consistent
    with or without NVG (setFog / ColorCorrections are both ignored by NVG).

    Returns the emitter so the caller can delete it on exit.

    _emitter = call GRAD_sandstorm_fnc_createParticleClose;
*/

private _src = "#particlesource" createVehicleLocal (getPosATL player);
_src attachTo [player, [0, 0, 2]];

wind params ["_wx", "_wy"];

// emit in a volume all around AND above the player so dust surrounds the whole view
_src setParticleCircle [8, [0, 0, 0]];
_src setParticleRandom [
    1.5,            // life
    [16, 16, 16],   // position spread (wide & tall volume - fully covers overhead)
    [0.3, 0.3, 0.3],// velocity spread - tiny, so particles stay put
    0,              // rotation
    0.4,            // size
    [0, 0, 0, 0.15],// colour
    0, 0
];

_src setParticleParams [
    ["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1,
    2,                          // lifeTime
    [0, 0, 3],                  // position (lifted so the volume is centred above eye level)
    [_wx / 2, _wy / 2, 0.1],  // move velocity - slight wind drift so it feels alive
    0,                          // rotationVel
    0.05,                       // weight (near-zero so particles barely fall / float in place)
    0,                          // volume (0 = engine wind does not carry it; drift is the manual term above)
    0,                          // rubbing
    [6, 9, 12, 9],              // size over life (large enough to read across the whole volume incl. overhead)
    [
        [0,0,0,0],
        [0.05,0.04,0.03,0.55],
        [0.06,0.05,0.04,0.6],
        [0,0,0,0]
    ],
    [1], 0, 0, "", "", _src
];

_src setDropInterval 0.003;     // very dense (larger volume needs more to stay thick)

_src
