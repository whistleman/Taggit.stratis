PRIVATE ["_tagged","_tagger","_damage","_points"];

[format [" Switcharray: %1", _this]] call WIS_fnc_debug;

_tagged  = _this select 0;

//first time _tagger == "init"!!!
_tagger  = _this select 3;

_tagged setdamage 0;

// Check if WIS_SwitchINIT variable exists, if it does not make it false.
if (isNil "WIS_SwitchINIT") then {WIS_SwitchINIT = false; publicVariable "WIS_SwitchINIT";};

if (WIS_SwitchINIT) exitwith {};

// Give points
_points = if (typename _tagger == "OBJECT") then {-50} else {50};

_wasUnTagged = _tagged getVariable "Untagged"; // Should be True
_wasTagged = _tagged getVariable "Tagged"; // Should be False
_isUnTagged = _tagger getVariable "Untagged"; // Should be False
_isTagged = _tagger getVariable "Tagged"; // Should be True

// Verify 
if (typename _tagger == "OBJECT") then {
	IF (_tagged == _tagger || !(_tagger iskindof "Man") || !(_wasUnTagged) || (_wasTagged) || (_isUnTagged) || !(_isTagged)) exitwith {
		[format [" %1 got Tagged, but variables are wrong: Untagged: %2 (should be true), Tagged: %3 (should be false)", name _tagged,_wasUnTagged, _wasTagged]] call WIS_fnc_debug;
		[format [" %1 got Tagged, but variables are wrong: Untagged: %2 (should be false), Tagged: %3 (should be true)", name _tagger,_isUnTagged, _isTagged]] call WIS_fnc_debug;
	};
};

WIS_SwitchINIT = true;
publicVariable "WIS_SwitchINIT";

WIS_SetState = [_tagged, _tagger, _points];
publicVariableServer "WIS_SetState";
