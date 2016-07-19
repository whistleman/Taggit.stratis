PRIVATE ["_tagged","_tagger","_damage","_points","_score","_maxScore", "_selname"];
	
_tagged  = _this select 0;
_selname = _this select 1;
_damage  = _this select 2;
_tagger  = _this select 3;

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Switcharray: %1", _this];};

_tagged setdamage 0;

_points = _damage * -100;
if (WIS_SwitchINIT) exitwith {};
if (_tagger != "init" ) then {IF (_tagged == _tagger || _tagger iskindof "Man") exitwith {};};

WIS_SwitchINIT = true;
publicVariable "WIS_SwitchINIT";

if (_tagger != "init") then {
	
	_tagger setVariable ["Untagged", true, true];
	
	// Show a message about the points and who tagged who
	[[_tagged, _tagger, _points],"WIS_fnc_showHint", true, false] call BIS_fnc_MP;

	// Take the gun from the Tagger

	if (player == _tagger) then {
		clearMagazineCargoGlobal _tagger;
		clearWeaponCargoGlobal _tagger;
	};
};

// Give the tagged player a weapon and remove points from his score
if (player == _tagged) then {
	
	_tagged setVariable ["Tagged", true, true];
	
	// Give weapon
	player addWeapon WIS_TagWeapon;
	
	// Give magazine
	player addMagazine WIS_TagMagazine;
	
	if (WIS_Taggit_Debug == 1) then {
		diag_log format ["*-* DEBUG TAGGIT *-* Weapon: %1", WIS_TagWeapon];
		diag_log format ["*-* DEBUG TAGGIT *-* Magazine: %1", WIS_TagWeapon];
	};
	
	[player, _score] call WIS_fnc_Handle_Score;
	
};	

WIS_SwitchINIT = false;
publicVariable "WIS_SwitchINIT";