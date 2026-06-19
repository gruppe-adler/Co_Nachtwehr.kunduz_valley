params ["_trigger", "_triggerSound", "_helperObject", "_sandstormIdentifier"];

private _updateRate = 1;

// wall brightness seen from outside (lit by moonlight) vs from inside (in shadow/dust)
GRAD_sandstorm_wallBrightnessOutside = 2.2;
GRAD_sandstorm_wallBrightnessInside = 0.5;

// How far INSIDE the storm edge the effects (post-processing, fog, leaves) switch on.
// The storm trigger is the full radius, but the visible particle wall starts ~155m
// inside it, so without this inset the PP kicks in before you reach the dust.
// Larger value = effects start later (deeper into the storm).
GRAD_sandstorm_effectInset = 155;

if (GRAD_SANDSTORM_DEBUG) then {
    diag_log "add local sandwall";
};


[] call GRAD_sandstorm_fnc_addLODTrigger;

/*
    debug
*/

private _markerstr = createMarkerLocal [format ["mrk_lod_%1", _sandstormIdentifier],[0,0]];
_markerstr setMarkerShapeLocal "ELLIPSE"; 
_markerstr setMarkerColorLocal "ColorBlue"; 
_markerstr setMarkerBrushLocal "Border"; 
_markerstr setMarkerSizeLocal [4000,4000]; 
_markerstr setMarkerPosLocal (getpos (vehicle player));


if (!GRAD_SANDSTORM_DEBUG) then {
    _markerstr setMarkerAlphaLocal 0;
};

private _stormRadius = (triggerArea _trigger) select 0;
missionNamespace setVariable [format ["GRAD_sandstorm_radius_%1", _sandstormIdentifier], _stormRadius];

[_trigger, _stormRadius - 50, 50, _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_createParticleBorder;

// player starts outside the wall, so light it for moonlight viewing
[_sandstormIdentifier, GRAD_sandstorm_wallBrightnessOutside] call GRAD_sandstorm_fnc_setEmitterBrightness;


[{
    params ["_args", "_handle"];
    _args params ["_trigger", "_triggerSound", "_markerstr", "_helperObject", "_sandstormIdentifier", "_updateRate"];

    if (isNull _trigger) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        if (GRAD_SANDSTORM_DEBUG) then {
            systemChat "removing local sandwall";
            diag_log "removing local sandwall";
        };
        
        // delete emitter
        ["borderBottom", _sandstormIdentifier] call GRAD_sandstorm_fnc_clearEmitterArray;
        ["fillerSmall", _sandstormIdentifier] call GRAD_sandstorm_fnc_clearEmitterArray;
        ["filler", _sandstormIdentifier] call GRAD_sandstorm_fnc_clearEmitterArray;

        // if the storm died while the player was still inside it, restore their state
        if (player getVariable ["isInsideSandstorm", false]) then {
            player setVariable ["isInsideSandstorm", false];
            private _pp = player getVariable ["isInsideSandstormPP", []];
            private _leaves = player getVariable ["isInsideSandstormLeaves", []];
            [_pp] call GRAD_sandstorm_fnc_removePostProcessing;

            player setVariable ["tf_receivingDistanceMultiplicator", 1];
            player setVariable ["tf_sendingDistanceMultiplicator", 1];

            { deleteVehicle _x } forEach _leaves;
        };

        // remove the interior dust volume and outer ring if they exist
        private _interior = player getVariable ["GRAD_sandstorm_interiorEmitter", objNull];
        if (!isNull _interior) then {
            deleteVehicle _interior;
            player setVariable ["GRAD_sandstorm_interiorEmitter", objNull];
        };
        private _ring = player getVariable ["GRAD_sandstorm_ringEmitter", objNull];
        if (!isNull _ring) then {
            deleteVehicle _ring;
            player setVariable ["GRAD_sandstorm_ringEmitter", objNull];
        };
        private _overhead = player getVariable ["GRAD_sandstorm_overheadEmitter", objNull];
        if (!isNull _overhead) then {
            deleteVehicle _overhead;
            player setVariable ["GRAD_sandstorm_overheadEmitter", objNull];
        };

        // restore world fog and music
        0 setFog 0;
        setAperture -1;
        private _soundeffect = player getVariable ["sandStormSoundEH", -1];
        if (_soundeffect > -1) then {
            removeMusicEventHandler ["MusicStop", _soundeffect];
            player setVariable ["sandStormSoundEH", -1];
            playMusic "";
            0 fadeMusic 1;
        };
    };

    if (GRAD_SANDSTORM_DEBUG) then {
         // debug marker pos
         _markerstr setMarkerPos (getPos vehicle player);
    };

    //
    ["borderBottom", _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_setEmitterLOD;
    ["fillerSmall", _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_setEmitterLOD;
    ["filler", _helperObject, _sandstormIdentifier] call GRAD_sandstorm_fnc_setEmitterLOD;

    if ((vehicle player) inArea _triggerSound) then {
        if ((player getVariable ["sandStormSoundEH", -1]) == -1) then {
                0 fadeMusic 0;
                playMusic "desertLoop";
                10 fadeMusic 0.5;
                private _soundeffect = addMusicEventHandler ["MusicStop", {
                        playMusic "desertLoop";
                        if (GRAD_SANDSTORM_DEBUG) then {
                            systemChat "restarting sound effect";
                        };
                }];
                player setVariable ["sandStormSoundEH", _soundeffect];
            };
    } else {
        private _soundeffect = player getVariable ["sandStormSoundEH", -1];

        if (_soundeffect > -1) then {
            // stop music
            10 fadeMusic 0;
            [{
                params ["_soundeffect"];

                if (!(player getVariable ["isInsideSandstorm", false])) then {
                    playMusic "";

                    removeMusicEventHandler ["MusicStop", _soundeffect];
                    player setVariable ["sandStormSoundEH", -1];
                    0 fadeMusic 1;
                };
            }, [_soundeffect], 10] call CBA_fnc_waitAndExecute;
        };
    };

    // Effects activate when the player is within the storm radius minus an inset,
    // i.e. roughly when they reach the visible particle wall (not the trigger edge).
    private _stormRadius = missionNamespace getVariable [format ["GRAD_sandstorm_radius_%1", _sandstormIdentifier], (triggerArea _trigger) select 0];
    private _effectRadius = _stormRadius - GRAD_sandstorm_effectInset;
    private _insideEffects = ((vehicle player) distance2D _helperObject) < _effectRadius;

    if (_insideEffects) then {

        // playSound ["A3\sounds_f\ambient\winds\wind-synth-fast.wss", player];

        if (!(player getVariable ["isInsideSandstorm", false])) then {
            private _pp = call GRAD_sandstorm_fnc_addPostProcessing;
            private _leaves = call GRAD_sandstorm_fnc_addLeaves;

            player setVariable ["isInsideSandstorm", true];
            player setVariable ["isInsideSandstormPP", _pp];
            player setVariable ["isInsideSandstormLeaves", _leaves];

            player setVariable ["tf_receivingDistanceMultiplicator", 4];
            player setVariable ["tf_sendingDistanceMultiplicator", 0.25];

            // now inside: darken the wall (player is in shadow within the dust)
            [_sandstormIdentifier, GRAD_sandstorm_wallBrightnessInside] call GRAD_sandstorm_fnc_setEmitterBrightness;

            // create the interior dust volume - a persistent player-attached emitter
            // that surrounds the camera. This is the obscuration when standing inside
            // the storm (replaces setFog, which NVG ignores).
            private _interior = call GRAD_sandstorm_fnc_createParticleClose;
            player setVariable ["GRAD_sandstorm_interiorEmitter", _interior];

            // create the wind-independent outer ring that blocks distant view
            private _ring = call GRAD_sandstorm_fnc_createParticleRing;
            player setVariable ["GRAD_sandstorm_ringEmitter", _ring];

            // create the overhead cap so the sky directly above is blocked too
            private _overhead = call GRAD_sandstorm_fnc_createParticleOverhead;
            player setVariable ["GRAD_sandstorm_overheadEmitter", _overhead];
        };

        // applies grain / camshake / aperture (building/vehicle aware)
        private _inBuilding = [_updateRate] call GRAD_sandstorm_fnc_adjustEffects;

        // pause the dust while sheltered in a building, resume outside
        private _interior = player getVariable ["GRAD_sandstorm_interiorEmitter", objNull];
        if (!isNull _interior) then {
            _interior enableSimulation (!_inBuilding);
        };
        private _ring = player getVariable ["GRAD_sandstorm_ringEmitter", objNull];
        if (!isNull _ring) then {
            _ring enableSimulation (!_inBuilding);
        };
        private _overhead = player getVariable ["GRAD_sandstorm_overheadEmitter", objNull];
        if (!isNull _overhead) then {
            _overhead enableSimulation (!_inBuilding);
        };

    } else {
        setAperture -1;

        if (player getVariable ["isInsideSandstorm", false]) then {
            player setVariable ["isInsideSandstorm", false];
            private _pp = player getVariable ["isInsideSandstormPP", []];
            private _leaves = player getVariable ["isInsideSandstormLeaves", []];
            [_pp] call GRAD_sandstorm_fnc_removePostProcessing;

            player setVariable ["tf_receivingDistanceMultiplicator", 1];
            player setVariable ["tf_sendingDistanceMultiplicator", 1];

            {
                deleteVehicle _x;
            } forEach _leaves;

            // remove the interior dust volume and the outer ring
            private _interior = player getVariable ["GRAD_sandstorm_interiorEmitter", objNull];
            if (!isNull _interior) then {
                deleteVehicle _interior;
                player setVariable ["GRAD_sandstorm_interiorEmitter", objNull];
            };
            private _ring = player getVariable ["GRAD_sandstorm_ringEmitter", objNull];
            if (!isNull _ring) then {
                deleteVehicle _ring;
                player setVariable ["GRAD_sandstorm_ringEmitter", objNull];
            };
            private _overhead = player getVariable ["GRAD_sandstorm_overheadEmitter", objNull];
            if (!isNull _overhead) then {
                deleteVehicle _overhead;
                player setVariable ["GRAD_sandstorm_overheadEmitter", objNull];
            };

            // back outside: brighten the wall again for moonlight viewing
            [_sandstormIdentifier, GRAD_sandstorm_wallBrightnessOutside] call GRAD_sandstorm_fnc_setEmitterBrightness;
        };
    };
    
}, _updateRate, [_trigger, _triggerSound, _markerstr, _helperObject, _sandstormIdentifier, _updateRate]] call CBA_fnc_addPerFrameHandler;
