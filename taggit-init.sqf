//Defines
_weaponsarray 		= ["hgun_ACPC2_F","hgun_Pistol_heavy_02_Yorris_F","SMG_01_F","SMG_02_ACO_F","arifle_MXC_F","arifle_MXM_Hamr_pointer_F","srifle_GM6_LRPS_F","launch_RPG32_F"];
WIS_TagWeapon 		= _weaponsarray select ("WIS_Weapon" call BIS_fnc_getParamValue);
_MagazineArray  		= getArray (ConfigFile >> "CfgWeapons" >> WIS_TagWeapon >> "Magazines");
WIS_TagMagazine 		= _MagazineArray select 0;
WIS_Taggit_Debug 		= "WIS_TaggitDebug" call BIS_fnc_getParamValue;
WIS_Taggit_AreaSize 	= "WIS_AreaSize" call BIS_fnc_getParamValue;
_uniformarray 		= ["NoChange","U_B_GhillieSuit", "U_O_V_Soldier_Viper_F"];
WIS_Taggit_Uniform	= _uniformarray select ("WIS_Uniform" call BIS_fnc_getParamvalue);
_visionarray 			= ["NoChange", "NVGoggles", "H_HelmetSpecO_ghex_F"];
WIS_Taggit_Vision		= _visionarray select ("WIS_Vision" call BIS_fnc_getParamvalue);

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 hasInterface", name player];};

// Does it have to be persistant?
_ehPlayerHit = player addEventhandler ["HandleDamage", {[[_this],"WIS_fnc_Switch", true, false] call BIS_FNC_MP;}];

// Give unit a uniform (or not)
if (WIS_Taggit_Uniform != "NoChange") then {player forceAddUniform WIS_Taggit_Uniform;};

// Give unit some Goggles
if (WIS_Taggit_Vision != "NoChange") then {if (WIS_Taggit_Vision != "H_HelmetSpecO_ghex_F") then {player linkItem WIS_Taggit_Vision;} else {player addHeadgear WIS_Taggit_Vision}};

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Passed through EH and Uniform + Vision"];};

If (isServer) then {
	// Let the server randomly select the first Tagger
	_justPlayers 		= allPlayers - entities "HeadlessClient_F";
	_cntPlayableUnits = count _justPlayers;
	_tagged 			= _justPlayers call BIS_fnc_selectRandom;
	
	
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 players", _cntPlayableUnits];};
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is randomly selected.", name _tagged];};
	
	// Set all players except the first tagged player to "Untagged"
	{
		_x setVariable ["Untagged", true, true];
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is setvariable Untagged.", name _x];};
	} foreach _justPlayers;
	
	// Set the tagged player to "Tagged"
	_tagged setVariable ["Tagged", true, true];
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is setvariable Tagged.", name _tagged];};
	
	//Give him the a map and let him click where he wants to play with the others
	_tagged linkItem "ItemMap";
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 has a map? %2", name _tagged, ("itemMap" in assignedItems _tagged)];};
	
	[[_tagged],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;
};

_init_tagged = player getvariable "Tagged";
if (_init_tagged) then {
	
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* init taggit succeeded: %1. the player who is tagged is: %2", _init_tagged, name player];};
	
	//[key, event, code, arguments] call BIS_fnc_addStackedEventHandler; 
	//["WIS_onMapClick", "onMapSingleClick", {[ player, _this] spawn WIS_fnc_SelectStartingPoint}]  call BIS_fnc_addStackedEventHandler;
	player onMapSingleClick "[_this, [_pos,_units,_shift,_alt]] spawn WIS_fnc_SelectStartingPoint;";
};

