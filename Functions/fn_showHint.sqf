PRIVATE ["_tagged","_tagger", "_points"];

_tagged = _this select 0;
_tagger = [_this, 1, "start"] call BIS_fnc_param;
_points = [_this, 2, 0] call BIS_fnc_param;

if (typename _tagger == "STRING") then {

	switch (_tagger) do {

		CASE "start": {
			systemchat format ["Goodluck everyone! %1 is the first tagger", name _tagged];
			systemchat format ["%1 may choose a starting position on the map by shift-clicking on a position on the map.", name _tagged];
		};

		case "wrongclick":	{
			if (player == _tagged) then {systemchat format ["%1, you did not use shift-click!", _tagged];};
		};

		case "run":			{
			hint "Run! You have 10 seconds before Taggit begins!";
		};
	};

} else {
			hint format ["%1 tagged %2!", name _tagger, name _tagged];
			systemchat format ["%1 receives %2 points!", name _tagger, _points];
};
