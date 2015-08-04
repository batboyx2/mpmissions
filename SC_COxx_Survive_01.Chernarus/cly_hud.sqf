disableSerialization;

sleep 3;

_clawcooldown=0;
_bandagecooldown=0;
_namecooldown=0;
while {true} do {
	_unit=if (!isNil {player getVariable "spectating"}) then {player getVariable "spectating"} else {player};
	waitUntil {!CLY_cutscene};
	if (damage _unit>0.28 and time>_clawcooldown) then {
		3 cutRsc ["clawhud","PLAIN"];
		_ui=uiNamespace getVariable "clawhud";
		_hud=_ui displayCtrl 23500;
		_hud ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.08];
		_claw="";
		if (damage _unit>0.28) then {_claw="claw1.paa"};
		if (damage _unit>0.59) then {_claw="claw2.paa"};
		if (damage _unit>0.9) then {_claw="claw3.paa"};
		_hud ctrlSetText _claw;
		_hud ctrlCommit 0;
		_clawcooldown=time+0.49;
	};
	if (!isNil {_unit getVariable "CLY_healings"} and time>_bandagecooldown) then {
		_bandages=_unit getVariable "CLY_healings";
		if (_bandages>=0) then {
			2 cutRsc ["bandagehud","PLAIN"];
			_ui=uiNamespace getVariable "bandagehud";
			_hud=_ui displayCtrl 23500;
			_hud ctrlSetPosition [safeZoneX+0.06,safeZoneY+safeZoneH-0.02];
			_hud ctrlSetText format ["Bandages: %1",_bandages];
			_hud ctrlCommit 0;
			_bandagecooldown=time+0.45;
		};
	};
	_units=CLY_players-[_unit];
	if (CLY_nametags and count _units>0) then {
		1 cutRsc ["namehud","PLAIN"];
		_ui=uiNamespace getVariable "namehud";
		_i=0;
		{
			_dist=_x distance vehicle _unit;
			if (_dist<10) then {
				_pos=worldToScreen [getPosATL _x select 0,getPosATL _x select 1,(getPosATL _x select 2)+(_x selectionPosition "launcher" select 2)+0.65];
				if (vehicle _x==_x and count _pos>0) then {
					_hud=_ui displayCtrl (23501+_i);
					_hud ctrlSetPosition [(_pos select 0)-0.2,_pos select 1];
					_hud ctrlSetText name _x;
					_hud ctrlSetTextColor [1,0.5,0.5,0.6 min (1-_dist*0.12)];
					_hud ctrlCommit 0;
					_i=_i+1;
				};
			};
		} forEach _units;
	};
	sleep 0.02;
};