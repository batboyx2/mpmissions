private ["_defenseLeader"];
_defenseLeader = _this select 0;

_side = switch (side _defenseLeader) do {
	case west: {["BLUFOR_", bsmrk_param_bluforFactionP]};
	case east: {["OPFOR_", bsmrk_param_opforFactionP]};
	case resistance: {["INDFOR_", bsmrk_param_indFactionP]};
};
_pathS = missionConfigFile >> "CfgLoadouts" >> format["%1%2", _side select 0, _side select 1] >> _faction;

gv_riflemanWeapon = (getArray (_pathS >> format["%1_rifle", side _unit])) select 0;
gv_autoriflemanWeapon = (getArray (_pathS >> format["%1_ar", side _unit])) select 0;
gv_grenadeWeapon = (getArray (_pathS >> format["%1_glrifle", side _unit])) select 0;
gv_carbineWeapon = (getArray (_pathS >> format["%1_carbine", side _unit])) select 0;
gv_pistolWeapon = (getArray (_pathS >> format["%1_pistol", side _unit])) select 0;

gv_confirmedWeapons = false; publicVariable "gv_confirmedWeapons";

//Pistol
bsmrk_fnc_pistolWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_pistolWeapon = secondaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};
_defenseLeader addAction [
	"Change Pistol",
	bsmrk_fnc_pistolWeapon,
	_defenseLeader,
	10.1,
	false,
	true
];

//Carbine
bsmrk_fnc_carbineWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_carbineWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};
_defenseLeader addAction [
	"Change Carbine",
	bsmrk_fnc_carbineWeapon,
	_defenseLeader,
	10.1,
	false,
	true
];

//Rifle
bsmrk_fnc_riflemanWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_riflemanWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};
_defenseLeader addAction [
	"Change Rifle",
	bsmrk_fnc_riflemanWeapon,
	_defenseLeader,
	10,
	false,
	true
];


//Automatic Rifle
bsmrk_fnc_autoriflemanWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_autoriflemanWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};
_defenseLeader addAction [
	"Change Automatic Rifle",
	bsmrk_fnc_autoriflemanWeapon,
	_defenseLeader,
	9.9,
	false,
	true
];

//Grenade Rifle
bsmrk_fnc_grenadeWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_grenadeWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};
_defenseLeader addAction [
	"Change Grenadier Rifle",
	bsmrk_fnc_grenadeWeapon,
	_defenseLeader,
	9.8,
	false,
	true
];

//confirm
bsmrk_fnc_confirmWeaponry = {
	_defenseLeader = _this select 3;
	removeAllActions _defenseLeader;
	gv_confirmedWeapons = true; publicVariable "gv_confirmedWeapons";
	hint str [gv_riflemanWeapon, gv_autoriflemanWeapon];
};
_defenseLeader addAction [
	"Confirm Weaponry",
	bsmrk_fnc_confirmWeaponry,
	_defenseLeader,
	0,
	false,
	true
];

