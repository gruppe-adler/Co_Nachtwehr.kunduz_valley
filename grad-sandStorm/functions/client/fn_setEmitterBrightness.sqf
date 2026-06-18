/*

    re-colours all sandwall emitters of a storm.

    used to make the wall bright (lit by moonlight) when the player is OUTSIDE
    looking at it, and dark when the player is INSIDE it (in shadow / dust).

    [_sandstormIdentifier, _brightness] call GRAD_sandstorm_fnc_setEmitterBrightness;

*/

params ["_sandstormIdentifier", "_brightness"];

// only the wall-forming emitters are re-coloured (these match the types the
// local handler creates/maintains in fn_addSandWallLocal)
private _types = ["borderBottom", "fillerSmall", "filler"];

{
    private _type = _x;
    private _emitters = [_type, _sandstormIdentifier] call GRAD_sandstorm_fnc_getEmitterArray;

    {
        if (!isNull _x) then {
            private _params = [_x, _type, _brightness] call GRAD_sandstorm_fnc_getEmitterParams;
            _x setParticleParams _params;
        };
    } forEach _emitters;
} forEach _types;
