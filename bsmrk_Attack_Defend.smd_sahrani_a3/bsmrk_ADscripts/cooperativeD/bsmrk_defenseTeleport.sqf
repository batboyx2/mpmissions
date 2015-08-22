private ["_defenders","_defendingUnits","_defendingLeaders"];
_defenders = _this;
_defendingUnits = [];
_defendingLeaders = [];

{
	if (_x == 1) then {_defenders = _defenders - [_x]; _defenders = _defenders + ["EAST"]};
	if (_x == 2) then {_defenders = _defenders - [_x]; _defenders = _defenders + ["WEST"]};
	if (_x == 3) then {_defenders = _defenders - [_x]; _defenders = _defenders + ["GUER"]};
} forEach _defenders;

{
	if ((str (side _x)) in _defenders) then {
		_defendingUnits = _defendingUnits + [_x];
	};
} forEach allUnits;

{
	if ((leader (group _x)) == _x) then {
		_defendingLeaders = _defendingLeaders + [_x];
	};
} forEach _defendingUnits;

{
	[[[_x], "bsmrk_ADscripts\cooperativeD\bsmrk_defenseTeleportLOCF.sqf"], "BIS_fnc_execVM", _x] call BIS_fnc_MP;
} forEach _defendingLeaders;