/*
Passed array:
0	tagged player
1	tagger
2	points
*/

if (count _this) exitwith {};

_tagged 	= _this select 0;
_tagger 	= _this select 1;
_points	 	= _this select 2;

IF !(_tagger == "init") then {
	// Set variable untagged to true and tagged to false.
	_tagged setVariable ["Untagged", true, true];
	_tagged setVariable ["Tagged", false, true];

	// Show a message about the points and who tagged who
	[[_tagged, _tagger, _points],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;

	// Take the gun from the Tagger
	clearMagazineCargoGlobal _tagged;
	clearWeaponCargoGlobal _tagged;
};

// Set variable untagged to false and tagged to true.
_tagger setVariable ["Untagged", false, true];
_tagger setVariable ["Tagged", true, true];

// Give magazine
_tagger addMagazineGlobal WIS_TagMagazine;
[format ["added Magazine: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

// Give weapon
_tagger addWeaponGlobal WIS_TagWeapon;
[format ["added Weapon: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

// Remove points from his score
[_tagger, _points] call WIS_fnc_Handle_Score;

// Set WIS_SwitchINIT back to false by the tagged person and than broadcast it to all clients
WIS_SwitchINIT = false;
publicVariable "WIS_SwitchINIT";
