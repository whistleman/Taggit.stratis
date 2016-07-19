PRIVATE ["_tagger", "_points", "_score", "_maxScore"];

_tagger = _this select 0;
_points = _this select 1;

if (WIS_Taggit_Debug == 1) then {
	diag_log format ["*-* DEBUG TAGGIT *-* Add %1 new points to %2", _points, name _tagger];
	diag_log format ["*-* DEBUG TAGGIT *-* Score of %1 before addScore: %2", name _tagger, score _tagger];
};

_tagger addScore _points;

_score = score _tagger;

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Score of %1 after addScore: %2", name _tagger, _score];};

_maxScore = "WIS_MaxScore" call BIS_fnc_getParamValue;
if !(isServer) then {
	if (_score > _maxScore) exitwith {
		"PlayerScore" call BIS_fnc_endMissionServer;
	};
};