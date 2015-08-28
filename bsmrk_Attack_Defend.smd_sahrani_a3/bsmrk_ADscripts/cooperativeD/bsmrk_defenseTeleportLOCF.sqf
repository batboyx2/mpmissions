bsmrk_fnc_doTeleportUpper = {
	private ["_time","_pos","_target","_units"];
	_time = time;
	_pos = _this select 0;
	_target = _this select 1;
	_units = units (group _target);
	
	{
		_x allowDamage false;
		_x setPos _pos;
	} forEach _units;
	gv_teleported = true;
	waitUntil {time > _time + 10};
	{
		_x allowDamage true;
	} forEach _units;
};

bsmrk_fnc_doTeleport = {
	private ["_id2","_id3"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	if (_target == _caller) then {
		[[_target, _id], "removeAction", _target] call BIS_fnc_MP;
		[format["%1, left-click the point you wish to teleport your group to.", name _target], "systemChat", _target] call BIS_fnc_MP;
		openMap true;
		_target onMapSingleClick {[_pos, _this] spawn bsmrk_fnc_doTeleportUpper};
		gv_teleported = false;
		waitUntil {gv_teleported};
		openMap false;
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

(_this select 0) call bsmrk_fnc_createTeleAction;