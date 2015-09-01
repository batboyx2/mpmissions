bsmrk_fnc_getSpawningPositions = {
	private ["_searchRange", "_angleSearch", "_theta", "_origin", "_positions", "_xOffset", "_yOffset", "_maxRangeToSpawns"];
	//find ten positions to spawn troops outside line-of-sight
	_searchRange = 300;
	_theta = 0;


	_searchRangeIncrement = 100;
	_thetaIncrement = 30;
	_numberOfPositions = 10; //how many positions to find
	_origin = getMarkerPos "mrk_defenseZone";
	_positions = []; //array of suitable positions
	_maxRangeToSpawns = 2000;
	//main loop
	while {_searchRange <= _maxRangeToSpawns} do {
		//get endpoint and check for LOS
		_xOffset = _searchRange * (cos _theta);
		_yOffset = _searchRange * (sin _theta);
		
		_startPos = [_origin select 0, _origin select 1, 5];
		_endPos = [(_origin select 0) + _xOffset, (_origin select 1) + _yOffset, 5];
		
		if !(surfaceIsWater _endPos) then {
			//on land
			if (terrainIntersect [_startPos, _endPos]) then {
				//on land, no line-of-sight
				if (isNil format["mrk_%1", _theta]) then {
					//on land, no line-of-sight, no other points in this direction
					_mrk = createMarker [format["mrk_%1", _theta], _endPos];
					_mrk setMarkerShape "ICON";
					_mrk setMarkerType "hd_dot";
					_mrk setMarkerColor "ColorGreen";
					_mrk setMarkerAlpha 0;
					_positions = _positions + [format["mrk_%1", _theta]];
				};
			};
		};
		//recursive programming
		_theta = _theta + _thetaIncrement;
		if (_theta >= 360) then {
			_theta = 0;
			_searchRange = _searchRange + _searchRangeIncrement;
		};
	};
	_positions
};



bsmrk_fnc_spawnGroup = {
	private ["_pos","_side","_sideR", "_unit", "_grp"];
	_pos = _this select 0;
	_side = (_this select 1) select (round (random 1));
	_sideR = switch (_side) do {
		case 1: {east};
		case 2: {west};
		case 3: {resistance};
	};
	_sideClasses = [
		["O_Soldier_F", "O_medic_F", "O_Soldier_AR_F", "O_Soldier_AAR_F", "O_Soldier_LAT_F", "O_support_MG_F", "O_soldier_AT_F", "O_sniper_F"], //east
		["B_Soldier_F", "B_medic_F", "B_Soldier_AR_F", "B_Soldier_AAR_F", "B_Soldier_LAT_F", "B_support_MG_F", "B_soldier_AT_F", "B_sniper_F"], //west
		["I_Soldier_F", "I_medic_F", "I_Soldier_AR_F", "I_Soldier_AAR_F", "I_Soldier_LAT_F", "I_support_MG_F", "I_soldier_AT_F", "I_sniper_F"] //ind
	];
	_grp = createGroup _sideR;
	//random number between two and half the amount of players ingame at current time, ie 20 players means 2-12 AI per group
	_grpSize = (2 + (ceil ((random (count playableUnits)) / 2)));
	for "_i" from 1 to _grpSize do {
		_unit = _grp createUnit [((_sideClasses select (_side - 1)) select (floor (random (count (_sideClasses select (_side - 1)))))), _pos, [], 0, "FORM"];
	};
	_wp = _grp addWaypoint [getMarkerPos "mrk_defenseZone", 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "LINE";
	_wp setWaypointSpeed "FULL";
};


private ["_interval","_posArray"];
_posArray = [] call bsmrk_fnc_getSpawningPositions;
_interval = 60;

while {true} do {
	_pos = getMarkerPos (_posArray select (floor (random (count _posArray))));
	[_pos, [bsmrk_param_attackingSide1P, bsmrk_param_attackingSide2P]] call bsmrk_fnc_spawnGroup;
	sleep _interval;
};





