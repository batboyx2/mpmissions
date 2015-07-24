private ["_overall"];
_overall = _this;

_curCenter = createCenter sideLogic;
_curGroup = createGroup sideLogic;
_cur = _curGroup createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
_cur setVehicleVarName "cur_defender";
cur_defender = _cur;

cur_defender addCuratorEditingArea [1, (getMarkerPos "mrk_defenseZone"), bsmrk_param_zoneRadiusP];
cur_defender setCuratorEditingAreaType true;
cur_defender addCuratorPoints 1;
waitUntil {(_overall distance (getMarkerPos "mrk_defenseZone")) < (bsmrk_param_zoneRadiusP * 2)}; //wait until commander is @ zone
cur_defender addCuratorAddons [
	"A3_Structures_F_Mil_BagBunker",
	"A3_Structures_F_Mil_BagFence",
	"A3_Structures_F_Mil_Cargo",
	"A3_Structures_F_Mil_Fortification"
];
/*
cur_defender addMPEventHandler [
	"CuratorObjectRegistered",
	{
		_classes = _this select 1;
		_costs = [
			[true, 0.1], //Land_BagBunker_Large_F
			[true, 0.025], //Land_BagBunker_Small_F
			[true, 0.05], //Land_BagBunker_Tower_F
			
			[false, 0], //Land_BagFence_Corner_F
			[false, 0], //Land_BagFence_End_F
			[true, 0.01], //Land_BagFence_Long_F
			[true, 0.01], //Land_BagFence_Round_F
			[false, 0], //Land_BagFence_Short_F
			
			[false, 0], //Land_Cargo_House_V1_ruins_F
			[true, 0.075], //Land_Cargo_House_V1_F
			[false, 0], //Land_Cargo_House_V2_ruins_F
			[false, 0], //Land_Cargo_House_V2_F
			[false, 0], //Land_Cargo_House_V3_ruins_F
			[false, 0], //Land_Cargo_House_V3_F
			[false, 0], //Land_Cargo_HQ_V1_ruins_F
			[true, 0.125], //Land_Cargo_HQ_V1_F
			[false, 0], //Land_Cargo_HQ_V2_ruins_F
			[false, 0], //Land_Cargo_HQ_V2_F
			[false, 0], //Land_Cargo_HQ_V3_ruins_F
			[false, 0], //Land_Cargo_HQ_V3_F
			[false, 0], //Land_Cargo_Patrol_V1_ruins_F
			[true, 0.15], //Land_Cargo_Patrol_V1_F
			[false, 0], //Land_Cargo_Patrol_V2_ruins_F
			[false, 0], //Land_Cargo_Patrol_V2_F
			[false, 0], //Land_Cargo_Patrol_V3_ruins_F
			[false, 0], //Land_Cargo_Patrol_V3_F
			[false, 0], //Land_Cargo_Tower_V1_ruins_F
			[true, 0.175], //Land_Cargo_Tower_V1_F
			[false, 0], //Land_Cargo_Tower_V1_No1_F
			[false, 0], //Land_Cargo_Tower_V1_No2_F
			[false, 0], //Land_Cargo_Tower_V1_No3_F
			[false, 0], //Land_Cargo_Tower_V1_No4_F
			[false, 0], //Land_Cargo_Tower_V1_No5_F
			[false, 0], //Land_Cargo_Tower_V1_No6_F
			[false, 0], //Land_Cargo_Tower_V1_No7_F
			[false, 0], //Land_Cargo_Tower_V2_ruins_F
			[false, 0], //Land_Cargo_Tower_V2_F
			[false, 0], //Land_Cargo_Tower_V3_ruins_F
			[false, 0], //Land_Cargo_Tower_V3_F
			[false, 0], //Land_Medevac_house_V1_ruins_F
			[false, 0], //Land_Medevac_house_V1_F
			[false, 0], //Land_Medevac_HQ_V1_ruins_F
			[false, 0], //Land_Medevac_HQ_V1_F
			
			[true, 0.01], //Land_HBarrier_1_F
			[true, 0.03], //Land_HBarrier_3_F
			[true, 0.05], //Land_HBarrier_5_F
			[true, 0.075], //Land_HBarrierBig_F
			[false, 0], //Land_HBarrierTower_F
			[false, 0], //Land_HBarrierWall_corner_F
			[false, 0], //Land_HBarrierWall_corridor_F
			[true, 0.04], //Land_HBarrierWall4_F
			[true, 0.06], //Land_HBarrierWall6_F
			[true, 0.025] //Land_Razorwire_F
		];
		_costs
	}
];
*/
[cur_defender, 
	{
		_classes = _this select 1;
		_costs = [
			[true, 0.1], //Land_BagBunker_Large_F
			[true, 0.025], //Land_BagBunker_Small_F
			[true, 0.05], //Land_BagBunker_Tower_F
			
			[false, 0], //Land_BagFence_Corner_F
			[false, 0], //Land_BagFence_End_F
			[true, 0.01], //Land_BagFence_Long_F
			[true, 0.01], //Land_BagFence_Round_F
			[false, 0], //Land_BagFence_Short_F
			
			[false, 0], //Land_Cargo_House_V1_ruins_F
			[true, 0.075], //Land_Cargo_House_V1_F
			[false, 0], //Land_Cargo_House_V2_ruins_F
			[false, 0], //Land_Cargo_House_V2_F
			[false, 0], //Land_Cargo_House_V3_ruins_F
			[false, 0], //Land_Cargo_House_V3_F
			[false, 0], //Land_Cargo_HQ_V1_ruins_F
			[true, 0.125], //Land_Cargo_HQ_V1_F
			[false, 0], //Land_Cargo_HQ_V2_ruins_F
			[false, 0], //Land_Cargo_HQ_V2_F
			[false, 0], //Land_Cargo_HQ_V3_ruins_F
			[false, 0], //Land_Cargo_HQ_V3_F
			[false, 0], //Land_Cargo_Patrol_V1_ruins_F
			[true, 0.15], //Land_Cargo_Patrol_V1_F
			[false, 0], //Land_Cargo_Patrol_V2_ruins_F
			[false, 0], //Land_Cargo_Patrol_V2_F
			[false, 0], //Land_Cargo_Patrol_V3_ruins_F
			[false, 0], //Land_Cargo_Patrol_V3_F
			[false, 0], //Land_Cargo_Tower_V1_ruins_F
			[true, 0.175], //Land_Cargo_Tower_V1_F
			[false, 0], //Land_Cargo_Tower_V1_No1_F
			[false, 0], //Land_Cargo_Tower_V1_No2_F
			[false, 0], //Land_Cargo_Tower_V1_No3_F
			[false, 0], //Land_Cargo_Tower_V1_No4_F
			[false, 0], //Land_Cargo_Tower_V1_No5_F
			[false, 0], //Land_Cargo_Tower_V1_No6_F
			[false, 0], //Land_Cargo_Tower_V1_No7_F
			[false, 0], //Land_Cargo_Tower_V2_ruins_F
			[false, 0], //Land_Cargo_Tower_V2_F
			[false, 0], //Land_Cargo_Tower_V3_ruins_F
			[false, 0], //Land_Cargo_Tower_V3_F
			[false, 0], //Land_Medevac_house_V1_ruins_F
			[false, 0], //Land_Medevac_house_V1_F
			[false, 0], //Land_Medevac_HQ_V1_ruins_F
			[false, 0], //Land_Medevac_HQ_V1_F
			
			[true, 0.01], //Land_HBarrier_1_F
			[true, 0.03], //Land_HBarrier_3_F
			[true, 0.05], //Land_HBarrier_5_F
			[true, 0.075], //Land_HBarrierBig_F
			[false, 0], //Land_HBarrierTower_F
			[false, 0], //Land_HBarrierWall_corner_F
			[false, 0], //Land_HBarrierWall_corridor_F
			[true, 0.04], //Land_HBarrierWall4_F
			[true, 0.06], //Land_HBarrierWall6_F
			[true, 0.025] //Land_Razorwire_F
		];
		_costs
	}
] call BIS_fnc_curatorObjectRegistered;

_overall assignCurator cur_defender;



[format["%1, press your Zeus key and place defenses and/or vehicles. You have three minutes.", name _overall], "systemChat", _overall] call BIS_fnc_MP;
_time = time;
waitUntil {time > (_time + 180)};