private ["_overall"];
_overall = _this;

_cur = createVehicle ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
_cur setVehicleVarName "cur_defender";
"cur_defender" = _cur;

cur_defender addCuratorEditingArea [1, (getMarkerPos "mrk_defenseZone"), bsmrk_param_zoneRadiusP * 2];
_overall assignCurator cur_defender;