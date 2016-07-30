_unit = _this select 0;

_tagged = _unit getvariable "tagged";
if !(_tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

[format ["Show position: %1 player: %2", _tagged, name _unit]] call WIS_fnc_Debug;

WIS_Ability = false;
publicVariable "WIS_Ability";

//Create marker
_mrk = createMarker ["It", _unit];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "hd_dot";
_mrk setMarkerColor "ColorRed";

_cnt = 1;
while {_cnt < 11} do {
	//follow for 10 seconds
	_mrk setMarkerPos (getpos player);
	if (_cnt == 10) then {
		deletemarker _mrk;
		WIS_Ability = true;
		publicVariable "WIS_Ability";
	};
	sleep 1;
	_cnt = _cnt + 1;
};

/*
if !(WIS_Ability) then {
	deletemarker _mrk;
	WIS_Ability = true;
	publicVariable "WIS_Ability";
};
*/
