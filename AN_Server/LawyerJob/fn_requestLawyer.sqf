params [
["_requestee",objNull,[objNull]],
["_information","",[""]],
["_amount",0,[0]]
];
if(isNull _requestee OR {isNil "_requestee"} OR {_information isEqualTo ""} OR {_amount isEqualTo 0}) exitWith {};
if(isNil "LawyerRequests") then {LawyerRequests = [];};
if(count LawyersOnDuty isEqualTo 0) exitWith {[0,_amount] remoteExecCall ["life_fnc_prlubriawiethia",owner _requestee];};
LawyerRequests pushBack [_requestee,_information,_amount];
{
[1] remoteExecCall ["life_fnc_prlubriawiethia",owner _x];
} forEach LawyersOnDuty;
[30,life_fnc_lawyerThread,[_requestee,_amount],false] call AN_server_addThread;
