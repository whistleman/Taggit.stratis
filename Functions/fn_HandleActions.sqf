PRIVATE ["_unit", "_call","_id","_args","_fnc"];

_unit 	= _this select 0;
_call 	= _this select 1;
_id 	= _this select 2;
_args 	= _this select 3;
_fnc 	= _args select 0;

if (WIS_Taggit_Debug == 1) then {
	diag_log format ["*-* DEBUG TAGGIT *-* HandleActions started for %1 by %2", _fnc,_call];
};

switch (_fnc) do {

	case "WIS_fnc_Ability_CantMove": 	{
	
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_cantMove: %1", WIS_CantMove];};
		WIS_CantMove = WIS_CantMove + 1;
		PublicVariable "WIS_CantMove";
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_cantMove pubvarred: %1", WIS_CantMove];};
	
	};
	
	case "WIS_fnc_Ability_ShowTagged": 	{
	
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_ShowTagged: %1", WIS_ShowTagged];};
		WIS_ShowTagged = WIS_ShowTagged + 1;
		PublicVariable "WIS_ShowTagged";
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_ShowTagged pubvarred: %1", WIS_ShowTagged];};
	
	};

	case "WIS_fnc_Ability_Blackout":	{
	
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_Blackout: %1", WIS_Blackout];};
		WIS_Blackout = WIS_Blackout + 1;
		PublicVariable "WIS_Blackout";
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* WIS_Blackout pubvarred: %1", WIS_Blackout];};
	
	};	
	
};