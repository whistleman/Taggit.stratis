//placeholder
_tagged = _this select 0;
_mapclickparams = _this select 1;

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Mapclickparams: %1", _mapclickparams];};

_pos   = _mapclickparams select 0;
_units = _mapclickparams select 1;
_shift = _mapclickparams select 2;
_alt   = _mapclickparams select 3;

if (_alt) then {
	// Remove map
	_tagged unassignItem "itemmap";
	_tagged removeItem "itemmap"; 

	// Remove Stacked EH
	["WIS_onMapClick", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	
	// Place players 
	{_x setpos _pos} foreach allPlayers;
	
	// Create ammobox for mags
	if (isServer) then {
		_magazine 	= WIS_TagMagazine;
		_box 		= "Box_NATO_Wps_F" createvehicle [(_pos select 0) + 2, (_pos select 1) + 2, _pos select 2];
		_box allowDamage false;
		
		// Clear cargo in box
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;
		
		// Add magazines of selected weapon
		_box addMagazineCargoGlobal [_magazine, 999];
	};
	
	// Show a hint that the players have some time to run away
	[[player, "run", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;
	
	// Give them some time to run away
	sleep 10;

	// Give the tagged one a gun
	[_tagged, "init", 0, "init"] call WIS_fnc_Switch;

	// Start score loop
	[[player, 10],"WIS_fnc_ScoreLoop", true, true, false] call BIS_fnc_MP;


} else {
	
	[[player, "wrongclick", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;
	
};