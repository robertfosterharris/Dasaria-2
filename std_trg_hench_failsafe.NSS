// std_trg_hench_failsafe
void main()
{
	object oPC = GetEnteringObject();	
	object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
	if (GetIsObjectValid(oHench))
	{        
			RemoveHenchman(oPC,oHench);
			DestroyObject(oHench);
	}		
}