PRIVATE ["_tagged","_tagger","_damage","_points","_score","_maxScore", "_selname"];
	
_tagged  = _this select 0;
_selname = _this select 1;
_damage  = _this select 2;
_tagger  = _this select 3;

_tagged setdamage 0;

_points = _damage * -100;
if (WIS_SwitchINIT) exitwith {};
if (_tagger != "init" ) then {IF (_tagged == _tagger || _tagger iskindof "Man") exitwith {};};

WIS_SwitchINIT = true;
publicVariable "WIS_SwitchINIT";

if (_tagger == "init") then {
	hint format ["Goodluck everyone! %1 is the first tagger", name _tagged];
} else {
	hint format ["%1 tagged %2!", name _tagger, name _tagged];
	hint format ["%1 receives %2 points!", name _tagger, _points];
};

// Take the gun from the Tagger
if (_tagger != "init") then {
	if (player == _tagger) then {
		clearMagazineCargoGlobal _tagger;
		clearWeaponCargoGlobal _tagger;
	};
};

// Give the tagged player a weapon and remove points from his score
if (player == _tagged) then {
	
	// Give weapon
	player addWeapon WIS_TagWeapon;
	
	// Give magazine
	player addMagazine WIS_TagMagazine;
	
	[player, _score] call WIS_fnc_Handle_Score;
	
};	

WIS_SwitchINIT = false;
publicVariable "WIS_SwitchINIT";