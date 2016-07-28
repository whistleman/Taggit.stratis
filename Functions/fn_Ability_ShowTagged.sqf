
_tagged = player getvariable "tagged";
if !(_tagged || WIS_Ability) exitwith {if (WIS_Ability) then {systemchat "There is already an ability active";};};

if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* Show position: %1 player: %2", _tagged, name player];};

WIS_Ability = false; 
publicVariable "WIS_Ability";

//Create marker
_mrk = createMarker ["It", player];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "hd_dot";
_mrk setMarkerColor "ColorRed";

while (_tagged) do {
	_cnt = 1;
	
	if ( _cnt == 12 ) exitwith {
		deletemarker _mrk;
		WIS_Ability = true; 
		publicVariable "WIS_Ability";
	};
	
	//follow for 10 seconds
	_mrk setMarkerPos (getpos player);
	
	sleep 1;
	_cnt = _cnt + 1;
};

if !(WIS_Ability) then {
	deletemarker _mrk;
	WIS_Ability = true; 
	publicVariable "WIS_Ability";
};
