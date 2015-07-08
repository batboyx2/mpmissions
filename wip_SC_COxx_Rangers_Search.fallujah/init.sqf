//Script for use by PhanTactical only. Applying this further than the PhanTactical servers isn't a good idea without asking. Enjoy awesome viewdistance!
//Mission editors, place this in your mission's editor folder, right where the mission.sqm is. YOU MUST insert a functions module into the scenario itself for it to work. Thanks!

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "View Distance - 100"; 
_trg setTriggerActivation ["DELTA", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'if (viewDistance > 0) then { setViewDistance (viewDistance - 100); }; hintSilent format["View Distance: %1", viewDistance]', ""]; 

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "View Distance + 100"; 
_trg setTriggerActivation ["ECHO", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'if (viewDistance < 5000) then { setViewDistance (viewDistance + 100); }; hintSilent format["View Distance: %1", viewDistance]', ""]; 

