//Defines
_weaponsarray 		= ["hgun_ACPC2_F","hgun_Pistol_heavy_02_Yorris_F","SMG_01_F","SMG_02_ACO_F","arifle_MXC_F","arifle_MXM_Hamr_pointer_F","srifle_GM6_LRPS_F"];
WIS_TagWeapon 		= _weaponsarray select ("WIS_Weapon" call BIS_fnc_getParamValue);
_MagazineArray  	= getArray (ConfigFile >> "CfgWeapons" >> WIS_TagWeapon >> "Magazines");
WIS_TagMagazine 	= _MagazineArray select 0;
WIS_Taggit_Debug 	= "WIS_TaggitDebug" call BIS_fnc_getParamValue;
WIS_Taggit_AreaSize = "WIS_AreaSize" call BIS_fnc_getParamValue;
_uniformarray 		= ["NoChange","U_B_GhillieSuit", "U_O_V_Soldier_Viper_F"];
WIS_Taggit_Uniform	= _uniformarray select ("WIS_Uniform" call BIS_fnc_getParamvalue);
_visionarray 		= ["NoChange", "NVGoggles", "H_HelmetO_ViperSP_ghex_F"];
WIS_Taggit_Vision	= _visionarray select ("WIS_Vision" call BIS_fnc_getParamvalue);

[ format ["%1 hasInterface", name player]] call WIS_fnc_debug;

{
	_ehPlayerHitNoDomage	= _x addEventhandler ["HandleDamage", {0}];
	_ehPlayerHit 					= _x addEventhandler ["HandleDamage", {_this spawn WIS_fnc_Switch;}];
	_ehPlayerFired				= _x addEventhandler ["Fired", {_this call WIS_fnc_resetAmmo;}];
} foreach allunits;

// Give unit a uniform (or not)
if (WIS_Taggit_Uniform != "NoChange") then {player forceAddUniform WIS_Taggit_Uniform;};

// Give unit some Goggles
if (WIS_Taggit_Vision != "NoChange") then {if (WIS_Taggit_Vision != "H_HelmetSpecO_ghex_F") then {player linkItem WIS_Taggit_Vision;} else {player addHeadgear WIS_Taggit_Vision}};

[ format ["Passed through EH and Uniform + Vision"]] call WIS_fnc_debug;

WIS_chosen_tagged = false;

If (isServer) then {
	// Let the server randomly select the first Tagger
	_justPlayers 		= call BIS_fnc_listPlayers;
	_cntPlayableUnits 	= count _justPlayers;
	_tagged 			= selectRandom _justPlayers;

	[format ["%1 players", _cntPlayableUnits]] call WIS_fnc_debug;
	[format ["%1 is randomly selected.", name _tagged]] call WIS_fnc_debug;

	// Set all players except the first tagged player to "Untagged"
	{
		_x setVariable ["Untagged", true, true];
		_x setVariable ["Tagged", false, true];
		[format ["%1 is setvariable Untagged.", name _x]] call WIS_fnc_debug;
	} foreach allUnits;

	// Set the tagged player to "Tagged"
	_tagged setVariable ["Untagged", false, true];
	_tagged setVariable ["Tagged", true, true];
	[format ["%1 is setvariable Tagged."]] call WIS_fnc_debug;

	//Give him the a map and let him click where he wants to play with the others
	_tagged linkItem "ItemMap";
	[format ["%1 has a map? %2", name _tagged, ("itemMap" in assignedItems _tagged)]] call WIS_fnc_debug;

	[_tagged] remoteExec ["WIS_fnc_showHint", 0, false];
	//[[_tagged],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;

	WIS_chosen_tagged = true;
	publicVariable "WIS_chosen_tagged";
};

waituntil {WIS_chosen_tagged};
_init_tagged = player getvariable "Tagged";
[format ["Init_tagged: %1", _init_tagged]] call WIS_fnc_debug;
if (_init_tagged) then {

	[format ["Init taggit succeeded: %1. The player who is tagged is: %2", _init_tagged, name player]] call WIS_fnc_debug;
	player onMapSingleClick "[_this, [_pos,_units,_shift,_alt]] remoteExec ['WIS_fnc_SelectStartingPoint', 0, false]";
	//player onMapSingleClick "[[_this, [_pos,_units,_shift,_alt]], 'WIS_fnc_SelectStartingPoint', true, true, false] call BIS_fnc_MP;";
};
