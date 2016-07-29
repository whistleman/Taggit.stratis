PRIVATE ["_tagged","_tagger","_damage","_points"];

[format [" Switcharray: %1", _this]] call WIS_fnc_debug;

_tagged  = _this select 0;
_tagger  = _this select 3;

_tagged setdamage 0;

_points = if (_tagger == "init") then {50} else {-50};

// Check if WIS_SwitchINIT variable exists, if it does not make it false.
if (isNil "WIS_SwitchINIT") then {WIS_SwitchINIT = false; publicVariable "WIS_SwitchINIT";};


if (_tagger != "init") then {
	IF (_tagged == _tagger || !(_tagger iskindof "Man") || WIS_SwitchINIT) exitwith {};
};

WIS_SwitchINIT = true;
publicVariable "WIS_SwitchINIT";

WIS_SetState = [_tagged, _tagger, _points];
publicVariableServer "WIS_SetState";
