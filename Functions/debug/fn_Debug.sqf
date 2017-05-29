
if (WIS_Taggit_Debug == 0) exitwith {};

_string	= _this select 0;

if (isServer) then {

  diag_log format ["*-* DEBUG TAGGIT *-* %1", _string];

} else {

  WIS_EhDebug = _string;
  publicVariableServer "WIS_EhDebug";

};
