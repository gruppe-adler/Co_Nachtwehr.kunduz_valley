// ColorCorrections is intentionally neutral (identity): the storm obscuration is now
// fully particle based, because both setFog and any ColorCorrections tint are ignored
// by night-vision and made the storm vanish under NVG. Grain is the only real PP kept.
// The effect is still created (and destroyed in fn_removePostProcessing) so the return
// contract stays [colorEffect, grain].
private _colorEffect = ppEffectCreate ["ColorCorrections",1500];
_colorEffect ppEffectEnable true;
_colorEffect ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0,0,0,0],[0,0,0,0,0,0,0]];
_colorEffect ppEffectCommit 1;

// FilmGrain: [intensity, sharpness, grainSize, intensityX0, intensityX1, monochrome]
private _grain = ppEffectCreate ["FilmGrain", 2050];
_grain ppEffectEnable true;
_grain ppEffectAdjust [0.16, 1.25, 2.05, 0.75, 1, 0];
_grain ppEffectCommit 1;

[_colorEffect, _grain]
