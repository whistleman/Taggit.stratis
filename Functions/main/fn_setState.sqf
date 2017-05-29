/*
Passed array:
0	tagged player
1	tagger
2	points
*/

if (count _this < 1) exitwith {};

_tagged 	= _this select 0;
_tagger 	= _this select 1;
_points	 	= _this select 2;

[format ["added setState array: %1", _this]] call WIS_fnc_Debug;

if (typename _tagger != "STRING") then {

	_WasTagged = _tagger getVariable "Tagged";
	[format ["%1 Tagged: %2 (first time should be true)", name _tagger, _WasTagged]] call WIS_fnc_Debug;

	if (_WasTagged) then {
		// Set variable untagged to true and tagged to false.
		_tagger setVariable ["Untagged", true, true];
		_tagger setVariable ["Tagged", false, true];
		[format ["%1 Tagged: %2 Untagged: %3 (should be false, true)", name _tagger, _tagger getVariable "Tagged", _tagger getVariable "Untagged"]] call WIS_fnc_Debug;

		// Show a message about the points and who tagged who
		[[_tagged, _tagger, _points],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;

		// Take the gun from the Tagger
		_tagger removeWeaponGlobal WIS_TagWeapon;
		_tagger removeMagazineGlobal WIS_TagMagazine;
		[format ["%1 gets weapons and magazines removed", _tagger]] call WIS_fnc_Debug;

		// Clear cargo to be sure
		clearMagazineCargoGlobal _tagger;
		clearWeaponCargoGlobal _tagger;
	};

	_WasUntagged = _tagged getvariable "Untagged";
	[format ["%1 Untagged: %2 (first time should be true)", name _tagged, _WasUntagged]] call WIS_fnc_Debug;

	if (_WasUntagged) then {
		// Set variable untagged to false and tagged to true.
		_tagged setVariable ["Untagged", false, true];
		_tagged setVariable ["Tagged", true, true];
		[format ["%1 Tagged: %2 Untagged: %3 (should be true, false)", name _tagger, _tagged getVariable "Tagged", _tagged getVariable "Untagged"]] call WIS_fnc_Debug;

		// Give magazine
		_tagged addMagazineGlobal WIS_TagMagazine;
		[format ["added Magazine: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

		// Give weapon
		_tagged addWeaponGlobal WIS_TagWeapon;
		[format ["added Weapon: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

		// Remove points from his score
		[_tagged, _points] call WIS_fnc_Handle_Score;

		// Set WIS_SwitchINIT back to false by the tagged person and than broadcast it to all clients
		WIS_SwitchINIT = false;
		publicVariable "WIS_SwitchINIT";
	};
} else {
	if (_tagger == "init") then {
		// Set variable untagged to false and tagged to true.
		_tagged setVariable ["Untagged", false, true];
		_tagged setVariable ["Tagged", true, true];

		// Give magazine
		_tagged addMagazineGlobal WIS_TagMagazine;
		[format ["added Magazine: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

		// Give weapon
		_tagged addWeaponGlobal WIS_TagWeapon;
		[format ["added Weapon: %1", WIS_TagWeapon]] call WIS_fnc_Debug;

		// Remove points from his score
		[_tagged, _points] call WIS_fnc_Handle_Score;

		// Set WIS_SwitchINIT back to false by the tagged person and than broadcast it to all clients
		WIS_SwitchINIT = false;
		publicVariable "WIS_SwitchINIT";
};
};
