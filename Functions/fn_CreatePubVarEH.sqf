WIS_CantMove = 1;
PublicVariable "WIS_CantMove";
"WIS_CantMove" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_CantMove};

WIS_ShowTagged = 1;
PublicVariable "WIS_ShowTagged";
"WIS_CantMove" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_ShowTagged};

WIS_Blackout = 1;
PublicVariable "WIS_Blackout";
"WIS_Blackout" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_Blackout};

if (WIS_Taggit_Debug == 1) then {
	_pubvars = [WIS_CantMove,WIS_ShowTagged,WIS_Blackout];
	_cnt = 1;
	{
		diag_log format ["*-* DEBUG TAGGIT *-* %3 select %2: %1", _x, (_cnt -1), _pubvars];
		_cnt = _cnt + 1;
	} forEach _pubvars;
};
		