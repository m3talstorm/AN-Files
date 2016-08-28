params [
["_prison",objNull,[objNull]],
["_player",objNull,[objNull]],
["_time",-1,[0]]
];
if(_time isEqualTo -1) exitWith {};
if(isNull _prison OR {isNull _player}) exitWith {};
if(PrisonBreakCoolDown) exitWith {["PrisonCoolDown"] remoteExecCall ["life_fnc_notificationHandler",(owner _player)]; [true,"empcharge",1] remoteExecCall ["life_fnc_meqafubadru",(owner _player)];};
[empcharge,false] remoteExecCall ["hideObjectGlobal",2];
[emppad,false] remoteExecCall ["hideObjectGlobal",2];
[empcharge,3] call BIS_fnc_dataTerminalAnimate;

if(isNil "EMPAmount") then {EMPAmount = 0;};
if(isNil "EMPTimer") then {EMPTimer = _time * 60;};
_chargeOne = "DemoCharge_Remote_Ammo_Scripted" createVehicle [0,0,100];
_chargeTwo allowDamage false;
_chargeOne attachTo [_prison,[0,0,-0.5]];
if(_time isEqualTo 3) then {
["EMPChargeThree"] remoteExecCall ["life_fnc_notificationHandler",(owner _player)];
} else {
["EMPChargeFour"] remoteExecCall ["life_fnc_notificationHandler",(owner _player)];
};
if(EMPThread isEqualTo -1) then {
EMPThread = [60,AN_server_empServerThread,[_prison,_player],true] call AN_server_threadAdd;
};