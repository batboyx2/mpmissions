// ========================================================
// This block changes the sides from numbers to side format variables
bsmrk_fnc_switchTypeSide = {
	_var = _this;
	switch (_var) do {
		case 1: {missionNamespace setVariable [_var, east];};
		case 2: {missionNamespace setVariable [_var, west];};
		case 3: {missionNamespace setVariable [_var, resistance];};
	};
};

{_x call bsmrk_fnc_switchTypeSide} forEach [bsmrk_param_attackingSide1P, bsmrk_param_attackingSide2P, bsmrk_param_defendingSide1P, bsmrk_param_defendingSide2P];

// ========================================================
// This block finds which sides are defending and attacking
private ["_attackers","_defenders","_westLeader","_eastLeader","_indLeader"];
_attackers = [];
_attackers = _attackers + [bsmrk_param_attackingSide1P];
if !(bsmrk_param_attackingSide2P in _attackers) then {
	_attackers = _attackers + [bsmrk_param_attackingSide2P];
};

_defenders = [];
_defenders = _defenders + [bsmrk_param_defendingSide1P];
if !(bsmrk_param_defendingSide2P in _defenders) then {
	_defenders = _defenders + [bsmrk_param_defendingSide2P];
};

// ========================================================
// This spawns the gear on the units
[] execVM "bsmrk_ADscripts\gear\bsmrk_gear.sqf";

// ========================================================
// This block defines the defender's overall leader.
_westLeader = "UnitNATO_PLT";
_eastLeader = "UnitOPFOR_PLT";
_indLeader = "UnitIND_PLT";

_defenderLeader = switch (_defenders select 0) do {
	case west: {"UnitNATO_PLT"};
	case east: {"UnitOPFOR_PLT"};
	case resistance: {"UnitIND_PLT"};
};

globalVarDebug = [_defenderLeader, _attackers, _defenders];
publicVariable "globalVarDebug";

