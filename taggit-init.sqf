// Taggit

// to do:
/*
Ammobox in the middle with ammo?
Special abilities?
Units outside of area get points substracted
*/

WIS_TagWeapon 	= "WIS_MaxScore" call BIS_fnc_getParamValue;

_MagazineArray  = getArray (ConfigFile >> "CfgWeapons" >> WIS_TagWeapon >> "Magazines");
WIS_TagMagazine = _MagazineArray select 0;

WIS_Taggit_Debug = "WIS_TaggitDebug" call BIS_fnc_getParamValue;

if (hasInterface) then {
	
	// Does it have to be persistant?
	_ehPlayerHit = player addEventhandler ["HandleDamage", {[[_this],"WIS_fnc_Switch", true, false] call BIS_FNC_MP;}];
	
};

If (isServer) then {
	// Let the server randomly select the first Tagger
	_cntPlayableUnits = count Playableunits;
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_tagged = _justPlayers select floor random(_cntPlayableUnit - 1);
	
	// Set all players except the first tagged player to "Untagged"
	{_x setVariable ["Untagged", true, true];} foreach _justPlayers - _tagged;
	
	// Set the tagged player to "Tagged"
	_tagged setVariable ["Tagged", true, true];
	
	//Give him the a map and let him click where he wants to play with the others
	_tagged linkItem "ItemMap";


	[[_tagged],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;
};

_init_tagged = player getvariable ["Tagged"];
if (_init_tagged) then {

	//[key, event, code, arguments] call BIS_fnc_addStackedEventHandler; 
	["WIS_onMapClick", "onMapSingleClick", {[ player, _this] spawn WIS_fnc_SelectStartingPoint}]  call BIS_fnc_addStackedEventHandler;
};

