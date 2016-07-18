PRIVATE ["_tagger", "_points", "_score", "_maxScore"];

_tagger = _this select 0;
_points = _this select 1;

_tagger addScore _points;

_score = score _tagger;

_maxScore = "WIS_MaxScore" call BIS_fnc_getParamValue;

if (_score > _maxScore) exitwith {
	"PlayerScore" call BIS_fnc_endMissionServer;
};