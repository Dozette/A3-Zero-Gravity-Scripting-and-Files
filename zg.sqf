movez = 0;
vectrue = [0,0,0];
// set up our unit in their own private var
unit = _this select 0;
zerog = true;
0.1 fadeSpeech 0.5;

player setUnitFreefallHeight 9999;
 
addMissionEventHandler ["EachFrame",{
    alt = (getPosASL unit) select 2;
    if (zerog) then {
        0.1 fadeSound 0; 
        0.1 fadeSpeech 1;
        hintSilent format ["Altitude: %1", alt];
        unit playMove "AsdvPercMstpSnonWrflDnon";
        veccurent = velocity unit;
        vectrue = veccurent vectorAdd vecupdate;
        unit setVelocity [(vectrue select 0), (vectrue select 1), 0 + movez];
    };
    if ((!zerog) && (animationState unit == "asdvpercmstpsnonwrfldnon")) then { unit switchmove ""; 0.1 fadeSound 1; 0.1 fadeSpeech 0; };
}];