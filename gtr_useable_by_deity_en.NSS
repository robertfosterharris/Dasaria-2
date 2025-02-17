//	ON ENTER - MAKES PLACEABLES USEABLE BASED ON DEITY
//
//	SEE SISTER SCRIPT - GTR_USEABLE_BY_DEITY_EX
//
//	TRIGGER VARIABLES
//
//	string sDeity		- THE PC DIETY
//	string sPlaceables	- A COMMA DELIMITED LIST OF OBJECT TAGS TO MAKE USEABLE
//


void recursiveCheck(object oPC);

void main()
{
	object oPC;
	
	oPC = GetEnteringObject();
	SetLocalInt(oPC, GetTag(OBJECT_SELF) + "_ACTIVE", TRUE);
	
	recursiveCheck(oPC);
}

void recursiveCheck(object oPC)
{
	int nNth;
	object oPlaceable;
	string sPlaceable;
	string sPlaceables;

	if (GetLocalInt(oPC, GetTag(OBJECT_SELF) + "_ACTIVE"))
	{
			
		{
	string sDeity = GetStringUpperCase(sDeity);
	object oPC = GetPCSpeaker();
	string sPCDeity = GetStringUpperCase(GetDeity(oPC));

	}
		}
		if (GetUseableFlag(oPlaceable) == FALSE) DelayCommand(6.0, recursiveCheck(oPC));
	}