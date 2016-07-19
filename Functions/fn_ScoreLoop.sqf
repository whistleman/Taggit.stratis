PRIVATE ["_unit", "_points","_dist"];

_unit 	= _this select 0;
_points = _this select 1;

while {alive _unit} do {

	_dist = _unit _distance (getMarkerPos WIS_mrk);
	
	if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 is %2 meters away from WIS_mrk", name _unit, _dist];};
	
	if (_dist > WIS_Taggit_AreaSize) then {
		
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 will receive %2 points as penalty", name _unit, (_points * -1)];};
		
		// When player is outside the marked area, he will receive a penalty of _points per 5 seconds
		[_unit, (_points * -1)] call WIS_fnc_Handle_Score;	
		
		// Show a hint so the player knows that he is outside the area
		HINT FORMAT ["%1 has ventured outside the playground and will receive a penalty of %2 points", name _unit, _points];
		
		// Sleep for 5 seconds
		sleep 5;
		
	} else {
		
		if (WIS_Taggit_Debug == 1) then {diag_log format ["*-* DEBUG TAGGIT *-* %1 will receive %2 points", name _unit, _points];};
		
		_tagged = _unit getVariable ["Tagged"];
		
		// Check if player is tagged. If tagged the player will not receive any points
		if !(_tagged) then {
			// When player is inside he will receive _points every 30 seconds
			[_unit, _points] call WIS_fnc_Handle_Score;
		};
		
		// Sleep for 30 seconds
		sleep 30;
		
	};
};	

