_unit = _this select 0;

_tagged = _unit getvariable "tagged";
if !(_tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

[format ["Cant Move: %1 player: %2", _tagged, name _unit]] call WIS_fnc_Debug;

WIS_Ability = true;
publicVariable "WIS_Ability";

_unit enablesimulation false;

sleep 5;

_unit enablesimulation true;

WIS_Ability = false;
publicVariable "WIS_Ability";
