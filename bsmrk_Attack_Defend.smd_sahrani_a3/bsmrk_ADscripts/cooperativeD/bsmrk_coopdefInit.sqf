// ========================================================
// This block finds which sides are defending and attacking
waitUntil {time > 1};
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
// This script establishes the side relations such that they make sense based upon the currently defending and attacking sides.
[] execVM "bsmrk_ADscripts\cooperativeD\bsmrk_sideRelations.sqf";

// ========================================================
// This block defines the defender's overall leader.
_defenderLeader = switch (_defenders select 0) do {
	case 1: {if !(isNil "UnitOPFOR_PLT") then {UnitOPFOR_PLT} else {UnitOPFOR_ASL_SL}};
	case 2: {if !(isNil "UnitNATO_PLT") then {UnitNATO_PLT} else {UnitNATO_ASL_SL}};
	case 3: {if !(isNil "UnitIND_PLT") then {UnitIND_PLT} else {UnitIND_ASL_SL}};
};

// ========================================================
// This script allows the defense leader to choose the primary weaponry for his team.
[[[_defenderLeader], "bsmrk_ADscripts\cooperativeD\bsmrk_weaponrySelector.sqf"], "BIS_fnc_execVM", _defenderLeader] call BIS_fnc_MP;
waitUntil {!isNil "gv_confirmedWeapons"};
waitUntil {gv_confirmedWeapons};
// ========================================================
// This script gives the defender's leader an action menu option to pick a starting point
[[[_defenderLeader], "bsmrk_ADscripts\cooperativeD\bsmrk_coopdefZones.sqf"], "BIS_fnc_execVM", _defenderLeader] call BIS_fnc_MP;
waitUntil {!isNil "gv_confirmedMarker"};
waitUntil {gv_confirmedMarker};

// ========================================================
// This script finds all of the leaders on the defending team(s) and then gives them the teleportation action.
_defenders execVM "bsmrk_ADscripts\cooperativeD\bsmrk_defenseTeleport.sqf";
// ========================================================
// This script initializes the object placement system for the defending side's overall commander
_defenderLeader execVM "bsmrk_ADscripts\cooperativeD\bsmrk_curatorInit.sqf";

waitUntil {(!isNil "PABST_ADMIN_SAFESTART_public_isSafe" && {!PABST_ADMIN_SAFESTART_public_isSafe})};

if !(isDedicated) then {
	[] execVM "bsmrk_ADscripts\cooperativeD\bsmrk_coopdefAI.sqf";
} else {
	[[[], "bsmrk_ADscripts\cooperativeD\bsmrk_coopdefAI.sqf"], "BIS_fnc_execVM", HC] call BIS_fnc_MP;
};






