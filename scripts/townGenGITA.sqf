//script is a modified version of Karel Moricky's GITA script from A2OA

_center = createCenter sideLogic;
_group = createGroup _center;
_logic = _group createUnit ["Logic", (getMarkerPos "mrk_townville"), [], 0, ""];
_logic setPos (getMarkerPos "mrk_townville");

{_logic setVariable [_x select 0, _x select 1];} forEach 
[
	["random", random 1000],
	["name", "Townville"],
	["townsize", 300],
	["housecount", 35],
	["houserotation", 7],
	["housespacing", 0.9],
	["destroyed", 0],
	["coefMisc",3],
	["debug", true]
];

//--- Town random
_random = if (isnil {_logic getvariable "random"}) then {0} else {_logic getvariable "random"};
if (_random >= 0) then {_random = round ((position _logic select 0) + (position _logic select 1)) + _random};
_random = abs _random;
_logic setvariable ["random",_random,true];
_ran = 1138 + round _random;
_logic setvariable ["ran",_ran,true];

//--- Town name
_townname = if (isnil {_logic getvariable "name"}) then {"genericName"} else {_logic getvariable "name"};
_logic setvariable ["name",_townname,true];

//--- Town size
_townsize = if (isnil {_logic getvariable "townsize"}) then {500} else {_logic getvariable "townsize"};
_logic setvariable ["townsize",_townsize,true];

//--- House count
_housecount = if (isnil {_logic getvariable "housecount"}) then {50} else {_logic getvariable "housecount"};
_logic setvariable ["housecount",_housecount,true];
_logic setvariable ["housecounttemp",_housecount,true];

//--- House rotation
_houserotation = if (isnil {_logic getvariable "houserotation"}) then {7} else {_logic getvariable "houserotation"};
_logic setvariable ["houserotation",_houserotation,true];

//--- House spacing
_housespacing = if (isnil {_logic getvariable "housespacing"}) then {0.9} else {_logic getvariable "housespacing"};
_logic setvariable ["housespacing",_housespacing,true];

//--- Destroy ratio
_destroyed = if (isnil {_logic getvariable "destroyed"}) then {0} else {_logic getvariable "destroyed"};
_logic setvariable ["destroyed",_destroyed,true];

//--- Wall stuff coeficient
_coefWall = if (isnil {_logic getvariable "coefWall"}) then {1.5} else {_logic getvariable "coefWall"};
_logic setvariable ["coefWall",_coefWall,true];

//--- Misc stuff coeficient
_coefMisc = if (isnil {_logic getvariable "coefMisc"}) then {1.5} else {_logic getvariable "coefMisc"};
_logic setvariable ["coefMisc",_coefMisc,true];

//--- Debug almighty
_debug = if (isnil {_logic getvariable "debug"}) then {false} else {_logic getvariable "debug"};
_logic setvariable ["debug",_debug,true];

_houseclassesstartC = [
	"Land_A_Villa_EP1",
	"Land_A_Villa_dam_EP1"
];
_houseclassesstartK = [
	"Land_A_Mosque_big_minaret_2_EP1",
	"Land_A_Mosque_big_minaret_2_dam_EP1",
	"Land_A_Mosque_big_minaret_1_EP1"
];
_houseclassesstartL = [
	"Land_A_Minaret_EP1",
	"Land_A_Minaret_dam_EP1",
	"Land_A_Mosque_small_1_EP1",
	"Land_A_Mosque_small_2_EP1"
];
_houseClassesStartDynamic = _houseclassesStartL;
if (_houseCount >= 25) then {_houseClassesStartDynamic = _houseClassesStartDynamic + _houseclassesStartK};
if (_houseCount >= 50) then {_houseClassesStartDynamic = _houseClassesStartDynamic + _houseclassesStartC};

//--- House classes start
_houseclassesstart = if (isnil {_logic getvariable "houseclassesstart"}) then {_houseClassesStartDynamic} else {_logic getvariable "houseclassesstart"};
_logic setvariable ["houseclassesstart",_houseclassesstart,true];

//--- House classes

//--- City
_houseclassesC = [
	"Land_House_C_1_EP1",
	"Land_House_C_1_dam_EP1",
	"Land_House_C_1_v2_EP1",
	"Land_House_C_1_v2_dam_EP1",
	"Land_House_C_2_EP1",
	"Land_House_C_3_EP1",
	"Land_House_C_3_dam_EP1",
	"Land_House_C_4_EP1",
	"Land_House_C_4_dam_EP1",
	"Land_House_C_5_EP1",
	"Land_House_C_5_dam_EP1",
	"Land_House_C_5_V1_EP1",
	"Land_House_C_5_V1_dam_EP1",
	"Land_House_C_5_V2_EP1",
	"Land_House_C_5_V2_dam_EP1",
	"Land_House_C_5_V3_EP1",
	"Land_House_C_5_V3_dam_EP1",
//	"Land_House_C_9_EP1",
//	"Land_House_C_10_EP1",
	"Land_House_C_11_EP1",
	"Land_House_C_11_dam_EP1"
//	"Land_House_C_12_EP1"
];

//--- Kishlak
_houseclassesK = [
	"Land_House_K_1_EP1",
	"Land_House_K_3_EP1",
	"Land_House_K_3_dam_EP1",
	"Land_House_K_5_EP1",
	"Land_House_K_5_dam_EP1",
	"Land_House_K_6_EP1",
	"Land_House_K_6_dam_EP1",
	"Land_House_K_7_EP1",
	"Land_House_K_7_dam_EP1",
	"Land_House_K_8_EP1",
	"Land_House_K_8_dam_EP1"
];

//--- Low
_houseclassesL = [
	"Land_House_L_1_EP1",
	"Land_House_L_3_EP1",
	"Land_House_L_3_dam_EP1",
	"Land_House_L_4_EP1",
	"Land_House_L_4_dam_EP1",
	"Land_House_L_6_EP1",
	"Land_House_L_6_dam_EP1",
	"Land_House_L_7_EP1",
	"Land_House_L_7_dam_EP1",
	"Land_House_L_8_EP1",
	"Land_House_L_8_dam_EP1"
	//"Land_House_L_9_EP1"
];

_houseClassesDynamic = _houseclassesL;
if (_houseCount >= 25) then {_houseClassesDynamic = _houseClassesDynamic + _houseclassesK};
if (_houseCount >= 75) then {_houseClassesDynamic = _houseClassesDynamic + _houseclassesC};

_houseclasses = if (isnil {_logic getvariable "houseclasses"}) then {_houseClassesDynamic} else {_logic getvariable "houseclasses"};
_logic setvariable ["houseclasses",_houseclasses,true];

//--- Wall classes
_wallclasses = if (isnil {_logic getvariable "wallclasses"}) then {[
	["Wall_FenW2_6_EP1",90,0.8,true],
	["Wall_L3_5m_EP1",90,0.8,false],
	["Wall_L2_5m_EP1",90,0.92,false],
	["Wall_L_2m5_EP1",90,0.65,true],
	["Wall_L1_2m5_EP1",90,0.65,true]
];} else {_logic getvariable "wallclasses"};
_logic setvariable ["wallclasses",_wallclasses,true];

//--- Misc classes
_miscclasses = if (isnil {_logic getvariable "miscclasses"}) then {[
/*
	"Land_Misc_Well_L_EP1",
	"Land_tires_EP1",
	"Land_sunshade_EP1",
	"Land_Misc_Rubble_EP1",
	"Land_Misc_Garb_3_EP1",
	"Land_Misc_Garb_4_EP1",
	"Land_Misc_Garb_Heap_EP1",
	"Land_Misc_Garb_Square_EP1",
	//"Land_Misc_ConcBox_EP1",
	//"Land_Misc_ConcPipeline_EP1",
	"Land_cages_EP1",
	"Land_bags_EP1",
	"Land_bags_stack_EP1",
	"Land_Misc_IronPipes_EP1"
*/
	"Land_Misc_Coil_EP1",
	"Land_Misc_ConcPipeline_EP1",
	"Land_Misc_IronPipes_EP1",
	"Land_Misc_Rubble_EP1",
	"Land_Misc_Rubble_EP1",
	"Land_Misc_Garb_3_EP1",
	"Land_Misc_Garb_4_EP1",
	"Land_Misc_Garb_Heap_EP1",
	"Land_Misc_Garb_Square_EP1",
	"Land_Misc_Well_L_EP1",
	"Land_Misc_Well_C_EP1",
	"Land_Fire",
	"Land_Fire_burning",
	"Land_tires_EP1",
	"Land_bags_EP1",
	"Land_bags_stack_EP1",
	"Land_cages_EP1",
	"Land_sunshade_EP1",
	"Land_transport_cart_EP1",
	"Land_transport_crates_EP1",
	//"Land_transport_kiosk_EP1",
	//"Land_stand_small_EP1",
	"Land_stand_meat_EP1",
	"Land_stand_waterl_EP1",
	"Land_Crates_stack_EP1",
	"Land_Carpet_rack_EP1",
	"Misc_TyreHeapEP1"
];} else {_logic getvariable "miscclasses"};
_logic setvariable ["miscclasses",_miscclasses,true];

//--- Wreck classes
_wreckclasses = if (isnil {_logic getvariable "wreckclasses"}) then {[
	"UralWreck",
	"datsun01Wreck",
	"datsun02Wreck",
	"hiluxWreck",
	"SKODAWreck",
	"LADAWreck"
];} else {_logic getvariable "wreckclasses"};
_logic setvariable ["wreckclasses",_wreckclasses,true];

//--- Animal classes
_animalclasses = if (isnil {_logic getvariable "animalclasses"}) then {[
	"Hen",
	"Cock"
];} else {_logic getvariable "animalclasses"};
_logic setvariable ["animalclasses",_animalclasses,true];





//////////////////////////////////////////////////

_objectsstart = _houseclassesstart;
_objects = _houseclasses;

_logic setvariable ["houseclasses",_objects];
_logic setvariable ["houseclassesstart",_objectsstart];
_logic setvariable ["houselist",[]];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// HOUSES
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_create = {//sleep 0.5;
	private ["_logic","_townsize","_houses","_classes","_classesstart","_rotation","_spacing","_destroyed","_debug","_center","_centersize","_centerdir","_centerdirreverse","_classescount","_housescounttemp","_random","_class","_obj","_objpos","_dir","_bbox","_b1","_b2","_bbx","_bby","_size","_pos","_nearhouses","_nearroads","_nearobjects","_marker","_id","_color"];

	_logic = _this select 0;
	if (_logic getvariable "housecounttemp" > 0) then {
		//debuglog ["Log::::::::::::::::::::::::",_this];

		_townsize = (_logic getvariable "townsize") / 2;
		_houses = _logic getvariable "houselist";
		_classes = _logic getvariable "houseclasses";
		_classesstart = _logic getvariable "houseclassesstart";
		_rotation = _logic getvariable "houserotation";
		_spacing = _logic getvariable "housespacing";
		_destroyed = _logic getvariable "destroyed";
		_debug = _logic getvariable "debug";

		_center = _this select 1;
		_centerpos = if (typename _center == "OBJECT") then {position _center} else {_center};
		_center = if (typename _center == "OBJECT") then {_center} else {objnull};
		_centersize = _this select 2;
		_centerdir = _this select 3;
		//_centerdirreverse = _this select 3;
		//_tier = _this select 4;
		if (_centersize == 0) then {_classes = _classesstart};

		//--- Create building
		_classescount = count _classes;
		_housescounttemp = _logic getvariable "housecounttemp";
		_random = (_logic getvariable "ran") + round (_housescounttemp^1.5);
		_class = _classes select ((_classescount + _random) % _classescount);
		_obj = _class createvehicle [100,100,100];
		_dir = _centerdir;

		//--- Calculate bounding box
		_bbox = boundingbox _obj;
		_b1 = _bbox select 0;
		_b2 = _bbox select 1;
		_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
		_bby = (abs(_b1 select 1) + abs(_b2 select 1));
		//_size = (sqrt(_bbx^2 + _bby^2));
		_size = _obj call bis_fnc_boundingcircle;

		//--- Get position
		_pos = [
			(_centerpos select 0) + (sin _centerdir) * _spacing * ((_centersize + _size) / 2),
			(_centerpos select 1) + (cos _centerdir) * _spacing * ((_centersize + _size) / 2),
			0
		];

		if (_debug) then {
			_marker = createmarkerlocal [format ["line_%1",round random 1000000],[0,0,0]];
			_marker setmarkershapelocal "rectangle";
			_marker setmarkerbrushlocal "solid";
			_marker setmarkercolorlocal "colorblack";	
			//_marker setmarkeralpha 0.2;

			_pos1 = _centerpos;
			_pos2 = _pos;

			_difX = (_pos1 select 0) - (_pos2 select 0) +0.1;
			_difY = (_pos1 select 1) - (_pos2 select 1) +0.1;
			_lx = (_pos2 select 0) + _difX / 2;
			_ly = (_pos2 select 1) + _difY / 2;
			_mdis = sqrt(_difX^2 + _difY^2);
			_mdir = atan (_difX / _difY);
			_marker setmarkerpos [_lx,_ly];
			_marker setmarkersize [0.2,_mdis/2];
			_marker setmarkerdir _mdir;
		};

		//--- Check surrounding
		_nearhouses = (_pos nearobjects ["house",100]) - [_center];
		_nearroadstemp = _pos nearroads 50;
		_nearobjects = {
			_isize = _x call bis_fnc_boundingcircle;
			_x distance _pos <= _spacing * (_isize + _size)/2
		} count _nearhouses;
		_nearroads = {
			_isize = _x call bis_fnc_boundingcircle;
			_x distance _pos <= _spacing * (_isize + _size)/2
		} count _nearroadstemp;

		//--- All clear
		if (_nearobjects == 0 && _nearroads == 0 && _pos distance _logic < _townsize && _logic getvariable "housecounttemp" > 0) then {

			_obj setpos _pos;
			_nearroads = _pos nearroads (_size * 2);//_pos nearroads (_size / 2 + 30);
			_dir = if (count _nearroads > 0) then {
				_road = _nearroads select 0;
				(direction _road) + (-_rotation + ((_housescounttemp % 2)*_rotation));
			} else {
				(_centerdir + ((_random % 4) * 90) + (-_rotation + ((_housescounttemp % 2)*_rotation)));
			};
			//_dir = if ((_housescounttemp % 2) == 0) then {_dir} else {-_dir};

			//--- More mess
			if ((_housescounttemp % 10) == 9) then {
				_dir = _dir + _rotation * (_housescounttemp % 11);

				if (_debug) then {
					_marker = createmarkerlocal [format ["obj_mess_%1",random 10000000000],_pos];
					_marker setmarkertypelocal "mil_warning";
					_marker setmarkercolorlocal "colorred";
				};
			};

			_obj setdir _dir;
			if (random 1 < _destroyed) then {_obj setdamage 1};
			_obj setpos _pos;
			_obj setdir _dir;
			_objpos = position _obj;

			//--- Map marker
			_id = (_logic getvariable "housecount") - (_logic getvariable "housecounttemp");
/*
			_marker = createmarkerlocal [format ["obj_bb_%1",_id + round random 1000000],_objpos];
			_marker setmarkerdir direction _obj;
			_marker setmarkershapelocal "rectangle";
			_marker setmarkersizelocal [_bbx/2,_bby/2];
			_marker setmarkercolor "colorblack";
*/
 
			if (_debug) then {
				//--- Tier colors
				_color = ["colorwhite","coloryellow","colororange","colorpink","colorred","colorblue","colorgreen","colorkhaki","colorbrown","colorblack"] select (_tierN % 10);
				_marker = createmarkerlocal [format ["obj_cc_%1",_id],_objpos];
				_marker setmarkerdirlocal direction _obj;
				_marker setmarkershapelocal "rectangle";
				_marker setmarkersizelocal [_bbx/2,_bby/2];
				_marker setmarkercolorlocal _color;
				_marker = createmarkerlocal [format ["obj_dd_%1",_id+random 10000000000],_objpos];
				_marker setmarkerdir direction _obj;
				_marker setmarkertypelocal "mil_dot";
				_marker setmarkertextlocal format ["%1.%2/%3	",_tierN,_id,_centersize];
				_marker setmarkercolorlocal _color;

				//--- Debug - bounding circle
				_id = _logic getvariable "housecounttemp";
				_marker = createmarkerlocal [format ["obj_%1",_id + round random 1000000],_pos];
				_marker setmarkerdirlocal direction _obj;
				_marker setmarkershapelocal "ellipse";
				_marker setmarkerbrushlocal "border";
				_marker setmarkersizelocal [_bbx/2,_bbx/2];
				_marker setmarkercolor "colorred";
				_marker = createmarkerlocal [format ["obj_%1",_id + round random 1000000],_pos];
				_marker setmarkerdirlocal direction _obj;
				_marker setmarkershapelocal "ellipse";
				_marker setmarkerbrushlocal "border";
				_marker setmarkersizelocal [_bby/2,_bby/2];
				_marker setmarkercolorlocal "colorred";
			};

			//--- Write variables
			_tier = _tier + [_obj];
			[_logic,"housecounttemp",1] call bis_fnc_variablespaceremove;
			[_logic,"houselist",[_obj]] call bis_fnc_variablespaceadd;
			progressLoadingScreen (((_logic getvariable "housecount") - (_logic getvariable "housecounttemp")) / 200);

		} else {

			///--- Failed attempt
			if (_debug) then {
				_marker = createmarkerlocal [format ["failx_%1",round random 1000000],_pos];
				_marker setmarkertypelocal "mil_dot";
				_marker setmarkercolorlocal "colorblack";
				_marker setmarkeralphalocal 0.2;
				//_marker setmarkertext str(_nearhouses);
			};
			deletevehicle _obj;

			if (_nearobjects == 0 && typeof _center != "") then {
				_road = _nearroadstemp select 0;
				_bbox = boundingbox _road;
				_b1 = _bbox select 0;
				_b2 = _bbox select 1;
				_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
				_bby = (abs(_b1 select 1) + abs(_b2 select 1));
				_size = _road call bis_fnc_boundingcircle;
				[_logic,_road,_size,_centerdir] call _create;

				if (_debug) then {
					_marker = createmarkerlocal [format ["failxx_%1",round random 1000000],_pos];
					_marker setmarkertypelocal "mil_dot";
					_marker setmarkercolorlocal "colorpink";
					_marker setmarkeralphalocal 0.5;
				};
			};

			//--- Continue branching in previous directions
			//if (((_random) % 2) > 0.5 || count _nearroads > 0) then {[_pos,_size,_centerdir,_centerdirreverse,_tier] spawn (_logic getvariable "createcode")};
		};
	};
};
_logic setvariable ["createcode",_create];

//--- First building
_startpos = getPos _logic;
_startdis = 0;

_tierN = 0;
_tier = [];
_lasttier = [_logic];

while {(_logic getvariable "housecounttemp") > 0} do {
	_tier = [];
	{
		_xdir = direction _x;
		_bbox = boundingbox _x;
		_b1 = _bbox select 0;
		_b2 = _bbox select 1;
		_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
		_bby = (abs(_b1 select 1) + abs(_b2 select 1));
		//debuglog ["Log::::::XXXXX",[_logic,_x,0,_xdir]];

		if (_bbx == 0 && _bby == 0) then {
			//--- Starter
			_obj = [_logic,_x,0,_xdir,_logic] call _create;

		} else {
			//--- Surrounding buildings
			_obj = [_logic,_x,_bby,_xdir + 000] call _create;
			_obj = [_logic,_x,_bbx,_xdir + 090] call _create;
			_obj = [_logic,_x,_bby,_xdir + 180] call _create;
			_obj = [_logic,_x,_bbx,_xdir + 270] call _create;
		};
	} foreach _lasttier;
	_lasttier = _tier;
	_tierN = _tierN + 1;

	//--- FAIL!
	if (count _tier == 0) exitwith {
		_debugText = format ["Log: [GITA] Error: Unable to start city (%1) - not enough free space!",_logic];
		debuglog _debugText;
		hint _debugText;
	};
};
















waituntil {_logic getvariable "housecounttemp" <= 0};
_houselist = _logic getvariable "houselist";

[nil,nil,"per",rSPAWN,_logic,{
	//waituntil {!isnil {_this getvariable "houselist"}};
	waituntil {!isnil "bis_fnc_init"};
	_this call bis_gita_fnc_createmarkers;
}] call re;


//--- Calculate center
_posX = 0;
_posY = 0;
{
	_posX = _posX + (position _x select 0);
	_posY = _posY + (position _x select 1);
} foreach _houselist;
_posX = _posX / _houseCount;
_posY = _posY / _houseCount;
_townCenter = [_posX,_posY];
_logic setvariable ["townCenter",_townCenter,true];

//--- Calculate size
_maxdis = 0;
{
	_dis = _x distance _townCenter;
	if (_dis > _maxdis) then {_maxdis = _dis};
} foreach _houselist;
_logic setvariable ["townDiameter",_maxdis,true];


//--- Start pos
if (_debug) then {
	_townsize = _logic getvariable "townsize";
	_marker = createmarkerlocal ["X",_startpos];
	_marker setmarkertypelocal "mil_circle";
	_marker setmarkercolorlocal "colorred";
	_marker setmarkersizelocal [.5,.5];

	_marker = createmarkerlocal ["XX",_startpos];
	_marker setmarkershapelocal "ellipse";
	_marker setmarkerbrushlocal "border";
	_marker setmarkersizelocal [_townsize,_townsize];
	_marker setmarkercolorlocal "colorred";
};

//--- Name town
//_location = createlocation ["nameVillage",[(_startpos select 0) + (_maxdis * 5/4),_startpos select 1,0],1,1];
//_location settext _townname;
[nil,nil,"per",rEXECVM,"ca\modules_e\gita\data\scripts\townName.sqf",_townname,[(_startpos select 0) + (_maxdis * 5/4),_startpos select 1,0]] call RE;

//--- Register town
_logic setvariable ["type","cityCenter"];
[[_logic]] call bis_fnc_locations;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// WALLS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_walls = _wallclasses;
_wallscount = count _walls;

if (_wallscount > 0) then {

	_createwall = {
		_pos1 = _this select 0;
		_pos2 = _this select 1;

		/*
			_color = ["coloryellow","colorred","colorblue","colorgreen"] call bis_fnc_selectrandom;
			_marker = createmarkerlocal [format ["xxx%2%1",0,floor random 100000],_pos1];
			_marker setmarkerdirlocal direction _obj;
			_marker setmarkertypelocal "mil_dot";
			_marker setmarkercolorlocal _color;
			_marker = createmarkerlocal [format ["xxx%2%1",1,floor random 100000],_pos2];
			_marker setmarkerdirlocal direction _obj;
			_marker setmarkertypelocal "mil_dot";
			_marker setmarkercolorlocal _color;
		*/

		_dis = [_pos1,_pos2] call bis_fnc_distance2D;
		_dir = [_pos1,_pos2] call bis_fnc_dirto;

		_obj = _wall createvehicle [100,100,100];
		_bbox = boundingbox _obj;
		_b1 = _bbox select 0;
		_b2 = _bbox select 1;
		_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
		_bby = (abs(_b1 select 1) + abs(_b2 select 1));
		_size = (sqrt(_bbx^2 + _bby^2));

		_lenght = (_bbx max _bby) * _lenghtCoef;
		_steps = floor (_dis / _lenght);

		for "_i" from 0 to (_dis - _lenght * 2) step _lenght do {
			_pos = [
				(_pos1 select 0) + (sin _dir * (_i + _lenght / 2)),
				(_pos1 select 1) + (cos _dir * (_i + _lenght / 2)),
				0
			];
			_obj = _wall createvehicle _pos;
			_obj setpos _pos;
			_obj setdir (_dir + _dirAdd -2 + random 4);
			if (_onGround) then {_obj setpos _pos};
		};
	};


	_houselisttemp = _houselist;
	//for "_n" from 0 to (_housecount / 3) do {
	_n = 0;
	{
		//_array = _walls call bis_fnc_selectrandom;
		_array = _walls select ((_random + round (_n^1.5)) % _wallscount);
		_wall = _array select 0;
		_dirAdd = _array select 1;
		_lenghtCoef = _array select 2;
		_onGround = _array select 3;

		_obj1 = _x;
		//_obj1 = _houselisttemp call bis_fnc_selectrandom;
		_obj1size = _obj1 call bis_fnc_boundingcircle;
		_obj2 = ((nearestObjects [_obj1, ["building"], (_obj1size/2) * _coefWall]) - [_obj1]) call bis_fnc_selectrandom;
		if (isnil "_obj2" && alive _obj1) then {

			_houselisttemp = _houselisttemp - [_obj1,_obj2];

			_corners = [_obj1] call bis_fnc_boundingBoxCorner;
			_ran1 = (_n + _random) % 3 ;//floor random 4;
			_ran2 = round (_ran1 - 1 + (_n + _random) % 2);

			if (_ran1 != 0 && _ran2 != 0) then {
				_pos1 = _corners select 0;
				_pos2 = _corners select 1;
				[_pos1,_pos2] call _createwall;
			};
			if (_ran1 != 1 && _ran2 != 1) then {
				_pos1 = _corners select 1;
				_pos2 = _corners select 2;
				[_pos1,_pos2] call _createwall;
			};
			if (_ran1 != 2 && _ran2 != 2) then {
				_pos1 = _corners select 2;
				_pos2 = _corners select 3;
				[_pos1,_pos2] call _createwall;
			};
			if (_ran1 != 3 && _ran2 != 3) then {
				_pos1 = _corners select 3;
				_pos2 = _corners select 0;
				[_pos1,_pos2] call _createwall;
			};

		};

		
		_n = _n + 1;
	} foreach _houselist;
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MISC STUFF
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_misc = _miscClasses;
_wrecks = _wreckclasses;
_n = 1/(_coefMisc + 0.00000001);

if (count (_misc + _wrecks) > 0) then {

	for "_i" from 0 to (_housecount - 1) step _n do {
		_house = _houselist select _i;//call bis_fnc_selectrandom;
		_housesize = sizeof typeof _house;
		_list = if (random 1 > 0.9) then {_wrecks} else {_misc};
		_listcount = count _list;
		_class = _list select ((_random + round (_i^1.5)) % _listcount);//_list call bis_fnc_selectrandom;

		_obj = createvehicle [_class, position _house, [], _housesize / 2, "none"];
		_obj setdir (random 360);
		_obj setpos [position _obj select 0,position _obj select 1,0];

		progressLoadingScreen (0.5 + (1 / _loadingParts) + _i / _housecount / (2 * _loadingParts));

		if (_debug) then {
			_marker = createmarkerlocal [format ["wreck_%1",round random 1000000],position _obj];
			_marker setmarkerdirlocal direction _obj;
			_marker setmarkertypelocal "mil_dot";
			_marker setmarkercolorlocal "colororange";
			//_marker setmarkeralphalocal 0.5;
			_marker setmarkertextlocal str(_nearhouses);
		};
	};
};


_logic setvariable ["houselist",_houselist,true];
_logic setvariable ["status",1,true];