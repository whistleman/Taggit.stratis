PRIVATE ["_PubVarName","_PubVarCode","_format"];

_PubVarName = _this select 0;
_PubVarCode = _this select 1;

_format 	= "*-* DEBUG TAGGIT *-* " + _PubVarCode;

diag_log _format;
