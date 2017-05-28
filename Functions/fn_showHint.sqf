PRIVATE ["_tagged","_tagger", "_points"];

_tagged = _this select 0;
_tagger = [_this, 1, "start"] call BIS_fnc_param;
_points = [_this, 2, 0] call BIS_fnc_param;

if (typename _tagger == "STRING") then {

	switch (_tagger) do {

		CASE "start": {
			["FistTagger",[format ["Goodluck everyone! %1 is the first tagger.", name _tagged], name _tagged]] call bis_fnc_showNotification;
			"Shift-Click" hintC format ["%1 may choose a starting position on the map by shift-clicking on a position on the map.", name _tagged];
		};

		case "wrongclick":	{
			if (player == _tagged) then {"Use shift-click" hintC format ["%1, you did not use shift-click!", name _tagged];};
		};

		case "run":			{
			["Run",["Run! You have 10 seconds before Taggit begins!"]] call bis_fnc_showNotification;
		};
	};

} else {
			["NewTagger",[format ["%1 tagged %2!", name _tagger, name _tagged]]] call bis_fnc_showNotification;
			systemchat format ["%1 receives %2 points!", name _tagger, _points];
};
