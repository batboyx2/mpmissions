if (bsmrk_param_gameTypeP == 1) then {
	[] execVM "bsmrk_ADscripts\adversarial\bsmrk_advInit.sqf";
};

if (bsmrk_param_gameTypeP == 2) then {
	[] execVM "bsmrk_ADscripts\cooperativeD\bsmrk_coopdefInit.sqf";
};

if (bsmrk_param_gameTypeP == 3) then {
	[] execVM "bsmrk_ADscripts\cooperativeA\bsmrk_coopattInit.sqf";
};