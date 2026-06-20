// Local-only: setMarkerAlphaLocal affects this machine's map display.
// Nothing to draw on a machine with no interface (dedicated/headless).
if (!hasInterface) exitWith {};

for "_i" from 1 to 24 step 1 do {

    private _marker = format ["convoyroute_%1", _i];
    if (markerType _marker == "") then { continue };   // marker doesn't exist; skip

    _marker setMarkerAlphaLocal 0;   // hide
};

for "_i" from 1 to 14 step 1 do {

    private _marker = format ["convoyroute_2_%1", _i];
    if (markerType _marker == "") then { continue };   // marker doesn't exist; skip

    _marker setMarkerAlphaLocal 1;   // reveal
};