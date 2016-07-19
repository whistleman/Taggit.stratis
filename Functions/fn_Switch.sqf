PRIVATE ["_tagged","_tagger","_damage","_points","_score","_maxScore", "_selname"];
	
_tagged  = _this select 0;
_selname = _this select 1;
_damage  = _this select 2;
_tagger  = _this select 3;

_tagged setdamage 0;

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Switcharray: %1", _this];};

_points = _damage * -100;

// When switch is already happening
if (WIS_SwitchINIT) exitwith {};

// When Tagged person is already Tagged
_isTagged = _tagged getVariable ["Tagged"];

//Check if init
if (_tagger != "init") then {
	// Check if the tagged one is the tagger
	// Check if the tagger is something else than a man
	// Check if the tagged person is already tagged
	IF (_tagged == _tagger || !(_tagger iskindof "Man") || _isTagged) exitwith {};
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

_isUnTagged = _tagged getVariable ["Untagged"];

// Check if player is tagged and if the player was untagged.
if (player == _tagged && _isUnTagged) then {
	
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
	[player, _score] call WIS_fnc_Handle_Score;
	
};	

WIS_SwitchINIT = false;
publicVariable "WIS_SwitchINIT";