class WIS
{
	class Main
	{
		file = "functions\main";
		class Handle_score {file = "fn_handle_score.sqf";};
		class ScoreLoop {file = "fn_Scoreloop.sqf";};
		class Switch {file = "fn_Switch.sqf";};
		class showHint {file = "fn_showHint.sqf";};
		class SelectStartingPoint {file = "fn_selectStartingPoint.sqf";};
		class setState {file = "fn_setState.sqf";};
		class CreatePubVarEH {file = "fn_CreatePubVarEH.sqf";};
		class resetAmmo {file = "fn_resetAmmo.sqf";};
	};
	class Abilities
	{
		file = "functions\abilities";
		class Ability_CantMove {file = "functions\fn_Ability_CantMove.sqf";};
		class Ability_ShowTagged {file = "functions\fn_Ability_ShowTagged.sqf";};
		class Ability_Blackout {file = "functions\fn_Ability_Blackout.sqf";};
		class AddActions {file = "functions\fn_AddActions.sqf";};
		class HandleActions {file = "functions\fn_HandleActions.sqf";};
	};
	class Debug
	{
		file = "functions\debug";
		class Debug {file="functions\fn_Debug.sqf";};
		class DebugServer {file="functions\fn_DebugServer.sqf";};
	};
};
