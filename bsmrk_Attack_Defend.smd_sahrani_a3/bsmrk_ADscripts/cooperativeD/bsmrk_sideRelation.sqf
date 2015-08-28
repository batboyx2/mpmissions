private ["_attacker1","_attacker2","_defender1","_defender2"];


_attacker1 = switch (bsmrk_param_attackingSide1P) do {
	case "WEST": {west};
	case "EAST": {east};
	case "IND": {resistance};
};
_attacker2 = switch (bsmrk_param_attackingSide2P) do {
	case "WEST": {west};
	case "EAST": {east};
	case "IND": {resistance};
};
_defender1 = switch (bsmrk_param_defendingSide1P) do {
	case "WEST": {west};
	case "EAST": {east};
	case "IND": {resistance};
};
_defender2 = switch (bsmrk_param_defendingSide2P) do {
	case "WEST": {west};
	case "EAST": {east};
	case "IND": {resistance};
};

if !(_attacker1 == _attacker2) then {
	_attacker1 setFriend [_attacker2, 1];
	_attacker2 setFriend [_attacker1, 1];
};

if !(_defender1 == _defender2) then {
	_defender1 setFriend [_defender2, 1];
	_defender2 setFriend [_defender1, 1];
};