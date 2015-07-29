waitUntil {time > 1};

setTerrainGrid 50;
if !(isDedicated) then {
	bsmrk_forceRagdoll = {
		_hit = "Land_Can_V3_F" createVehicleLocal [0,0,0];
		_hit setMass 10000000000;
		_hit attachTo [_this, [0,0,0], "Spine3"];
		_hit setVelocity [0,0,30];
		detach _hit;
		deleteVehicle _hit;
		
		1;
	};

	bsmrk_handleDamage = {
		_unit = _this select 0;
		_selectionName = _this select 1;
		_damage = _this select 2;
		_source = _this select 3;
		_projectile = _this select 4;
		
		systemChat format["You got got, %1.", (name _unit)];
		_this spawn bsmrk_forceRagdoll;
		
	};
	player addEventHandler ["HandleDamage", {_this spawn bsmrk_handleDamage}];

	player setVariable ["bsmrk_hasDodgeBall", false, true];
};

if (isServer) then {
	[] execVM "dodgeAWrenchDodgeABall.sqf";
};

if (!isDedicated) then {
	waitUntil {!isNull (findDisplay 46)};
	(findDisplay 46) displayAddEventHandler [
		"KeyDown",
		{
			if (((_this select 1) in (actionKeys "Throw")) && (player getVariable "bsmrk_hasDodgeBall")) then {
				//player spawn bsmrk_parseThrow; //don't call me, because I will yell at you if you put me on hold
				[
					player,
					"bsmrk_parseThrow",
					false,
					false,
					false
				] call BIS_fnc_MP;
				true
			};
		}
	];  
};