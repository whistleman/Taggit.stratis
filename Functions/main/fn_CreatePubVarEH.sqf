WIS_CantMove = 1;
PublicVariable "WIS_CantMove";
"WIS_CantMove" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_CantMove};

WIS_ShowTagged = 1;
PublicVariable "WIS_ShowTagged";
"WIS_CantMove" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_ShowTagged};

WIS_Blackout = 1;
PublicVariable "WIS_Blackout";
"WIS_Blackout" addPublicVariableEventHandler {[] spawn WIS_fnc_Ability_Blackout};

//Debug
WIS_EhDebug = format ["Init PubVarEH: %1", name player];
"WIS_EhDebug" addPublicVariableEventHandler {_this spawn WIS_fnc_DebugServer};
PublicVariable "WIS_EhDebug";

WIS_SetState = [];
PublicVariable "WIS_SetState";
"WIS_SetState" addPublicVariableEventHandler {_this select 1 spawn WIS_fnc_SetState};

// For debug purposes
_pubvars = [WIS_CantMove,WIS_ShowTagged,WIS_Blackout,WIS_SetState];
_cnt = 1;
{
	[format ["%3 select %2: %1", _x, (_cnt -1), _pubvars]] call WIS_fnc_Debug;
	_cnt = _cnt + 1;
} forEach _pubvars;
