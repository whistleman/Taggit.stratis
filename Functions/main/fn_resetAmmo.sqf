_unit = _this select 0;
_weapon = _this select 1;

_reloadTime = getNumber (configFile >> "CfgWeapons" >> _weapon >> "reloadTime");
sleep _reloadTime;

_unit setAmmo [_weapon, 1];
