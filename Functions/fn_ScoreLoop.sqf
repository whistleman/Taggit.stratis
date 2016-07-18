_unit = _this select 0;
_points = _this select 1;
while (alive _unit) do {
	sleep 
	[_unit, _points] call WIS_fnc_Handle_Score;
};	