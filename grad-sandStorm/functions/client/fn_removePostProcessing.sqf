params ["_pp"];
_pp params ["_colorEffect", "_grain"];

// todo check if this is OK
_colorEffect ppEffectAdjust [1, 1, 0,[ 0, 0, 0, 0],[ 1, 1, 1, 1],[ 0, 0, 0, 0]];
_colorEffect ppEffectCommit 1;
ppEffectDestroy _colorEffect;

_grain ppEffectAdjust [
    0.005,
    1.25,
    2.01,
     0.75,
    1.0,
    0 // 0 for Arma 3
];
_grain ppEffectCommit 1;
ppEffectDestroy _grain;
