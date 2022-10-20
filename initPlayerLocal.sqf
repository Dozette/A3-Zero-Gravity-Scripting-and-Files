params ["_player", "_didJIP"];
[_player] execVM "scripts\zerograv\zg.sqf";
vecupdate = [0,0,0];
movez = 0;
addMissionEventHandler ["EachFrame",{
vecupdate = [0,0,0];
    if ((inputAction "MoveForward" > 0)) then {
        _weaponVectorDir = unit weaponDirection currentWeapon unit;
        vecupdate = [(_weaponVectorDir select 0) * 0.01, (_weaponVectorDir select 1) * 0.01, 0];
    };
    
    if ((inputAction "TurnLeft" > 0)) then {
        _weaponVectorDir = unit weaponDirection currentWeapon unit;
        //convert vector to degree 0-360
        _adir = _weaponVectorDir # 0 atan2 _weaponVectorDir # 1;
        //add our desired direction
        _newdir = _adir + 280;
        //check if direction is out of the bounds of 0-360
        if (_newdir > 360) then {
            _buffer = 360 - _adir;
            _newdir = 280 - _buffer;
        };
        //pass our direction to function to de-convert back into vector array
        _velocity = [_newdir] call degtoarr;
        //add array to vecupdate (added to player velocity later)
        vecupdate = [(_velocity select 0) * 0.01, (_velocity select 1) * 0.01, 0];
    };

    if ((inputAction "TurnRight" > 0)) then {
        _weaponVectorDir = unit weaponDirection currentWeapon unit;
        _adir = _weaponVectorDir # 0 atan2 _weaponVectorDir # 1;
        _newdir = _adir + 90;
        if (_newdir > 360) then {
            _buffer = 360 - _adir;
            _newdir = 90 - _buffer;
        };
        _velocity = [_newdir] call degtoarr;
        vecupdate = [(_velocity select 0) * 0.01, (_velocity select 1) * 0.01, 0];
    };
 
    if ((inputAction "MoveBack" > 0)) then {
        _weaponVectorDir = unit weaponDirection currentWeapon unit;
        vecupdate = [(_weaponVectorDir select 0) * -0.01, (_weaponVectorDir select 1) * -0.01, 0];
    };
 
    if ((inputAction "LeanLeft" > 0)) then {
 
        movez = movez + .01;
 
    };
 
    if ((inputAction "LeanRight" > 0)) then {
 
        movez = movez + -.01;
 
    };
 
}];
 
 
degtoarr = {
_return = [0, 1, 0]; // North
 
_angle = _this select 0;
 
_xlen = tan _angle;
 
 
// Determine quadrant and special cases and return
 
if ((_angle > 0) && (_angle < 90)) then {_return = [_xlen, 1, 0]};
 
if ((_angle > 90) && (_angle < 180)) then {_return = [-_xlen, -1, 0]};
 
if ((_angle > 180) && (_angle < 270)) then {_return = [-_xlen, -1, 0]};
 
if ((_angle > 270) && (_angle < 360)) then {_return = [_xlen, 1, 0]};
 
if (_angle == 90) then {_return = [1, 0, 0]};
 
if (_angle == 180) then {_return = [0, -1, 0]};
 
if (_angle == 270) then {_return = [-1, 0, 0]};
 
_return = vectorNormalized _return;
 
 
_return
};
 
addMissionEventHandler ["EachFrame",{
 
_zgai = (allUnits + vehicles) select {_x getVariable ["zgai",false]};
 
{_x setVelocity [0,0,0];} forEach _zgai;
//{_x setVelocity [0,0,0]; _x playMove "AsdvPercMstpSnonWrflDnon_turnL";} forEach _zgai;
 
 
}];

0 spawn {
  waitUntil { sleep 1; not isNull player }; // for potential MP
  while { true } do
  {
    player say3D ["HelmetBreathing", 25, 1, true];
    sleep 15;
  };
};

player addEventHandler ["respawn", {unit  = player}];

player addEventHandler ["GetIn", {
    params ["_vehicle", "_role", "_unit", "_turret"];
zerog = false;
}];
player addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
zerog = true
}]; //Testing vehicle fix, delete if issues.