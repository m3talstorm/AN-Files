params [
["_name","",[""]],
["_uid","",[""]],
["_owner",objNull,[objNull]]
];

try
{
if (_name isEqualTo "" OR _uid isEqualTo "") then 
{
throw "Player Fetch Error: Info is Null";
};

if (isNull _owner) exitWith {};
format ["Player %1 (UID %2) Fetching EMS Data",_name,_uid] call AN_server_log; 
private _ownerID = owner _owner;
private _firstArray = [];
private _secondArray = [];
private _queryTime = diag_tickTime;
private _queryResult = [format["QueryRequest+Independent:%1",_uid],2] call DB_fnc_asyncCall;

_firstArray pushBack (_queryResult select 0); 
private _tmp = [(_queryResult select 2)] call DB_fnc_numberSafe;
private _tmp1 = [(_queryResult select 3)] call DB_fnc_numberSafe;
_firstArray pushBack _tmp; 
_firstArray pushBack _tmp1; 
_firstArray pushBack (_queryResult select 4); 
_firstArray pushBack (_queryResult select 5); 

private _emsLevel = (_queryResult select 6);
if (_emsLevel isEqualTo 0) then 
{
format ["Player %1 (UID %2) EMS: Not Whitelisted",_name,_uid] call AN_server_log; 
throw "EMS: Not Whitelisted";
};
_secondArray pushBack _emsLevel; 
_secondArray pushBack (_queryResult select 7); 

private _new = [(_queryResult select 8)] call DB_fnc_mresToArray;
if (_new isEqualType "") then 
{
_new = call compile _new;
};
_secondArray pushBack _new; 

private _blacklisted = ([_queryResult select 9,1] call DB_fnc_bool);
if (_blacklisted) then 
{
throw "EMS: Blacklisted";
};
format ["Player %1 (UID %2) Received EMS Data - Time: %3",_name,_uid,(diag_tickTime - _queryTime)] call AN_server_log;
[_firstArray,_secondArray] remoteExecCall ["life_fnc_meged",_ownerID]; 
}
catch
{
[_exception] remoteExecCall ["life_fnc_wraruswuth",(owner _owner)];
};