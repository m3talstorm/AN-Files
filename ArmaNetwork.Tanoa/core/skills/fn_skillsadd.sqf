/*
    ArmA.Network
    Rathbone
    Copyright (c) ArmA.Network 2015 - 2016

    The usage of this file is restricted to ArmA.Network
    You're not allowed to modify this file!
    Licensed under the Arma EULA and Arma Tools EULA.
    For further questions contact the author!
*/
params [
	["_skill","",[""]]
];

if (_skill isEqualTo "") exitWith {};

private _success = false;
private _has = _skill in AN_Skills;

if !(_has) then 
{
    AN_Skills pushBack _skill;
	_success = true;
};

_success