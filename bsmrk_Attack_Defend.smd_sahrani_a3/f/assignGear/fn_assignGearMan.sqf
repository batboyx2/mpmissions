waitUntil {!isNil "bsmrk_param_bluforFactionP"};
// F3 - F3 Folk ARPS Assign Gear
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
_unit = _this select 0;

if (!(local _unit)) exitWith {};

_faction = tolower (faction _unit);
//Check variable f_gear, otherwise default to typeof
_loadout = _unit getVariable ["F_Gear", (typeOf _unit)];

// INSIGNIA (todo: move to the CfgLoadouts system)
// This block will give units insignia on their uniforms.
/*[_unit,_loadout] spawn {
    #include "f_assignInsignia.sqf"
};*/

_side = switch (side _unit) do {
	case west: {["BLUFOR_", bsmrk_param_bluforFactionP]};
	case east: {["OPFOR_", bsmrk_param_opforFactionP]};
	case resistance: {["INDFOR_", bsmrk_param_indFactionP]};
};
_pathS = missionConfigFile >> "CfgLoadouts" >> format["%1%2", _side select 0, _side select 1] >> _faction;
_path = missionConfigFile >> "CfgLoadouts" >> format["%1%2", _side select 0, _side select 1] >> _faction >> _loadout;

if(!isClass(_path)) exitWith {
    if (isPlayer _unit) then {
        // _unit setVariable ["f_var_assignGear_done", true, true];
        diag_log format ["No loadout found for %1 (typeOf %2)", _unit, (typeof _unit)];
        systemChat format ["No loadout found for %1 (typeOf %2)", _unit, (typeof _unit)];
    };
};
private ["_uniforms","_attachments","_linkedItems","_items","_magazines","_handguns","_launchers","_weapons","_backpackItems","_backpack","_headgears","_vests","_glHE","_glWP","_glFL"];
_uniforms = getArray(_path >> "uniform");
_vests = getArray(_path >> "vest");
_headgears = getArray(_path >> "headgear");
_backpack = getArray(_path >> "backpack");
_backpackItems = getArray(_path >> "backpackItems");
_weapons = getArray(_path >> "weapons");
_launchers = getArray(_path >> "launchers");
_handguns = getArray(_path >> "handguns");
_magazines = getArray(_path >> "magazines");
_items = getArray(_path >> "items");
_linkedItems = getArray(_path >> "linkedItems");
_attachments = getArray(_path >> "attachments");
if (!isNil "gv_confirmedWeapons") then {if (gv_confirmedWeapons) then {
	//==================================================================================
	// WEAPONS
	//array that defines the weapons to be replaced and what they're to be replaced with
	_weaponsReplace = [
		[getArray (_pathS >> (toLower format["%1_rifle", side _unit])), 			gv_riflemanWeapon],
		[getArray (_pathS >> (toLower format["%_ar", side _unit])), 				gv_autoriflemanWeapon],
		[getArray (_pathS >> (toLower format["%1_glrifle", side _unit])), 		gv_grenadeWeapon],
		[getArray (_pathS >> (toLower format["%1_carbine", side _unit])), 	gv_carbineWeapon]
	];
	//replace the weapons as above
	{
		_weaponsEntry = _x;
		{
			_weaponsReplaceEntry = _x;
			{
				if (_x in _weapons) then {
					_weapons = _weapons - [_x];
					_weapons = _weapons + [(_weaponsReplaceEntry select 1)];
				};
			} forEach (_weaponsReplaceEntry select 0);
		} forEach _weaponsReplace;
	} forEach _weapons;
	
	//==================================================================================
	// MAGAZINES
	//array that defines the mags to be replaced and what they're to be replaced with
	_glMuzzle = (getArray (configFile >> "cfgWeapons" >> gv_grenadeWeapon >> "muzzles")) select 1;
	_glMags = getArray (configFile >> "cfgWeapons" >> gv_grenadeWeapon >> _glMuzzle >> "magazines");
	//diag_log str _glMags;
	{
		if (isNil "_glHE") then {_glHE = if ((["HE_", _x] call KK_fnc_inString) || (["_HE", _x] call KK_fnc_inString) || (["VOG25", _x] call KK_fnc_inString)) then {_x};};
		if (isNil "_glWP") then {_glWP = if ((["SMOKE", _x] call KK_fnc_inString) || (["M714", _x] call KK_fnc_inString) || (["M715", _x] call KK_fnc_inString) || (["M716", _x] call KK_fnc_inString) || (["M713", _x] call KK_fnc_inString) || (["GRD", _x] call KK_fnc_inString)) then {_x};};
		if (isNil "_glFL") then {_glFL = if ((["FLARE", _x] call KK_fnc_inString) || (["M662", _x] call KK_fnc_inString) || (["M661", _x] call KK_fnc_inString) || (["M585", _x] call KK_fnc_inString) || (["VG40OP", _x] call KK_fnc_inString)) then {_x};};
	} forEach _glMags;
	if (isNil "_glHE") then {_glHE = false};
	if (isNil "_glWP") then {_glWP = false};
	if (isNil "_glFL") then {_glFL = false};
	//diag_log format["is %1 : %2 : %3", _glHE, _glWP, _glFL];
	
	_magsReplace = [
		[getArray (_pathS >> (toLower format["%1_rifle_mag", side _unit])), (getArray (configFile >> "cfgWeapons" >> gv_riflemanWeapon >> "magazines")) select 0],
		[getArray (_pathS >> (toLower format["%_ar_mag", side _unit])), (getArray (configFile >> "cfgWeapons" >> gv_autoriflemanWeapon >> "magazines")) select 0],
		[getArray (_pathS >> (toLower format["%1_ar_mag2", side _unit])), (getArray (configFile >> "cfgWeapons" >> gv_autoriflemanWeapon >> "magazines")) select 1],
		[getArray (_pathS >> (toLower format["%1_glrifle_mag", side _unit])), (getArray (configFile >> "cfgWeapons" >> gv_grenadeWeapon >> "magazines")) select 0],
		[getArray (_pathS >> (toLower format["%1_carbine_mag", side _unit])), (getArray (configFile >> "cfgWeapons" >> gv_carbineWeapon >> "magazines")) select 0],
		
		[getArray (_pathS >> (toLower format["%1_glrifle_mag_he", side _unit])), 			_glHE],
		[getArray (_pathS >> (toLower format["%1_glrifle_mag_smoke", side _unit])), 	_glWP],
		[getArray (_pathS >> (toLower format["%1_glrifle_mag_flare", side _unit])), 		_glFL]
	];
	
	//replace the mags as above
	//diag_log ("BEFORE " + str _magazines);
	{
		{
			_magsReplaceEntry = _x;
			{
				_magSplit = [_x,":"] call BIS_fnc_splitString;
				_magType = _magSplit select 0;
				_magCount = if (count _magSplit > 1) then {parseNumber (_magSplit select 1);} else {1};
				if ((_x in _magazines) && !((typeName (_magsReplaceEntry select 1)) == "BOOL")) then {
					//diag_log ("sub " + str _x);
					_magazines = _magazines - [_x];
					//diag_log ("add " + format["%1:%2", (_magsReplaceEntry select 1), _magCount]);
					_magazines = _magazines + [format["%1:%2", (_magsReplaceEntry select 1), _magCount]];
				};
			} forEach (_magsReplaceEntry select 0);
		} forEach _magsReplace;
	} forEach _magazines;
	//diag_log ("AFTER " + str _magazines);
	
	_handguns = getArray(_path >> "handguns");
};};


removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItemsWithMagazines _unit;

// ====================================================================================
// Clothes
//Random Uniform:
if ((count _uniforms) == 0) then {
    removeUniform _unit;
} else {
    _toAdd = _uniforms call BIS_fnc_selectRandom;
    if ((!isNil "_toAdd") && {isClass (configFile >> "CfgWeapons" >> _toAdd)}) then {
        removeUniform _unit;
        _unit forceAddUniform _toAdd;
    } else {
        diag_log text format ["[BW] %1 Uniform (%2) not found using default (%3)", _loadout, _toAdd, (uniform _unit)];
    };
};
//Random Vest:
if ((count _vests) == 0) then {
    removeVest _unit;
} else {
    _toAdd = _vests call BIS_fnc_selectRandom;
    if ((!isNil "_toAdd") && {isClass (configFile >> "CfgWeapons" >> _toAdd)}) then {
        removeVest _unit;
        _unit addVest _toAdd;
    } else {
        diag_log text format ["[BW] %1 Vest (%2) not found using default (%3)", _loadout, _toAdd, (vest _unit)];
    };
};
//Random Backpack:
if ((count _backpack) == 0) then {
    removeBackpack _unit;
} else {
    _toAdd = _backpack call BIS_fnc_selectRandom;
    if ((!isNil "_toAdd") && {isClass (configFile >> "CfgVehicles" >> _toAdd)}) then {
        removeBackpack _unit;
        _unit addBackpack _toAdd;
    } else {
        diag_log text format ["[BW] %1 Backpack (%2) not found using default (%3)", _loadout, _toAdd, (backpack _unit)];
    };
};
//Random Headgear:
if ((count _headgears) == 0) then {
    removeHeadgear _unit;
} else {
    _toAdd = _headgears call BIS_fnc_selectRandom;
    if ((!isNil "_toAdd") && {isClass (configFile >> "CfgWeapons" >> _toAdd)}) then {
        removeHeadgear _unit;
        _unit addHeadgear _toAdd;
    } else {
        diag_log text format ["[BW] %1 Headgear (%2) not found using default (%3)", _loadout, _toAdd, (headgear _unit)];
    };
};

//Clear backpack
clearAllItemsFromBackpack _unit;

// Backpack Items
{
    _arr = [_x,":"] call BIS_fnc_splitString;
    if ((count _arr) > 0) then {
        _classname = _arr select 0;
        _amt = if (count _arr > 1) then {parseNumber (_arr select 1);} else {1};
        for [{_i=1},{_i<=_amt},{_i=_i+1}] do {
            if (_unit canAddItemToBackpack _classname) then {
                _unit addItemToBackpack _classname;
            } else {
                _unit addItem _classname;
            };
        };
    };
} foreach _backpackItems;

// ====================================================================================
// Items
{
    _arr = [_x,":"] call BIS_fnc_splitString;
    if ((count _arr) > 0) then {
        _classname = _arr select 0;
        _amt = if (count _arr > 1) then {parseNumber (_arr select 1);} else {1};
        for [{_i=1},{_i<=_amt},{_i=_i+1}] do {
            _unit additem _classname;
        };
    };
} foreach _items;
{
    _arr = [_x,":"] call BIS_fnc_splitString;
    if ((count _arr) > 0) then {
        _classname = _arr select 0;
        _amt = if (count _arr > 1) then {parseNumber (_arr select 1);} else {1};
        if ("Binocular" in ([(configFile >> "CfgWeapons" >> _classname), true] call BIS_fnc_returnParents)) then {
            _unit addWeapon _classname;
        } else {
            for [{_i=1},{_i<=_amt},{_i=_i+1}] do {
                _unit linkItem _classname;
            };
        };
    };
} foreach _linkedItems;

// Magazines
_magazinesNotAdded = [];
{
    _arr = [_x,":"] call BIS_fnc_splitString;
    if ((count _arr) > 0) then {
        _classname = _arr select 0;
        _amt = if (count _arr > 1) then {parseNumber (_arr select 1);} else {1};
        _unit addMagazines [_classname, _amt];
        _notAdded = _amt - ({_x == _classname} count (magazines _unit));
        for "_index" from 0 to (_notAdded - 1) do {
            _magazinesNotAdded pushBack _classname;
        };
    };
} foreach _magazines;

// ====================================================================================
// Weapons
if ((count _weapons) > 0) then {_unit addWeapon (_weapons call BIS_fnc_selectRandom);};
if ((count _launchers) > 0) then {_unit addWeapon (_launchers call BIS_fnc_selectRandom);};
if ((count _handguns) > 0) then {_unit addWeapon (_handguns call BIS_fnc_selectRandom);};

// ====================================================================================
// attachments
{
    _arr = [_x,":"] call BIS_fnc_splitString;
    if ((count _arr) > 0) then {
        _classname = _arr select 0;
        _amt = if (count _arr > 1) then {parseNumber (_arr select 1);} else {1};
        for [{_i=1},{_i<=_amt},{_i=_i+1}] do {
            _unit addPrimaryWeaponItem _classname;
            _unit addSecondaryWeaponItem _classname;
            _unit addHandgunItem _classname;
        };
    };
} foreach _attachments;

//Try to add missing magazines:
{
    if (_unit canAdd _x) then {
        _unit addMagazines [_x, 1];
    } else {
        if (isNil "F_GEAR_ERROR_LOADOUTS") then {F_GEAR_ERROR_LOADOUTS = [];};
        diag_log text format ["[BW] %1 - No room for magazine %2", _loadout, _x];
        if (!(_loadout in F_GEAR_ERROR_LOADOUTS)) then {
            F_GEAR_ERROR_LOADOUTS pushBack _loadout;
            diag_log text format ["Failed To add Magazine %1 to %2", _x, _loadout];
        };
    };
} forEach _magazinesNotAdded;

_a = _path >> "init";
if (isText _a) then {
    _unit call compile ("this = _this;"+ getText _a);
};

_unit setVariable ["f_var_assignGear_done", true, true];
