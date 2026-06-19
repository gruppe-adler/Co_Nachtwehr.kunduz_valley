/*
 *  GRAD_civilianProtester_fnc_addAction
 *
 *  Adds the "Talk to protester" interaction. Runs on every machine
 *  (remoteExec'd to JIP=0) so all clients see the action. The action
 *  itself only fires the outcome on the server.
 *
 *  Parameters:
 *      0: OBJECT - the protester
 */

params ["_unit"];

if (isNull _unit) exitWith {};
if (!hasInterface) exitWith {};   // no point on a dedicated server / HC

// Guard against double-add.
if (_unit getVariable ["GRAD_protester_actionAdded", false]) exitWith {};
_unit setVariable ["GRAD_protester_actionAdded", true];

_unit addAction [
    "<t color='#FFD000'>Talk to protester</t>",
    {
        params ["_target", "_caller", "_actionId"];
        // Resolve outcome on the server only.
        [_target, _caller] remoteExec ["GRAD_civilianProtester_fnc_react", 2];
    },
    nil,
    1.5,
    true,
    true,
    "",
    // condition: alive, still protesting, caller close, on foot
    "alive _target
        && {(_target getVariable ['GRAD_protester_state','']) == 'protesting'}
        && {_this distance _target < 4}
        && {isNull objectParent _this}",
    3
];
