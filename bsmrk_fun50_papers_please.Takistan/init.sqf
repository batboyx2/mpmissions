enableSaving [false, false];

enableSentences false;

//[] call F_fnc_showBriefing;

if (!isNil "PABST_fnc_safeStart") then {[] spawn PABST_fnc_safeStart;};

if !(isDedicated) then {
	if ((side player) == civilian) then {
		//sides
		_class = round (random 1);
		if (_class == 0) then {
			//is foreign
			player setVariable ["isForeign", true, true];
		};
		if (_class == 1) then {
			//is local
			player setVariable ["isForeign", false, true];
		};
	};
};

sleep 0.5;

private ["_police","_civs","_gunNum","_civsTemp"];

if (isServer) then {
	//gunpools
	_police = [];
	_civs = [];
	{
		if ((alive _x) && ((side _x) == west)) then {
			_police = _police + [_x];
		};
		if ((alive _x) && ((side _x) == civilian)) then {
			_civs = _civs + [_x];
		};
	} forEach allPlayers;
	
	
	_civsTemp = _civs;
	_gunNum = count _police;
	
	for "_i" from 1 to _gunNum do {
		_unit = _civsTemp select (floor (random (count _civsTemp)));
		_unit setVariable ["hasGun", true, true];
		_civsTemp = _civsTemp - [_unit];
	};
	{
		_unit setVariable ["hasGun", false, true];
	} forEach _civsTemp;
};
















