
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
private ["_target","_players","_time","_nearUnits","_nearUnitsHostile"];

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
		while {((WEST knowsAbout _target) > 2.0) && (alive _target)} do {
			
			sleep 10;
		};
	};
	
	waitUntil {time > (_time + 5)};
};








