_unit = _this select 0;

_tagged = _unit getvariable "tagged";
if !( _tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

[format ["Blackout: %1 player: %2", _tagged, name _unit]] call WIS_fnc_Debug;

WIS_Ability = false;
publicVariable "WIS_Ability";

cutText ["","BLACK OUT", 1];

sleep 10;

cutText ["","BLACK IN", 1];

WIS_Ability = true;
publicVariable "WIS_Ability";
