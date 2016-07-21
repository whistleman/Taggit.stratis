//fn_addactions

_box 		= _this select 0;
_actions 	= [["'It' cannot move", "WIS_fnc_Ability_CantMove"], ["Show position of 'it'", "WIS_fnc_Ability_ShowTagged"], ["Blackout 'It'","WIS_fnc_Ability_Blackout"]];
WIS_Ability	= true;

// Set the public variables for all users.
[] call WIS_fnc_CreatePubVarEH;

{
	_acttext = _x select 0;
	_actfnc  = _x select 1;
	_act 	 = _box addaction [_acttext, "WIS_fnc_Handle_Actions",[_actfnc]];
} foreach _actions;

 
/*
Note to self:
When adding new abilities do following:
-add new ability to array _actions.
-add new publicvariable and publicvariableeventhandler 
-add the function to functions.hpp
-add to the switch in fn_HandleActions.sqf
*/