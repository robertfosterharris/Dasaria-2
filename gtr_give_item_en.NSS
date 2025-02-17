//  TRIGGER ON ENTER SCRIPT
//
//  GIVES CHARACTER AN ITEM
//
//  TRIGGER VARIABLE
//  sItemTag      - TAG OF THE ITEM TO BE GIVEN
//
//  ROBERT HARRIS   ROBERTHARRIS@ROBERTHARRIS.COM   01/06/2010
//
void main()
{
    object oItem;
	object oPC;
    string sItemTag;
    
	oPC = GetEnteringObject();
	
	if (GetIsPC(oPC))
	{
		if (GetLocalInt(oPC, GetTag(OBJECT_SELF) + "_DONE") == 0)
		{
			sItemTag = GetLocalString(OBJECT_SELF, "sItemTag");
			oItem = GetItemPossessedBy(oPC, sItemTag);
			if (!GetIsObjectValid(oItem))
			{
				CreateItemOnObject(sItemTag, oPC);
			}
			SetLocalInt(oPC, GetTag(OBJECT_SELF) + "_DONE", 1);
		}
	}
}