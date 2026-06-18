/*

    calculates emitter positions
    sends coordinates to temp array
    intersections of player LOD triggers will be matched to drop rate

*/

params ["_trigger", "_radius", "_lengthBetween", "_helperObject", "_sandstormIdentifier"];

private _pos = getPos _trigger;
_pos params ["_px","_py"];


private _circ = floor ((2 * pi) * _radius);
private _radials = floor (_circ / _lengthBetween);
private _factor = (360 / _radials);

for "_i" from 0 to (_radials - 1) do 
{ 
    private _ix = (_i * _factor);   
    
    /*
    // border top, brighters sands
    private _ox = ((_radius - 250) * cos _ix); 
    private _oy = ((_radius - 250) * sin _ix); 
    
    private _posX = _px + _ox; 
    private _posY = _py + _oy;
    
    [[_posX, _posY, 0], "borderTop", 0.1, _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_createEmitter;
    */

    // border bottom, dark material gets thrown up
    _ox = ((_radius - 155)* cos _ix);
    _oy = ((_radius - 155) * sin _ix);
    
    private _posX = _px + _ox;
    private _posY = _py + _oy;
    [[_posX, _posY, 0], "borderBottom", 0.1, _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_createEmitter;
};

_lengthBetween = 200;
_circ = floor ((2 * pi) * _radius);
_radials = floor (_circ / _lengthBetween);
_factor = (360 / _radials);

// fillers dont need 50m 

for "_i" from 0 to (_radials - 1) do 
{ 
    private _ix = (_i * _factor);
    
    
    // big line of fillers simulating dust
    private _ox = ((_radius - 850)* cos _ix);
    private _oy = ((_radius - 850) * sin _ix);
    
    private _posX = _px + _ox; 
    private _posY = _py + _oy;
   [[_posX, _posY, 0], "filler", 1, _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_createEmitter;

    // 2nd line to fill gaps when you are close
    _ox = ((_radius - 350)* cos _ix);
    _oy = ((_radius - 350) * sin _ix);
    
    private _posX = _px + _ox;
    private _posY = _py + _oy;
    [[_posX, _posY, 0], "fillerSmall", 1, _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_createEmitter;
};