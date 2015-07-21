if (bsmrk_param_gameType == 1) then {
	[] execVM "bsmrk_advInit.sqf";
};

if (bsmrk_param_gameType == 2) then {
	[] execVM "bsmrk_coopdefInit.sqf";
};

if (bsmrk_param_gameType == 3) then {
	[] execVM "bsmrk_coopattInit.sqf";
};