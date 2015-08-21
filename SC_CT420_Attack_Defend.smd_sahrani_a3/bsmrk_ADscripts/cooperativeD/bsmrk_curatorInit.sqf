private ["_overall"];
_overall = _this;

_curCenter = createCenter sideLogic;
_curGroup = createGroup sideLogic;
_cur = _curGroup createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
_cur setVehicleVarName "cur_defender";
cur_defender = _cur;

cur_defender addCuratorEditingArea [1, (getMarkerPos "mrk_defenseZone"), bsmrk_param_zoneRadiusP * 2];
cur_defender setCuratorEditingAreaType true;
cur_defender addCuratorPoints 1;
waitUntil {(_overall distance (getMarkerPos "mrk_defenseZone")) < (bsmrk_param_zoneRadiusP * 2)}; //wait until commander is @ zone
cur_defender addCuratorAddons [
	"A3_Structures_F_Mil_BagBunker",
	"A3_Structures_F_Mil_BagFence",
	"A3_Structures_F_Mil_Cargo",
	"A3_Structures_F_Mil_Fortification"
];

[
	cur_defender,
	{
		_classes = _this select 1;
		_changedCosts = [
			["Land_BagBunker_Large_F", [true, 0.1]],
			["Land_BagBunker_Small_F", [true, 0.025]],
			["Land_BagBunker_Tower_F", [true, 0.05]],
			["Land_BagFence_Long_F", [true, 0.01]],
			["Land_BagFence_Round_F", [true, 0.01]],
			["Land_Cargo_House_V1_F", [true, 0.075]],
			["Land_Cargo_HQ_V1_F", [true, 0.125]],
			["Land_Cargo_Patrol_V1_F", [true, 0.15]],
			["Land_Cargo_Tower_V1_F", [true, 0.175]],
			["Land_HBarrier_1_F", [true, 0.01]],
			["Land_HBarrier_3_F", [true, 0.03]],
			["Land_HBarrier_5_F", [true, 0.05]],
			["Land_HBarrierBig_F", [true, 0.075]],
			["Land_HBarrierWall4_F", [true, 0.04]],
			["Land_HBarrierWall6_F", [true, 0.06]],
			["Land_Razorwire_F", [true, 0.025]]
		];
		_classesNew = [];
		{
			_classesNew = _classesNew + [toLower _x];
		} forEach _classes;
		
		{
			_classesNew set [_classesNew find (toLower (_x select 0)), _x select 1];
		} forEach _changedCosts;
		
		{
			if ((typeName _x) == "STRING") then {
				_classesNew set [_classesNew find (toLower _x), [false, 0, 0]];
			};
		} forEach _classesNew;
		
		_classesNew
	}
] call BIS_fnc_curatorObjectRegistered;

_overall assignCurator cur_defender;

//openCuratorInterface;
[
	{openCuratorInterface},
	"BIS_fnc_spawn",
	_overall
] call BIS_fnc_MP;



waitUntil {(!isNil "PABST_ADMIN_SAFESTART_public_isSafe" && {!PABST_ADMIN_SAFESTART_public_isSafe})};

//closeCuratorInterface;
[
	{findDisplay 312 closeDisplay 2;},
	"BIS_fnc_spawn",
	_overall
] call BIS_fnc_MP;
unassignCurator cur_defender;
