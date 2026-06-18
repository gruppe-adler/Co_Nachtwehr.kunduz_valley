/*

    reveals a global sandstorm marker locally, but only for Zeus/curators.
    called via remoteExec from the server so each client decides for itself.

    [_markerName] call GRAD_sandstorm_fnc_revealZeusMarker;

*/

params ["_markerName"];

if (isNull (getAssignedCuratorLogic player)) exitWith {};

// alpha 0 = hidden again (cleanup), >0 = visible to this curator
if (getMarkerColor _markerName == "") exitWith {}; // marker already deleted

_markerName setMarkerAlphaLocal 0.5;
