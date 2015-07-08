0 = [] spawn {
	if (isServer) then {
		while {true} do {
			cur_zeus addCuratorEditableObjects [allMissionObjects "all", true];
			sleep 5;
		};
	};
};