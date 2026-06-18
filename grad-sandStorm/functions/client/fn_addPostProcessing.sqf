private _colorEffect = ppEffectCreate ["ColorCorrections",1500];
_colorEffect ppEffectEnable true;
_colorEffect ppEffectAdjust [0.875,0.875,-0.1,[1.652,0.764,0,0.2],[1,1,1,0.8],[0.835,0,0,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624]];
_colorEffect ppEffectCommit 1;

private _grain = ppEffectCreate ["FilmGrain", 2050];
_grain ppEffectEnable true;
_grain ppEffectAdjust [0.08, 1.25, 2.05, 0.75, 1, 0];
_grain ppEffectCommit 1;

[_colorEffect, _grain]
