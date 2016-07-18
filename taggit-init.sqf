// Taggit

// to do:
/*
Create zone?
Randomly place players in zone
_tagger 
Scoring system?
Ammobox in the middle with ammo?
Special abilities?
Units outside of area get points substracted
*/



// Randomly select the first Tagger
_cntPlayableUnits = count Playableunits;
_justPlayers = allPlayers - entities "HeadlessClient_F";
_tagger = _justPlayers select floor random(_cntPlayableUnit - 1);

WIS_TagWeapon 	= "WIS_MaxScore" call BIS_fnc_getParamValue;

_MagazineArray = getArray (ConfigFile >> "CfgWeapons" >> WIS_TagWeapon >> "Magazines");
WIS_TagMagazine = _MagazineArray select 0;

[[_tagger, _justplayers, 0, "init"], "WIS_fnc_Switch", true, true] call BIS_fnc_MP;

if (hasInterface) exitwith {

	// handle damage or hit??
	//_ehPlayerHit = player addEventhandler ["Hit", {[[_this],"WIS_fnc_Switch", true,true] call BIS_FNC_MP;}];
	
	_ehPlayerHit = player addEventhandler ["HandleDamage", {[[_this],"WIS_fnc_Switch", true,true] call BIS_FNC_MP;}];
	
	[player, 10] spawn WIS_fnc_ScoreLoop;
};

