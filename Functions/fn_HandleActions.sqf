PRIVATE ["_unit", "_call","_id","_args","_fnc"];

_unit 	= _this select 0;
_call 	= _this select 1;
_id 	= _this select 2;
_args 	= _this select 3;
_fnc 	= _args select 0;


[format ["HandleActions started for %1 by %2", _fnc,_call]] call WIS_fnc_Debug;


switch (_fnc) do {

	case "WIS_fnc_Ability_CantMove": 	{
	
		[format ["WIS_cantMove: %1", WIS_CantMove]] call WIS_fnc_Debug;
		WIS_CantMove = WIS_CantMove + 1;
		PublicVariable "WIS_CantMove";
		[format ["WIS_cantMove pubvarred: %1", WIS_CantMove]] call WIS_fnc_Debug;
	
	};
	
	case "WIS_fnc_Ability_ShowTagged": 	{
	
		[format ["WIS_ShowTagged: %1", WIS_ShowTagged]] call WIS_fnc_Debug;
		WIS_ShowTagged = WIS_ShowTagged + 1;
		PublicVariable "WIS_ShowTagged";
		[format ["WIS_ShowTagged pubvarred: %1", WIS_ShowTagged]] call WIS_fnc_Debug;
	
	};

	case "WIS_fnc_Ability_Blackout":	{
	
		[format ["WIS_Blackout: %1", WIS_Blackout]] call WIS_fnc_Debug;
		WIS_Blackout = WIS_Blackout + 1;
		PublicVariable "WIS_Blackout";
		[format ["WIS_Blackout pubvarred: %1", WIS_Blackout]] call WIS_fnc_Debug;
	
	};	
	
};

	//If these do not work then:
	//[[],_fnc,true,true,false] call BIS_fnc_MP;