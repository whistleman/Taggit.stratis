
_tagged = player getvariable "tagged";
if !(player == _tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

WIS_Ability = true;
publicVariable "WIS_Ability";

_tagged disablesimulation true;

sleep 5;

_tagged disablesimulation false;

WIS_Ability = false;
publicVariable "WIS_Ability";