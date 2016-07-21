
_tagged = player getvariable "tagged";
if !(player == _tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

WIS_Ability = false; 
publicVariable "WIS_Ability";

player cutText ["","BLACK OUT", 1]; 

sleep 10;

player cutText ["","BLACK IN", 1]; 

WIS_Ability = true; 
publicVariable "WIS_Ability";