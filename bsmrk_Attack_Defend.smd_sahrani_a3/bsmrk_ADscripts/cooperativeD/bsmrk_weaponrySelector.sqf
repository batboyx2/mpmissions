private ["_defenseLeader","_riflemanWeapon","_autoriflemanWeapon"];
_defenseLeader = _this select 0;
gv_riflemanWeapon = "";
gv_autoriflemanWeapon = "";
gv_confirmedWeapons = false; publicVariable "gv_confirmedWeapons";


//R
bsmrk_fnc_riflemanWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_riflemanWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};

_defenseLeader addAction [
	"Change Rifleman Weapon",
	bsmrk_fnc_riflemanWeapon,
	_defenseLeader,
	10,
	false,
	true
];


//AR
bsmrk_fnc_autoriflemanWeapon = {
	_defenseLeader = _this select 3;
	["Open",true] spawn BIS_fnc_arsenal;
	waitUntil {!isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	waitUntil {isNull (uiNamespace getVariable 'RscDisplayArsenal')};
	gv_autoriflemanWeapon = primaryWeapon _defenseLeader;
	[_defenseLeader] call F_fnc_assignGearMan;
};

_defenseLeader addAction [
	"Change Autorifleman Weapon",
	bsmrk_fnc_autoriflemanWeapon,
	_defenseLeader,
	9.9,
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

