/*
 *  GRAD_civilianProtester_fnc_reactVoice
 *
 *  STUB. Plays a voiceline on the protester depending on the reaction type.
 *  Wire up actual sounds (say3D / CfgSounds class names) per outcome here.
 *
 *  Called from fn_react.sqf when an outcome is picked. Runs on the server;
 *  use say3D (auto-networked) so the sound is heard on all clients.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 *      1: STRING - the reaction outcome: "flee" | "hostile"
 */

params ["_unit", "_outcome"];

if (isNull _unit || {!alive _unit}) exitWith {};

// Map each reaction type to a pool of CfgSounds entries. Fill these with the
// real sound class names once the voicelines are recorded/defined.
private _sounds = switch (_outcome) do {
    case "flee":    { ["Rus1","Rus2","Rus3"] };
    case "hostile": { ["Rus11","Rus12","Rus13"] };
    default { [] };
};

if (_sounds isEqualTo []) exitWith {
    // No voicelines wired up yet — leave a trace so it's easy to spot.
    diag_log format ["[civilianProtester] reactVoice stub: no sound for outcome '%1'", _outcome];
};

// say3D has local effect only, so push it to every client. range/volume can be
// tuned as needed. "false" JIP arg: a late joiner won't replay a stale line.
[cursorObject, [selectRandom _sounds, 150, 1, 1]] remoteExec ["say3D", 0, false];
