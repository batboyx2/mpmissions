//This script updates the player and victim lists and cleans up unitless groups

if (!isServer) exitWith {};
waitUntil {!isNil "CLY_deadcharacters"};

while {true} do {
	//Build player array
	CLY_zombievictims=[];
	if (isMultiplayer) then {
		CLY_players=playableUnits;
		if (count CLY_players==0) then {CLY_players=allUnits};
		{
			if (!isPlayer _x or !isNil {_x getVariable "spectating"} or typeOf _x in CLY_deadcharacters) then {
				CLY_players=CLY_players-[_x];
			};
		} forEach CLY_players;
	} else {
		CLY_players=[player];
	};
	
	//Dog
	if (!isNil "germanshepherd") then {
		if (alive germanshepherd and isNil {germanshepherd getVariable "victim"} and isNil {germanshepherd getVariable "spectating"}) then {
			CLY_players set [count CLY_players,germanshepherd];
			CLY_players=CLY_players-[germanshepherdhuman];
			CLY_zombievictims set [count CLY_zombievictims,germanshepherd];
		};
	};
	
	publicVariable "CLY_players";
	
	//Determine viable zombie victims
	if (!CLY_cutscene) then {
		{
			if (alive _x and _x isKindOf "Man" and typeOf _x!="ValentinaVictim" and !(vehicle _x isKindOf "Air" and getPos vehicle _x select 2>10) and isNil {_x getVariable "victim"} and isNil {_x getVariable "spectating"}) then {
				CLY_zombievictims set [count CLY_zombievictims,_x];
			};
		} forEach allUnits;
	};
	
	//Delete unused groups
	{if (count units _x==0) then {deleteGroup _x}} forEach allGroups;
	
	sleep 1;
};