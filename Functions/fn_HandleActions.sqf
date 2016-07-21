PRIVATE ["_unit", "_call","_id","_args","_fnc"];

_unit 	= _this select 0;
_call 	= _this select 1;
_id 	= _this select 2;
_args 	= _this select 3;
_fnc 	= _args select 0;

switch (_fnc) do {

	case "WIS_fnc_Ability_CantMove": 	{
	
		WIS_CantMove = WIS_CantMove + 1;
		PublicVariable "WIS_CantMove";
	
	};
	
	case "WIS_fnc_Ability_ShowTagged": 	{
	
		WIS_ShowTagged = WIS_ShowTagged + 1;
		PublicVariable "WIS_ShowTagged";
	
	};

};