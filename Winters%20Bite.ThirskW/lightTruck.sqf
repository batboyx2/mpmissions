/**************************************************
	BD Light Truck Script
	for V3S Open

parameters:
 <truck>: object
 <light>: object
 <enableActions> : boolean (optional)

call:
 [<truck>,<light>,(<enableActions>)] execVM "lightTruck.sqf"

Attaches a searchlight to the V3S and locks the surrounding
cargo positions when manned. Setting enableActions to false
will disable the actions allowing you to switch to and from
the light while in the truck. Actions are enabled by default.

Note: this script was designed to be used only for the
V3S Open, for other trucks modification is required.
**************************************************/

_truck = _this select 0;
_light = _this select 1;
_actions = true;
if(count _this > 2)then{_actions = _this select 2};

// attach & init variables
_light attachTo [_truck,[0,-0.1,-0.7]];
_truck setVariable ["lightTruck_lightObject",_light];
_light setVariable ["lightTruck_truck",_truck];
_truck setVariable ["lightTruck_lightLocked",false];

// add actions
if(_actions)then{
	_actManCond = {
		_truck = _this select 0;
		_who = _this select 1;
	
		_light = _truck getVariable "lightTruck_lightObject";
	
		_cargoCenter = [0,-1,-0.7];
		_dist = 2;
		_searchDist = 1.2;
		_whoInCargo = call {(_who in crew _truck) && (getPos _who) distance (_truck modelToWorld _cargoCenter) < _dist};
		_lightIsLocked = call {{_X distance _light < _searchDist && (_X != _who)} count (crew _truck) > 0};
		
		((alive _truck) && !(isNull _light) && (isNull (gunner _light)) && (alive _light) && !(_lightIsLocked) && _whoInCargo)
	};

	_actBackCond = {
		_light = _this select 0;
		_who = _this select 1;	

		_truck = _light getVariable "lightTruck_truck";
	
		_freePositions = _truck emptyPositions "Cargo";
		_cabPos = [0.569336,1.82446,-0.35022];
		if(_freePositions == 1 && {(getPos _X) distance _cabPos < 0.05} count (crew _truck) > 0)then{
			_freePositions = 0;
		};

		((gunner _light == _who) && (_freePositions > 0))
	};		

	_truck addAction [
		"Man Searchlight",
		"manLight.sqf",
		[],
		4,
		false,
		true,
		"",
		format ["[_target,_this] call %1",_actManCond]
	];

	_light addAction [
		"To back seat",
		"lightToCargo.sqf",
		[],
		4,
		false,
		true,
		"",
		format ["[_target,_this] call %1",_actBackCond]
	];
};

// add getOut EH
_light addEventHandler ["getOut",{
	_light = _this select 0;
	_who = _this select 2;

	_truck = _light getVariable "lightTruck_truck";

	if(alive _who)then{
		_who setPos (_truck modelToWorld [0.612305,-4.20215,-1.52625]);
		_who setDir (getDir _truck + 180);
		_who switchMove "acrgpknlmstpsnonwnondnon_amovpercmstpsraswrfldnon_getouthigh";
	};
}];

while{alive _truck}do{

	_gunner = gunner _light;

	_searchDist = 1.2;

	if(isNull _gunner)then{

		if({_X distance _light < _searchDist} count (crew _truck) > 0)then{

			_light lockTurret [[0],true];
			_truck setVariable ["lightTruck_lightLocked",true];
		}else{
			_light lockTurret [[0],false];
			_truck setVariable ["lightTruck_lightLocked",false];
		};

		{_truck lockCargo [_X,false]} forEach [1,2,3,4,11,12];

	}else{

		{_truck lockCargo [_X,true]} forEach [1,2,3,4,11,12];
	};

	sleep 0.1;
};

(gunner _light) setDammage 1;
deleteVehicle _light;