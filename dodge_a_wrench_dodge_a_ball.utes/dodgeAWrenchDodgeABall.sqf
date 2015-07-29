// player execVM "dodge_a_wrench_dodge_a_ball.sqf"; <<DEFUNCT

bsmrk_standingThrow = {
	_this playMove "AwopPercMstpSgthWnonDnon_start";
	_ball = _this getVariable "bsmrk_whichDodgeball";
	_time = time;
	
	_vectorN = ([(positionCameraToWorld [0,0,0]), (positionCameraToWorld [0,0,1])] call BIS_fnc_vectorDiff);
	_vectorM = _vectorN vectorMultiply 75;
	
	waitUntil {time > (_time + 1.17)};
	_pos = getPos _ball;
	detach _ball;
	_hitter = createVehicle ["B_45ACP_Ball", [0,0,1], [], 0, "NONE"];
	_hitter setPos _pos;
	_hitter setVelocity _vectorM;
	_ball setPos _pos;
	_ball setVelocity _vectorM;
};

bsmrk_crouchingThrow = {
	//to be defined like standing throws
};

// player call bsmrk_parseThrow;
bsmrk_parseThrow = {
	_player = _this;
	_player setVariable ["bsmrk_hasDodgeBall", false, true];
	switch (stance _player) do {
		case "STAND": {_player call bsmrk_standingThrow};
		case "CROUCH":{_player call bsmrk_crouchingThrow};
	};
};

// non-callable by outside forces
bsmrk_pickupAndHold = {
	_ball = _this select 0;
	_player = _this select 1;
	_ID = _this select 2;
	[
		[
			_ball,
			_ID
		],
		"removeAction",
		true,
		false,
		false
	] call BIS_fnc_MP;
	_ball attachTo [_player, [0,0,0], "RightHand"];
	_player setVariable ["bsmrk_hasDodgeBall", true, true];
	_player setVariable ["bsmrk_whichDodgeball", _ball, true];
	
};

// [x,y,z] call bsmrk_createBallGround;
bsmrk_createBallGround = {
	private ["_ball"];
	_pos = _this;
	_ball = createVehicle ["Land_Basketball_01_F", [0,0,0], [], 0, "NONE"];
	_ball setPos _pos;
	[
		[
			_ball,
			[
				"Pickup Ball",
				bsmrk_pickupAndHold,
				nil,
				100,
				true,
				true
			]
		],
		"addAction",
		true,
		false,
		false
	] call BIS_fnc_MP;
};

{(getMarkerPos _x) call bsmrk_createBallGround} forEach ["mrk_ball", "mrk_ball_1", "mrk_ball_2"];

//display eventhandlers for keydown and keyup

//old stuff below, backups incase I want to use it again


/*
0 = (unit_1) spawn {
	_ball = createVehicle ["Land_Basketball_01_F", [0,0,0], [], 0, "NONE"];
	_ball attachTo [_this, [0,0,0], "RightHand"];
	sleep 2;
	_this playMove "AwopPercMstpSgthWnonDnon_start";
	_time = time;
	
	_vectorN = ([(positionCameraToWorld [0,0,0]), (positionCameraToWorld [0,0,1])] call BIS_fnc_vectorDiff);
	_vectorM = _vectorN vectorMultiply 75;
	
	waitUntil {time > (_time + 1.17)};
	_pos = getPos _ball;
	detach _ball;
	_hitter = createVehicle ["B_45ACP_Ball", [0,0,1], [], 0, "NONE"];
	_hitter setPos _pos;
	_hitter setVelocity _vectorM;
	_ball setPos _pos;
	_ball setVelocity _vectorM;
	_ball addAction ["Pickup Ball", {}];
};




onEachFrame {
	_center = positionCameraToWorld [0,0,3];
	drawIcon3D [
		"",
		[1,0,0,1],
		_center,
		0,
		0,
		0,
		"o",
		2,
		0.1,
		"PuristaMedium"
	];
};





waitUntil {(_ball distance player) > 1.5};
waitUntil {(count (nearestObjects [(getPos _ball), ["man"], 1.5]) > 0) || ((speed _ball) < 5)};
if (count (nearestObjects [(getPos _ball), ["man"], 1.5]) > 0) then {
	_mang = (nearestObjects [(getPos _ball), ["man"], 1.5]) select 0;
	_rag = createVehicle ["Land_Can_V3_F", [0,0,0], [], 0, "NONE"];
	diag_log "yup";
	_rag setMass 1e10;
	_mang allowDamage false;
	_rag attachTo [_mang, [0,0,0], "Spine3"];
	_rag setVelocity [0,0,15];
	detach _rag;
	0 = [_rag, _mang] spawn {
		deleteVehicle (_this select 0);
		(_this select 1) allowDamage true;
	};
};
*/









