
_tagged = player getvariable "tagged";
if !(_tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Cant Move: %1 player: %2", _tagged, name player];};

WIS_Ability = true;
publicVariable "WIS_Ability";

_tagged enablesimulation false;

sleep 5;

_tagged enablesimulation true;

WIS_Ability = false;
publicVariable "WIS_Ability";
