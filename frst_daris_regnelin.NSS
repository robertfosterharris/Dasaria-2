void Weapons(object oPC, object oReon)
{
return;
}

void main(int nWeapon)
{
object oRegn = GetObjectByTag("fstdrs_regnelin");
string sArmor = GetLocalString(oRegn,"Armor2Make");
object oPC = GetPCSpeaker();


if (nWeapon > 0)
{ Weapons(oPC,oRegn); return; }

else
	{ CreateItemOnObject(sArmor,oPC,1); }
}