//Defines
WIS_TagWeapon 			= "WIS_MaxScore" 	call BIS_fnc_getParamValue;
_MagazineArray  		= getArray (ConfigFile >> "CfgWeapons" >> WIS_TagWeapon >> "Magazines");
WIS_TagMagazine 		= _MagazineArray select 0;
WIS_Taggit_Debug 		= "WIS_TaggitDebug" call BIS_fnc_getParamValue;
WIS_Taggit_AreaSize 	= "WIS_AreaSize" 	call BIS_fnc_getParamValue;
WIS_Taggit_Uniform		= "WIS_Uniform" 	call BIS_fnc_getParamvalue;
WIS_Taggit_Vision		= "WIS_Vision" 		call BIS_fnc_getParamvalue;

if (hasInterface) then {

	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 hasInterface", name player];};
	
	// Does it have to be persistant?
	_ehPlayerHit = player addEventhandler ["HandleDamage", {[[_this],"WIS_fnc_Switch", true, false] call BIS_FNC_MP;}];
	
	// Give unit a uniform (or not)
	if (WIS_Taggit_Uniform != "NoChange") then {player forceAddUniform WIS_Taggit_Uniform;};
	
	// Give unit some Goggles
	if (WIS_Taggit_Vision != "NoChange") then {player linkItem WIS_Taggit_Vision;};
	
};

If (isServer) then {
	// Let the server randomly select the first Tagger
	_justPlayers 		= allPlayers - entities "HeadlessClient_F";
	_cntPlayableUnits 	= count _justPlayers;
	_tagged 			= _justPlayers select floor random(_cntPlayableUnit - 1);
	
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 players", _cntPlayableUnits];};
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is randomly selected.", name _tagged];};
	
	// Set all players except the first tagged player to "Untagged"
	{
		_x setVariable ["Untagged", true, true];
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is setvariable Untagged.", name _x];};
	} foreach _justPlayers - _tagged;
	
	// Set the tagged player to "Tagged"
	_tagged setVariable ["Tagged", true, true];
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is setvariable Tagged.", name _tagged];};
	
	//Give him the a map and let him click where he wants to play with the others
	_tagged linkItem "ItemMap";
	
	[[_tagged],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;
};

_init_tagged = player getvariable ["Tagged"];
if (_init_tagged) then {
	
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* init taggit succeeded: %1 ", _init_tagged];};
	
	//[key, event, code, arguments] call BIS_fnc_addStackedEventHandler; 
	["WIS_onMapClick", "onMapSingleClick", {[ player, _this] spawn WIS_fnc_SelectStartingPoint}]  call BIS_fnc_addStackedEventHandler;
};

