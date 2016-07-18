PRIVATE ["_unit", "_points"];

_unit = _this select 0;
_points = _this select 1;
while {alive _unit} do {
	sleep 30;
	[_unit, _points] call WIS_fnc_Handle_Score;
};	