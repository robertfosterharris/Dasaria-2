// i_rod_methos_ac
// wired 2010/08/12
// rp item for lochwarians vs. dread malice canites storyline
//
//
void main()
{
	object oPC = GetItemActivator();
	location lLoc = GetItemActivatedTargetLocation();
	object oZombie = CreateObject(OBJECT_TYPE_CREATURE,"methosrift",lLoc,TRUE);
	AddHenchman(oPC,oZombie);
}