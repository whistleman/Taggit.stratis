PRIVATE ["_tagged","_tagger","_damage","_points","_score","_maxScore", "_selname"];

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Switcharray: %1", _this];};
	
_tagged  = _this select 0;
_selname = _this select 1;
_damage  = _this select 2;
_tagger  = _this select 3;

if !(_selname == "") exitwith {};

_tagged setdamage 0;

_points = _damage * -100;

// Check if WIS_SwitchINIT variable exists, if it does not make it false.
if (isNil "WIS_SwitchINIT") then {WIS_SwitchINIT = false; publicVariable "WIS_SwitchINIT";};
// When switch is already happening
if (WIS_SwitchINIT) exitwith {};

//Check if init
if (_tagger != "init") then {
	// Check if the tagged one is the tagger
	// Check if the tagger is something else than a man
	// Check if player is both tagger and tagged
	IF (_tagged == _tagger || !(_tagger iskindof "Man") || (player == _tagged && player == _tagger)) exitwith {};
};

WIS_SwitchINIT = true;
publicVariable "WIS_SwitchINIT";

if (_tagger != "init" && player != _tagged) then {
	
	// Set variable untagged to true and tagged to false.
	_tagger setVariable ["Untagged", true, true];
	_tagger setVariable ["Tagged", false, true];
	
	// Show a message about the points and who tagged who
	[[_tagged, _tagger, _points],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;

	// Take the gun from the Tagger
	if (player == _tagger) then {
		clearMagazineCargoGlobal _tagger;
		clearWeaponCargoGlobal _tagger;
	};
};

_isUnTagged = _tagged getVariable "Untagged";

// Check if player is tagged and if the player was untagged.
if (player == _tagged && !_isUnTagged) then {
	
	// Set variable untagged to false and tagged to true.
	_tagged setVariable ["Untagged", false, true];
	_tagged setVariable ["Tagged", true, true];
	
	// Give weapon
	player addWeapon WIS_TagWeapon;
	
	// Give magazine
	player addMagazine WIS_TagMagazine;
	
	if (WIS_Taggit_Debug == 1) then {
		diag_log format ["*-* DEBUG TAGGIT *-* Weapon: %1", WIS_TagWeapon];
		diag_log format ["*-* DEBUG TAGGIT *-* Magazine: %1", WIS_TagWeapon];
	};
	// Remove points from his score
	[player, _points] call WIS_fnc_Handle_Score;
	
	// Set WIS_SwitchINIT back to false by the tagged person and than broadcast it to all clients
	WIS_SwitchINIT = false;
	publicVariable "WIS_SwitchINIT";
};	

