// =================================================================================================
// get killzone kid's makefile function prepared
KK_fnc_makeFile = {
    switch (typeName _this) do {
        case "STRING" : {
            _this = _this + "|" + (missionNamespace getVariable ["__temp", ""]);
            missionNamespace setVariable ["__temp", nil];
            "make_file" callExtension _this;
        };
        case "TEXT" : {
            missionNamespace setVariable [
                "__temp", 
                (missionNamespace getVariable ["__temp", ""]) + str _this + "\n"
            ];
        };
    };
};
// =================================================================================================
// create the tacview acmi header
#define toFile(X) text X call KK_fnc_makeFile;


toFile("FileType=text/acmi/tacview");
//FileType=text/acmi/tacview
toFile("FileVersion=1.7");
//FileVersion=1.7
_text = format["Source=%1 %2.%3",productVersion select 1,productVersion select 2,productVersion select 3]; toFile(_text);
//Source=Arma3 148.131561
_text = format["Recorder=%1 %2.%3", (productVersion select 1), (productVersion select 2), (productVersion select 3)]; toFile(_text);
//Recorder=Arma3 148.131561
_text = format["RecordingTime=%1-%2-%3T%4:%5:00Z", (date select 0), (date select 1), (date select 2), (date select 3), (date select 4)]; toFile(_text);
//RecordingTime=2035-5-28T13:37:00Z

// =================================================================================================
// create the tacview acmi header declarations
toFile("Title=Generic Placeholder Title");
toFile("Category=Cooperative");
_text = format["MissionTime=%1-%2-%3T%4:%5:00Z", (date select 0), (date select 1), (date select 2), (date select 3), (date select 4)]; toFile(_text);
toFile("Coalition=BLUFOR,Blue");
toFile("Coalition=OPFOR,Red");
toFile("Coalition=INDFOR,Green");
toFile("Coalition=CIVILIAN,Purple");
//toFile ("ProvidedEvents=Takeoff,Landing,LeftArea,Destroyed,Removed");


// =================================================================================================
// DO THE DATA, YO
private ["_unitsList"];
_unitslist = [];
while {time < 20} do {
	{
		_time = "#" + (str time);
		toFile(_time);
		if !(_x in _unitsList) then {
			_unitsList = _unitsList + [_x];
			_id = str ((_unitsList find _x) + 1);
			_objectType = "2C";
			_coalitionID = switch (side _x) do {
				case WEST: {"0"};
				case EAST: {"1"};
				case RESISTANCE: {"2"};
				case CIVILIAN: {"3"};
			};
			_objectName = str _x;
			//_pilotName = name _x;
			_groupName = str (group _x);
			
			_text = "+" + _id + ",," + _objectType + "," + _coalitionID + ",," + _objectName + ",," + _groupName;
			toFile(_text);
		} else {
			_id = str ((_unitsList find _x) + 1);
			_latitude = str (((getPos _x) select 0) / (110574.2727));
			_longitude = str (((getPos _x) select 1) / (111319.458));
			_altitude = str ((getPosASL _x) select 2);
			_yaw = str (getDir _x);
			
			_text = _id + "," + _latitude + "," + _longitude + "," + _altitude + ",,," + _yaw;
			toFile(_text);
		};
		
	} forEach allUnits;
	sleep 0.5;
};
// =================================================================================================
// create the file
hint ("C:\Users\Bismarck\Documents\Tacview\Arma3_tacLog.acmi" call KK_fnc_makeFile);
