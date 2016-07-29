PRIVATE ["_unit", "_points", "_score", "_maxScore"];

_unit = _this select 0;
_points = _this select 1;


[format ["Add %1 new points to %2", _points, name _unit]] call WIS_fnc_Debug;
[format ["*Score of %1 before addScore: %2", name _unit, score _unit]] call WIS_fnc_Debug;


_unit addScore _points;

_score = score _unit;

[format ["Score of %1 after addScore: %2", name _unit, _score]] call WIS_fnc_Debug;

_maxScore = "WIS_MaxScore" call BIS_fnc_getParamValue;
if !(isServer) then {
	if (_score > _maxScore) exitwith {
		"PlayerScore" call BIS_fnc_endMissionServer;
	};
};