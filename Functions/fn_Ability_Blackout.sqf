
_tagged = player getvariable "tagged";
if !( _tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Blackout: %1 player: %2", _tagged, name player];};

WIS_Ability = false; 
publicVariable "WIS_Ability";

player cutText ["","BLACK OUT", 1]; 

sleep 10;

player cutText ["","BLACK IN", 1]; 

WIS_Ability = true; 
publicVariable "WIS_Ability";
