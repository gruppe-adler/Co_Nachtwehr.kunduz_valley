private _inBuilding = false;

private _building = nearestObject [player, "HouseBase"];

if ((count (_building buildingPos -1) >0) && ((typeof _building) find "ruins" == -1)) then {
    _building = nearestObject [player, "HouseBase"];
} else {
    _building = objNull;
};
private _relPos = _building worldToModel (getPosATL player);
private _boundBox = boundingBoxReal _building;

_boundBox params ["_min", "_max"];
_relPos params ["_playerX", "_playerY", "_playerZ"];
_min params ["_minX", "_minY", "_minZ"];
_max params ["_maxX", "_maxY", "_maxZ"];

// Inside building
if (_playerX > _minX && _playerX < _maxX && _playerY > _minY && _playerY < _maxY && _playerZ > _minZ && _playerZ < _maxZ && (getposATL player select 2) >0.1) then {
    _inBuilding = true;
};

_inBuilding