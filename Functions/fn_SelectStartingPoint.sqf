PRIVATE ["_tagged", "_mapclickparams", "_magazine", "_box"];
_tagged = _this select 0;
_mapclickparams = _this select 1;

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Array coming out of Mapclick %1", _this];};
if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Mapclickparams: %1", _mapclickparams];};

//_units = _mapclickparams select 1;
_pos   = _mapclickparams select 0;
_shift = _mapclickparams select 2;
_alt   = _mapclickparams select 3;

onMapSingleClick "";

if (_alt && _shift) then {
	// Remove map
	_tagged unassignItem "itemmap";
	_tagged removeItem "itemmap"; 

	// Remove Stacked EH
	//["WIS_onMapClick", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	
	// Place players 
	{_x setposATL _pos} foreach allPlayers;
	
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
		
		// Create marker
		WIS_mrk = createMarker ["Ammobox", _pos];
		WIS_mrk setMarkerColor "ColorOrange";
		WIS_mrk setMarkerShape "ELLIPSE";
		WIS_mrk setMarkerSize [WIS_Taggit_AreaSize,WIS_Taggit_AreaSize];
		WIS_mrk setMarkerAlpha 1;		
		publicVariable "WIS_mrk";
	};
	
	// Show a hint that the players have some time to run away
	[[player, "run", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;
	
	// Give them some time to run away
	sleep 10;

	// Give the tagged one a gun and give him a head start because he is "de lul"
	[_tagged, "init", -0.50, "init"] call WIS_fnc_Switch;

	// Start score loop
	[[player, 10],"WIS_fnc_ScoreLoop", true, true, false] call BIS_fnc_MP;


} else {
	
	[[player, "wrongclick", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;
	
};