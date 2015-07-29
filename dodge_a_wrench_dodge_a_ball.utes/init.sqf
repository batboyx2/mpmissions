waitUntil {time > 1};
player setVariable ["bsmrk_hasDodgeBall", false, true];

if (isServer) then {
	[] execVM "dodgeAWrenchDodgeABall.sqf";
};

if (!isDedicated) then {
	waitUntil {!isNull (findDisplay 46)};
	(findDisplay 46) displayAddEventHandler [
		"KeyDown",
		{
			if (((_this select 1) in (actionKeys "Throw")) && (player getVariable "bsmrk_hasDodgeBall")) then {
				player spawn bsmrk_parseThrow; //don't call me, because I will yell at you if you put me on hold
				diag_log format["%1 call bsmrk_parseThrow", player];
				true
			};
		}
	];  
};