/**************************************************
	BD Light Truck Script
	Light To Cargo

Move the unit to from the searchlight back to the truck.
Called by the "To back seat" action.
**************************************************/

_light = _this select 0;
_unit = _this select 1;

_truck = _light getVariable "lightTruck_truck";
_unit setPos (getPos _light);
{if(!(_unit in crew _truck))then{_truck lockCargo [_X,false]; _unit moveInCargo [_truck,_X]}} forEach [11,12,1,2,3,4,5,6,7,8,9,10];
if(!(_unit in crew _truck))then{_unit moveInGunner _light};