
_tagged = player getvariable "tagged";
if !(player == _tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

WIS_Ability = true;
publicVariable "WIS_Ability";

_tagged enablesimulation false;

sleep 5;

_tagged enablesimulation true;

WIS_Ability = false;
publicVariable "WIS_Ability";