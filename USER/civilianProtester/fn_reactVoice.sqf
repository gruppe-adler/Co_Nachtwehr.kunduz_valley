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
 *      1: STRING - the reaction outcome: "flee" | "cower" | "hostile"
 */

params ["_unit", "_outcome"];

if (isNull _unit || {!alive _unit}) exitWith {};

// Map each reaction type to a pool of CfgSounds entries. Fill these with the
// real sound class names once the voicelines are recorded/defined.
private _sounds = switch (_outcome) do {
    case "flee":    { [/* "protester_flee_1", "protester_flee_2" */] };
    case "cower":   { [/* "protester_cower_1", "protester_cower_2" */] };
    case "hostile": { [/* "protester_hostile_1", "protester_hostile_2" */] };
    default { [] };
};

if (_sounds isEqualTo []) exitWith {
    // No voicelines wired up yet — leave a trace so it's easy to spot.
    diag_log format ["[civilianProtester] reactVoice stub: no sound for outcome '%1'", _outcome];
};

// say3D is global; range/volume can be tuned as needed.
_unit say3D (selectRandom _sounds);
