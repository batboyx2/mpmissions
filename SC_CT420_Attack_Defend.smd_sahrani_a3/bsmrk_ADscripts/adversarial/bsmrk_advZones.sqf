// ========================================================
// These functions serve to add the option to create a defense zone to a defender leader &
// process those requests
bsmrk_fnc_createMarker = {
	_pos = _this;
	
	_mrk2 = createMarker ["mrk_bufferZone", _pos];
	_mrk2 setMarkerShape "ELLIPSE";
	_mrk2 setMarkerSize [bsmrk_param_zoneRadiusP * 3, bsmrk_param_zoneRadiusP * 3];
	_mrk2 setMarkerColor "ColorRed";
	
	_mrk1 = createMarker ["mrk_defenseZone", _pos];
	_mrk1 setMarkerShape "ELLIPSE";
	_mrk1 setMarkerSize [bsmrk_param_zoneRadiusP * 2, bsmrk_param_zoneRadiusP * 2];
	_mrk1 setMarkerColor "ColorBlue";
	
};

bsmrk_fnc_createDefenseZone = {
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	if (_target == _caller) then {
		[[_target, _id], "removeAction", _target] call BIS_fnc_MP;
		[format["%1, please open your map and left-click the area you wish to defend.", name _target], "systemChat", _target] call BIS_fnc_MP;
		onSingleMapClick {_pos call bsmrk_fnc_createMarker};
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

_this call bsmrk_fnc_createZoneAction;