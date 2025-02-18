// trg_melinda_failsafe
void main()
{
	object oPC = GetEnteringObject();	
	object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);	
	if (GetIsObjectValid(oHench) && GetTag(oHench) == "2bridges_melinda")
	{        
			RemoveHenchman(oPC,oHench);
			DestroyObject(oHench);
	}		
}