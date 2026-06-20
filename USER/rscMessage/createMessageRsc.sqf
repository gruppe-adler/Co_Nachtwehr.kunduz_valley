/* ["bla bli blub", "none", 6, "isabella"] execvm "user\rscMessage\createMessageRsc.sqf";*/

// pixel grids macros
#define UI_GRID_W (pixelW * pixelGrid)	// one grid width
#define UI_GRID_H (pixelH * pixelGrid)	// one grid height
#define UI_GUTTER_W (pixelW * 2)		// gutter width  of 2 pixels
#define UI_GUTTER_H (pixelH * 2)		// gutter height of 2 pixels

// sizes for our control
#define BOX_W (UI_GRID_W * 12) // control is 12 grids wide
#define BOX_H (UI_GRID_H * 12)  // control is 5 grids high

params [["_unit", objNull], ["_message", ""], ["_sound", "none"], ["_duration", 6], ["_avatarPic", ""]];

_duration = _duration + 2; // just a little more than sound for animation etc


// private _playerKraken = player getVariable ["GRAD_isKraken", false];

// show message to all of the right side PLUS all zeuses
/*
if (_isKraken != _playerKraken && isNull (getAssignedCuratorLogic player)) exitWith {
	diag_log "message received but not for my team. ignoring message.";
};
*/


"GRAD_COMMAND_MESSAGE" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlGroup ctrlSetPosition [safeZoneX, safeZoneY+BOX_H, safeZoneW, safeZoneH];

_ctrlGroup ctrlCommit 0;
_ctrlGroup ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_ctrlGroup ctrlCommit 0.1;

private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
_ctrlBackground ctrlSetPosition [0, safeZoneH - BOX_H, safeZoneW, BOX_H];
_ctrlBackground ctrlSetBackgroundColor [0, 0, 0, 0.5];
_ctrlBackground ctrlSetText "";
_ctrlBackground ctrlEnable false;
_ctrlBackground ctrlCommit 0;

private _estimatedTextWidth = _message getTextWidth ["PuristaMedium", 2];
// systemChat ("text width: " + str _estimatedTextWidth);
private _ctrlMessage = _display ctrlCreate ["RscStructuredText", -1, _ctrlGroup];
_ctrlMessage ctrlSetPosition [safeZoneW, safeZoneH - BOX_H/1.7, safeZoneW, BOX_H];
_ctrlMessage ctrlSetStructuredText parseText ("<t size='2'>" + _message + "</t>");
_ctrlMessage ctrlCommit 0;

/*
private _ctrlAdditionalText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGroup];
_ctrlAdditionalText ctrlSetPosition [0, safeZoneH - BOX_H/1.02, safeZoneW*2, BOX_H];
_ctrlAdditionalText ctrlSetStructuredText parseText ("<t size='1' font='EtelkaNarrowMediumPro' color='#666666'>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -TRANSMISSION INCOMING - TRANSMISSION INCOMING - TRANSMISSION INCOMING - TRANSMISSION INCOMING - TRANSMISSION INCOMING - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -</t>");
_ctrlAdditionalText ctrlCommit 0; 
*/

private _textWidth = ctrlTextWidth _ctrlMessage;
_ctrlMessage ctrlSetPosition [safeZoneW, safeZoneH - BOX_H/1.7, _textWidth, BOX_H];
_ctrlMessage ctrlCommit 0;

// --- Marquee scroll timing -------------------------------------------------
// Scroll speed is capped so short messages don't whip past too fast to read,
// while long messages scroll over the full display duration.
//
// Commit time is derived from how far the text actually travels:
//   travel / MAX_SCROLL_SPEED
// then clamped into [MIN_SCROLL_TIME, _duration]:
//   - long text  -> travel/speed exceeds _duration -> clamped to _duration
//   - short text -> travel/speed is small          -> floored to MIN_SCROLL_TIME
//
// MAX_SCROLL_SPEED is in screen-widths per second (safeZoneW units), so it's
// resolution independent. Tune these two to taste.
#define MAX_SCROLL_SPEED (safeZoneW / 6)   // ~6s to cross one full screen width
#define MIN_SCROLL_TIME  4                 // shortest a message ever scrolls for

private _startX = safeZoneW;
private _endX = 0;
if (safeZoneW < _textWidth) then {
	_endX = safeZoneW - _textWidth;   // long: scroll the whole string across
} else {
	_endX = BOX_W * 1.1;              // short: slide in and park near the left
};

private _travel = abs (_startX - _endX);
private _scrollTime = (_travel / MAX_SCROLL_SPEED) max MIN_SCROLL_TIME min _duration;

_ctrlMessage ctrlSetPosition [_endX, safeZoneH - BOX_H/1.5, _textWidth, BOX_H];
_ctrlMessage ctrlCommit _scrollTime;

private _ctrlImage = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
_ctrlImage ctrlSetPosition [0, safeZoneH - BOX_H, BOX_W, BOX_H];

_ctrlImage ctrlSetText _avatarPic;	

_ctrlImage ctrlCommit 0;

if (typeName _unit == "STRING") then {
	player createDiaryRecord ["Diary", [_unit + " - " + ([dayTime, "HH:MM"] call BIS_fnc_timeToString), _message], taskNull, "NONE", true];
} else {
	player createDiaryRecord ["Diary", [name _unit + " - " + ([dayTime, "HH:MM"] call BIS_fnc_timeToString), _message], taskNull, "NONE", true];
};

// playSoundUI ["remote_start"];

private _soundID = objNull;

if (_sound == "none") then {
	[] spawn {
		sleep 1.5;
		if (isGameFocused) then {
			_soundID = playSoundUI ["garble_long"];
		};
	};
} else {
	if (typeName _unit != "STRING" && {!isNull _unit} && {player distance _unit < 10} && {vehicle player == player}) then {
		if (isGameFocused) then {
			_soundID = _unit say3d [_sound, 150];
			_unit setRandomLip true;
		};
	} else {
		if (isGameFocused) then {
			_soundID = playSoundUI [_sound];
		};
	};
};

// private _duration = _textWidth * 100;
// _ctrlMessage ctrlCommit _duration;


[_ctrlGroup, _display, _duration, _unit] spawn {
	params ["_ctrlGroup", "_display", "_duration", "_unit"];

	sleep _duration;
	_ctrlGroup ctrlSetPosition [safeZoneX, safeZoneY+BOX_H, safeZoneW, safeZoneH];
	_ctrlGroup ctrlCommit 0.1;
	uiSleep 0.1;
	_display closeDisplay 1;

	// playSound "remote_end";

	if (typeName _unit != "STRING" && {!isNull _unit}) then {
		_unit setRandomLip false;
	};
};
