params [
["_player",objNull,[objNull]],
["_mode",0,[0]]
];
if(isNull _player) exitWith {};

_ready = [];
_player = owner _player;

switch(_mode) do {

case 0: {
_queryResult = ["GovernmentGetDetails",2] call DB_fnc_asyncCall;
_tmp = [(_queryResult select 0)] call DB_fnc_numberSafe;
_tmp1 = [(_queryResult select 1)] call DB_fnc_numberSafe;
_ready pushBack _tmp;
_ready pushBack _tmp1;
[_ready,0] remoteExecCall ["life_fnc_maqabrudr",_player];
};
default {};
};
