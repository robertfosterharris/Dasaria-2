//	ONITEMACTIVATE SCRIPT THAT ALLOWS YOU TO PLACE A CREATURE
//	THAT WAS CAPTURED WITH THE GB_POKEMON_CO SCRIPT.
//
//	1/20/2007	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	object oItem;
	object oCreature;
	
	oItem = GetItemActivated();
	oCreature = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oItem, "sCreature"), GetItemActivatedTargetLocation());
	SetFirstName(oCreature, GetName(oItem));
	SetDescription(oCreature, GetDescription(oItem));
}