PRIVATE ["_tagged", "_mapclickparams", "_magazine", "_box"];
_tagged 		= _this select 0;
_mapclickparams = _this select 1;

[format ["Array coming out of Mapclick %1", _this]] call WIS_fnc_Debug;
[format ["Mapclickparams: %1", _mapclickparams]] call WIS_fnc_Debug;

_pos   = _mapclickparams select 0;
//_units = _mapclickparams select 1;
_shift = _mapclickparams select 2;
_alt   = _mapclickparams select 3;

if (_alt && _shift) then {
	// Remove map
	_tagged unassignItem "itemmap";
	_tagged removeItem "itemmap";
	openMap false;

	// Remove onMapSingleClick
	onMapSingleClick "";

	if (isServer) then {
		// Create ammobox for mags
		_magazine 	= WIS_TagMagazine;
		_box 		= "Box_NATO_Wps_F" createvehicle [(_pos select 0) + 2, (_pos select 1) + 2, _pos select 2];
		_box allowDamage false;

		// Clear cargo in box
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;

		// Create marker
		WIS_mrk = createMarker ["Ammobox", _pos];
		WIS_mrk setMarkerColor "ColorOrange";
		WIS_mrk setMarkerShape "ELLIPSE";
		WIS_mrk setMarkerSize [WIS_Taggit_AreaSize,WIS_Taggit_AreaSize];
		WIS_mrk setMarkerAlpha 1;
		publicVariable "WIS_mrk";
		
		// Set players to pos
		{_x setposATL _pos} foreach allPlayers;
	};

	// Show a hint that the players have some time to run away
	[[player, "run", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;

	if (isNil "WIS_box_init" ) then {WIS_box_init = false};

	// Give them some time to run away
	sleep 10;

        If (isServer) then {
			// Add magazines of selected weapon
			_box addMagazineCargoGlobal [_magazine, 999];
			// Add maps for everyone
			_box addItemCargoGlobal ["itemmap", 10];
			WIS_box = _box;
			publicVariable "WIS_box";

			[format ["WIS_box pubvarred by server"]] call WIS_fnc_Debug;

			WIS_box_init = true;
			publicVariable "WIS_box_init";
		};

	waituntil {WIS_box_init};

	[format ["WIS_box pubvar received by %1", name player]] call WIS_fnc_Debug;

	[WIS_box] call WIS_fnc_AddActions;

	// Give the tagged one a gun and give him a head start because he is "de lul"
	[_tagged, "init", -0.50, "init"] call WIS_fnc_Switch;

	// Start score loop
	if (isServer) then {
		[_x, 10] remoteExec ["WIS_fnc_ScoreLoop",2,true];
	} forEach allPlayers;

} else {

	[[player, "wrongclick", 0], "WIS_fnc_showHint", true, false] call BIS_fnc_MP;

};
