private["_queryStmt","_queryResult","_key","_mode","_return","_loop"];
_tickTime = diag_tickTime;

_queryStmt = param [0,"",[""]];
_mode = param [1,1,[0]];
_multiarr = param [2,false,[false]];

_key = "extDB2" callExtension format["%1:%2:%3",_mode,DatabaseSessionId,_queryStmt];

if(_mode isEqualTo 1) exitWith {true};

_key = call compile format["%1",_key];
_key = _key select 1;
DB_Async_Active = true;
_queryResult = "";
_loop = true;
while{_loop} do {
_queryResult = "extDB2" callExtension format["4:%1",_key];
if(_queryResult isEqualTo "[5]") then {
_queryResult = "";
for "_i" from 0 to 1 step 0 do {
_pipe = "extDB2" callExtension format["5:%1", _key];
if(_pipe isEqualTo "") exitWith {_loop = false};
_queryResult = _queryResult + _pipe;
};
} else {
if !(_queryResult isEqualTo "[3]") then {
_loop = false;
};
};
};
DB_Async_Active = false;
_queryResult = call compile _queryResult;
if ((_queryResult select 0) isEqualTo 0) exitWith {diag_log format ["extDB2: Protocol Error: %1", _queryResult];[]};
_return = (_queryResult select 1);
if(!_multiarr && count _return > 0) then {
_return = _return select 0;
};
_return
