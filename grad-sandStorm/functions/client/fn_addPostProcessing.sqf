// ColorCorrections: [brightness, contrast, saturation, colorize[RGBA], colorMul[RGBA], colorAdd[RGBA], blend]
//  - brightness raised for night-time visibility
//  - colorize/colorAdd shifted from warm red toward a neutral, desaturated dusty gray
private _colorEffect = ppEffectCreate ["ColorCorrections",1500];
_colorEffect ppEffectEnable true;
_colorEffect ppEffectAdjust [1.05,0.85,-0.35,[0.85,0.82,0.78,0.2],[1,1,1,0.8],[0.05,0.04,0.03,0],[0,0,-0.265,-0.194,-0.017,0.279,0.624]];
_colorEffect ppEffectCommit 1;

// FilmGrain: [intensity, sharpness, grainSize, intensityX0, intensityX1, monochrome]
private _grain = ppEffectCreate ["FilmGrain", 2050];
_grain ppEffectEnable true;
_grain ppEffectAdjust [0.16, 1.25, 2.05, 0.75, 1, 0];
_grain ppEffectCommit 1;

[_colorEffect, _grain]
