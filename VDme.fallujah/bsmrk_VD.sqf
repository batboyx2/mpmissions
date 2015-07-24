// Script by Bismarck
// 
private ["_targetFPS","_targetDeviation","_objectPercentage","_minimumVD","_currentVD"];

_targetFPS = 45;
_targetDeviation = 5;
_objectPercentage = 0.75;
_minimumVD = 2000;
_currentVD = _minimumVD;

setViewDistance _currentVD;
setObjectViewDistance (_currentVD * _objectPercentage);
GV_FPS = _targetFPS;
_targetFPS spawn {
	private ["_fpsArray"];
	_fpsArray = [_this,_this,_this];
	while {true} do {
		_fps1 = diag_fps;
		if (!isNil "_fps2") then {_fpsArray = _fpsArray - [_fps2]; _fpsArray = _fpsArray + [_fps1];} else {_fpsArray = _fpsArray - [_this]; _fpsArray = _fpsArray + [_fps1];};
		GV_FPS = _fpsArray call BIS_fnc_arithmeticMean;
		publicVariable "GV_FPS";
		
		sleep 3;
		
		_fps2 = diag_fps;
		if (!isNil "_fps3") then {_fpsArray = _fpsArray - [_fps3]; _fpsArray = _fpsArray + [_fps2];} else {_fpsArray = _fpsArray - [_this]; _fpsArray = _fpsArray + [_fps2];};
		GV_FPS = _fpsArray call BIS_fnc_arithmeticMean;
		publicVariable "GV_FPS";
		
		sleep 3;
		
		_fps3 = diag_fps;
		if (!isNil "_fps1") then {_fpsArray = _fpsArray - [_fps1]; _fpsArray = _fpsArray + [_fps3];} else {_fpsArray = _fpsArray - [_this]; _fpsArray = _fpsArray + [_fps3];};
		GV_FPS = _fpsArray call BIS_fnc_arithmeticMean;
		publicVariable "GV_FPS";
		
		sleep 3;
	};
};
while {true} do {
	if (GV_FPS > (_targetFPS + _targetDeviation)) then {
		_currentVD = _currentVD + 5;
	};
	if (GV_FPS < (_targetFPS - _targetDeviation)) then {
		_currentVD = _currentVD - 5;
		if (_currentVD < (_minimumVD + 0.1)) then {_currentVD = _minimumVD};
	};
	setViewDistance _currentVD;
	setObjectViewDistance (_currentVD * _objectPercentage);
	systemChat format["%1 | %2",_currentVD,diag_fps];
	sleep 0.1;
};