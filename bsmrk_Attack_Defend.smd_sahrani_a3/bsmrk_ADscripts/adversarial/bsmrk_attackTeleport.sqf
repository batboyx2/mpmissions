private ["_attackers","_attackingUnits","_attackingLeaders"];
_attackers = _this;
_attackingUnits = [];
_attackingLeaders = [];

{
	if (_x == 1) then {_attackers = _attackers - [_x]; _attackers = _attackers + ["EAST"]};
	if (_x == 2) then {_attackers = _attackers - [_x]; _attackers = _attackers + ["WEST"]};
	if (_x == 3) then {_attackers = _attackers - [_x]; _attackers = _attackers + ["GUER"]};
} forEach _attackers;

{
	if ((str (side _x)) in _attackers) then {
		_attackingUnits = _attackingUnits + [_x];
	};
} forEach allUnits;

{
	if ((leader (group _x)) == _x) then {
		_attackingLeaders = _attackingLeaders + [_x];
	};
} forEach _attackingUnits;










bsmrk_fnc_doTeleportUpper = {
	private ["_time","_pos","_target","_units"];
	_time = time;
	_pos = _this select 0;
	_target = _this select 1;
	_units = units (group _target);
	if ((_pos distance (getMarkerPos "mrk_bufferZone")) > (bsmrk_param_zoneRadiusP * 4)) then {
		{
			_x allowDamage false;
			_x setPos _pos;
		} forEach _units;
		gv_teleported = true;
		waitUntil {time > _time + 10};
		{
			_x allowDamage true;
		} forEach _units;
	} else {
		gv_teleported = true;
	};
};

bsmrk_fnc_doTeleport = {
	private ["_id2","_id3"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	if (_target == _caller) then {
		[[_target, _id], "removeAction", _target] call BIS_fnc_MP;
		[format["%1, please open your map and left-click the point you wish to teleport your group to. This point should be outside the red exclusion zone.", name _target], "systemChat", _target] call BIS_fnc_MP;
		_target onMapSingleClick {[_pos, _this] spawn bsmrk_fnc_doTeleportUpper};
		gv_teleported = false;
		waitUntil {gv_teleported};
		onMapSingleClick "";
		[format["%1, are you at the right point?", name _target], "systemChat", _target] call BIS_fnc_MP;
		
		_id2 = [
			[
				_target,
				[
					"Yes",
					{
						[(_this select 0), "removeAllActions", _this select 0] call BIS_fnc_MP;
					},
					nil,
					1.5,
					true,
					true
				]
			],
			"addAction",
			_target
		] call BIS_fnc_MP;
		
		_id3 = [
			[
				_target,
				[
					"No",
					{
						[(_this select 0), "removeAllActions", _this select 0] call BIS_fnc_MP;
						(_this select 0) call bsmrk_fnc_createTeleAction;
					},
					nil,
					1.5,
					true,
					true
				]
			],
			"addAction",
			_target
		] call BIS_fnc_MP;
		
	};
};

bsmrk_fnc_createTeleAction = {
	private ["_leader"];
	_leader = _this;
	[
		[
			_leader,
			[
				"Teleport Team",
				bsmrk_fnc_doTeleport,
				nil,
				1.5,
				true,
				true
			]
		],
		"addAction",
		_leader
	] call BIS_fnc_MP;
};

{_x call bsmrk_fnc_createTeleAction;} forEach _attackingLeaders;