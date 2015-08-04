_characters=["CDF_Soldier_Officer","CDF_Soldier"];
_colors=["ColorGreen","ColorYellow"];

waitUntil {!isNil "CLY_players"};

sleep 1;

_markers=[];
for "_x" from 1 to 30 do {
	_marker=createMarkerLocal [format ["pmarker%1",_x],[0,0,0]];
	_marker setMarkerTypeLocal "mil_triangle";
	_marker setMarkerSizeLocal [0.3,0.6];
	_marker setMarkerAlphaLocal 0;
	_markers set [count _markers,_marker];
};

while {true} do {
	{
		_x setMarkerTextLocal "";
		_x setMarkerAlphaLocal 0;
	} forEach _markers;
	if ("ItemGPS" in items player) then {
		{
			_unit=_x;
			_marker=_markers select (CLY_players find _unit);
			_marker setMarkerPosLocal getPos vehicle _unit;
			_marker setMarkerDirLocal getDir vehicle _unit;
			_marker setMarkerColorLocal (if (typeOf _unit in _characters) then {_colors select (_characters find typeOf _unit)} else {"ColorOrange"});
			if (isMultiplayer and (_unit==driver vehicle _unit or {_x in vehicle _unit} count CLY_players==1)) then {_marker setMarkerTextLocal name _x};
			_marker setMarkerAlphaLocal 1;
		} forEach CLY_players;
	};
	sleep 0.5;
};