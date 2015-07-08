
// ====================================================================================
//_players = players
fnc_bsmrk_getPlayersCur = { //returns current players
	private ["_players"];
	_players = [];
	{
		if (isPlayer _x) then {
			_players = _players + [_x];
		};
	} forEach allUnits;
	_players
};

// ====================================================================================
// any = [group] call fnc_bsmrk_saveAndRemoveWaypoints
fnc_bsmrk_saveAndRemoveWaypoints = { //save waypoints of a certain group and remove them
	private ["_group","_waypoints","_waypointsD"];
	_group = _this select 0;
	_waypoints = waypoints _group;
	_waypointsD = [];
	{
		_waypointsD = _waypointsD + [[_x, waypointType _x, waypointSpeed _x, waypointPosition _x]];
	} forEach _waypoints;
	_group setVariable ["var_groupWaypoints", _waypointsD];
	{deleteWaypoint _x} forEach (waypoints _group);
};
#define removeWaypoints(X) [X] call fnc_bsmrk_saveAndRemoveWaypoints;
// ====================================================================================
// any = [group] call fnc_bsmrk_reAddWaypoints
fnc_bsmrk_reAddWaypoints = { //readd removed waypoints to a group
	_group = _this select 0;
	_waypointD = _group getVariable "var_groupWaypoints";
	{deleteWaypoint _x} forEach (waypoints _group);
	{
		_wp = (_x select 0);
		_wpType = (_x select 1);
		_wpSpeed = (_x select 2);
		_wpPos = (_x select 3);
		
		_group addWaypoint [_wpPos, 0];
		_wp setWaypointType _wpType;
		_wp setWaypointSpeed _wpSpeed;
	} forEach _waypointD;
};
#define addWaypoints(X) [X] call fnc_bsmrk_reAddWaypoints;
// ====================================================================================
// any = [] call fnc_bsmrk_hasLOS
fnc_bsmrk_hasLOS = { //check if pointer has a line of sight to target
	private ["_return","_target","_pointer"];
	_target = _this select 0;
	_pointer = _this select 1;
	if ((_target distance _pointer) > 1000) then {_return = false;};
	_interObj = lineIntersects [(getPosASL _target), (getPosASL _pointer), _target, _pointer];
	_interTer = terrainIntersectASL [(getPosASL _target), (getPosASL _pointer)];
	if (_interObj || _interTer) then {_return = false} else {_return = true;};
	_return
};
#define hasLOS(X,Y) [X,Y] call fnc_bsmrk_hasLOS;
// ====================================================================================
private ["_target","_players","_time","_nearUnits","_nearUnitsHostile","_varHelp","_nearHostileGroups"];

while {true} do {
	_players = [] call fnc_bsmrk_getPlayersCur;
	_time = time;
	_target = objNullHa;
	{
		if (WEST knowsAbout _x > 2.0) exitWith {_target = _x;}
	} forEach _players;
	if !(_target == objNullHa) then {
		//diag_log "diagnose_1";
		_nearUnitsHostile = [];
		_nearUnits = (getPos _target) nearObjects ["Man", 1000];
		{
			if (side _x == west) then {
				_nearUnitsHostile = _nearUnitsHostile + [_x];
			};
		} forEach _nearUnits;
		//diag_log format["diagnose_%1",_nearUnitsHostile];
		
		_nearHostileGroups = [];
		{
			if !((group _x) in _nearHostileGroups) then {
				_nearHostileGroups = _nearHostileGroups + [group _x];
			};
		} forEach _nearUnitsHostile;
		//diag_log format["diagnose_%1",_nearHostileGroups];
		
		{
			removeWaypoints(_x);
			_wp = _x addWaypoint [(getPos _target), 0];
			_wp setWaypointSpeed "FULL";
			//diag_log format["diagnoseWP_%1",_wp];
		} forEach _nearHostileGroups;
		_varHelp = true;
		while {(_varHelp) && ((WEST knowsAbout _target) > 2.0) && (alive _target)} do {
			{
				_pointer = _x;
				if (_varHelp) then {_varHelp = hasLOS(_target, _pointer);};
				sleep 0.01;
			} forEach _nearUnitsHostile;
			sleep 5;
		};
		
	};
	
	waitUntil {time > (_time + 5)};
};








