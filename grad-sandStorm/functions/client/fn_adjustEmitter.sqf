params ["_emitter", "_helperObject", "_dropRate"];

_emitter setDropInterval _dropRate;
_emitter enableSimulation true;

/*
private _offset = _emitter worldToModel getpos _helperObject;

private _ASLEmitter = getTerrainHeightASL position _emitter;
_ASLEmitter params ["_xPosEmitter", "_yPosEmitter", "_zPosEmitter"];

private _zPosOrigin = getPosASL _helperObject select 2;

private _resultingOffset = _zPosOrigin - _zPosEmitter;
systemChat str _offset;

_offset params ["_xPos", "_yPos"];

_emitter attachTo [_helperObject, [_xPos, _yPos, _resultingOffset]];
*/