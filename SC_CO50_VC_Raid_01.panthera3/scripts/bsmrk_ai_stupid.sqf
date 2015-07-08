0 = [] spawn {
	waitUntil {time > 90};
	{
		if (side _x == WEST) then {
			_x setSkill ["aimingAccuracy",0];
			_x setSkill ["aimingShake",0];
			_x setSkill ["aimingSpeed",0.5];
			_x setSkill ["endurance",1];
			_x setSkill ["spotDistance",0.1];
			_x setSkill ["spotTime",0.1];
			_x setSkill ["reloadSpeed",0];
			_x setSkill ["commanding",0];
		};
	} forEach allUnits;
};