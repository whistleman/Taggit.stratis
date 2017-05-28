PRIVATE ["_unit", "_call","_id","_args","_fnc","_tagged"];

_unit 	= _this select 0;
_call 	= _this select 1;
_id 		= _this select 2;
_args 	= _this select 3;
_fnc 		= _args select 0;

[format ["HandleActions started for %1 by %2", _fnc,_call]] call WIS_fnc_Debug;

// Get the unit that is tagged
_tagged = {
	_var = _x getVariable "Tagged";
	if (_var) exitwith {_x};
} foreach AllUnits;

if (WIS_Taggit_Debug == 0 && _call == _tagged) exitwith {};

[format ["HandleActions Tagged: %1", name _tagged]] call Wis_fnc_debug;

[_tagged] remoteExec [_fnc, _tagged];
