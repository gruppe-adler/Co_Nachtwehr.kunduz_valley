params ["_type", "_sandstormIdentifier"];

private _identifier = format ["GRAD_sandstormEmitterArray_%1_%2", _type, _sandstormIdentifier];

missionNamespace getVariable [_identifier, []]