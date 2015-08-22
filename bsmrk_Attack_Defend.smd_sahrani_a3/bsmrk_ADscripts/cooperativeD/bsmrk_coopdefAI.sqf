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
		
		_startPos = [_origin select 0, _origin select 1, 10];
		_endPos = [(_origin select 0) + _xOffset, (_origin select 1) + _yOffset, 10];
		
		if (((ATLToASL _endPos) select 2) > 0) then {
			//on land
			if (terrainIntersect [_startPos, _endPos]) then {
				//on land, no line-of-sight
				if (isNil format["mrk_%1", _theta]) then {
					//on land, no line-of-sight, no other points in this direction
					
					_positions = _positions + [[_endPos select 0, _endPos select 1, 0]];
					
					_mrk = createMarker [format["mrk_%1", _theta], _endPos];
					_mrk setMarkerShape "ICON";
					_mrk setMarkerType "hd_dot";
					_mrk setMarkerColor "ColorGreen";
					_mrk setMarkerAlpha 0;
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
	private ["_pos","_side"];
	_pos = _this select 0;
	_side = (_this select 1) select (round (random 1));
	
};



private ["_interval","_posArray","_side1","_side2"];
_posArray = [] call bsmrk_fnc_getSpawningPositions;
_interval = 60;

while {true} do {
	_pos = _posArray select (floor (random (count _posArray)));
	if !(isDedicated) then {
		[_pos, [_side1, _side2]] call bsmrk_fnc_spawnGroup; //on server if not dedicated
	} else {
		[{[_pos, [_side1, _side2]] call bsmrk_fnc_spawnGroup;}, "BIS_fnc_spawn", HC] call BIS_fnc_MP; //on HC if dedicated
	};
	sleep _interval;
};





