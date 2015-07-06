/**************************************************
	BD Light Truck Script
	Man Light

Move the unit to the truck's searchlight. Called by the
"Man Searchlight" action.
**************************************************/

_truck = _this select 0;
_unit = _this select 1;

_light = _truck getVariable "lightTruck_lightObject";
_unit setPos (getPos _truck);
_light lockTurret [[0],false];
_unit moveInTurret [_light,[0]];