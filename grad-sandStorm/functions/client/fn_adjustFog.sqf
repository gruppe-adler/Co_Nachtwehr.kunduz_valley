params ["_duration", "_switchOff"];

private _fog = missionNamespace getVariable ["GRAD_sandstorm_fogValue", [0,0,0]];

// systemChat ("fog1 " + str _fog);

if (!_switchOff) then {
    _fog = [0.01,0.003,00];
};

// systemChat ("fog2 " + str _fog);

_duration setFog _fog;