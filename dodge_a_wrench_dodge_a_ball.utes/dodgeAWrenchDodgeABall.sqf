// player execVM "dodge_a_wrench_dodge_a_ball.sqf";

bsmrk_standingThrow = {
	
	
};

bsmrk_crouchingThrow = {
	_this playMove "AwopPercMstpSgthWnonDnon_start";
	
};

bsmrk_parseThrow = {
	switch (stance _this) do {
		case "STAND": {_this call bsmrk_standingThrow};
		case "CROUCH":{_this call bsmrk_crouchingThrow};
	};
};

//display eventhandlers for keydown and keyup

0 = player spawn {
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
	_ball setPos _pos;
	_ball setMass 1000;
	_ball setVelocity _vectorM;
	
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










