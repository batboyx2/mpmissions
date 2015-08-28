// ========================================================
// These functions serve to add the option to create a defense zone to a defender leader &
// process those requests
gv_confirmedMarker = false; publicVariable "gv_confirmedMarker";
bsmrk_fnc_createMarker = {
	_pos = _this;
	
	_mrk2 = createMarker ["mrk_bufferZone", _pos];
	missionNamespace setVariable ["mrk_bufferZone",_mrk2];
	_mrk2 setMarkerShape "ELLIPSE";
	_mrk2 setMarkerSize [bsmrk_param_zoneRadiusP * 4, bsmrk_param_zoneRadiusP * 4];
	_mrk2 setMarkerColor "ColorRed";
	
	_mrk1 = createMarker ["mrk_defenseZone", _pos];
	missionNamespace setVariable ["mrk_defenseZone",_mrk1];
	_mrk1 setMarkerShape "ELLIPSE";
	_mrk1 setMarkerSize [bsmrk_param_zoneRadiusP *2, bsmrk_param_zoneRadiusP * 2];
	_mrk1 setMarkerColor "ColorBlue";
	
};

bsmrk_fnc_createDefenseZone = {
	private ["_id2","_id3"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	if (_target == _caller) then {
		[[_target, _id], "removeAction", _target] call BIS_fnc_MP;
		[format["%1, left-click the area you wish to defend.", name _target], "systemChat", _target] call BIS_fnc_MP;
		openMap true;
		onMapSingleClick {_pos call bsmrk_fnc_createMarker};
		waitUntil {!isNil "mrk_bufferZone"};
		openMap false;
		onMapSingleClick "";
		[format["%1, does this look correct?", name _target], "systemChat", _target] call BIS_fnc_MP;
		
		_id2 = [
			[
				_target,
				[
					"Yes",
					{
						[(_this select 0), "removeAllActions", _this select 0] call BIS_fnc_MP;
						gv_confirmedMarker = true; publicVariable "gv_confirmedMarker";
					},
					nil,
					1.5,
					true,
					true
				]
			],
			"addAction",
			_target
		] call BIS_fnc_MP;
		
		_id3 = [
			[
				_target,
				[
					"No",
					{
						deleteMarker "mrk_bufferZone";
						deleteMarker "mrk_defenseZone";
						missionNamespace setVariable ["mrk_bufferZone", nil];
						missionNamespace setVariable ["mrk_defenseZone", nil];
						[(_this select 0), "removeAllActions", _this select 0] call BIS_fnc_MP;
						(_this select 0) call bsmrk_fnc_createZoneAction;
					},
					nil,
					1.5,
					true,
					true
				]
			],
			"addAction",
			_target
		] call BIS_fnc_MP;
		
	};
};

bsmrk_fnc_createZoneAction = {
	private ["_leader"];
	_leader = _this;
	[
		[
			_leader,
			[
				"Create Zone",
				bsmrk_fnc_createDefenseZone,
				nil,
				1.5,
				true,
				true
			]
		],
		"addAction",
		_leader
	] call BIS_fnc_MP;
};

(_this select 0) call bsmrk_fnc_createZoneAction;