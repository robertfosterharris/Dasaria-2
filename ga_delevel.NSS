// ga_delevel
// wired 01/13/2010
// lose a level
// Code is from JEG's Training Module, VERY minor changes
//
// int seasons = number of levels to lose

void main(int seasons)
{
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	object oItem;
	effect eSleep = EffectSleep();
	effect eVis = EffectVisualEffect(VFX_DUR_SLEEP);
	effect eLink;
	int xp = GetXP(oPC);
	int nextlvl = 1000;
	int totalxp = 0;
	int nSlot = 0;
	string sStartHD = IntToString(GetHitDice(oPC));
	
	string sCharName	=	GetName(oPC);
	string sPlayerName	=	GetPCPlayerName(oPC);
	string sCDKey		=	GetPCPublicCDKey(oPC);
	
	// wired: number of 'seasons' to forget
	int whatlevel = GetHitDice(oPC)-seasons;
	
	int nECL = 0;
	string sECL;
	int nRace = GetSubRace(oPC);
	sECL = Get2DAString("racialsubtypes", "ECL", nRace);
	nECL = StringToInt(sECL);	
	
	// failsafe: dequip everything
	while (nSlot < NUM_INVENTORY_SLOTS)
	{
		oItem = GetItemInSlot(nSlot, oPC);
		AssignCommand(oPC,ActionUnequipItem(oItem));
		nSlot++;
	}	
	
	eLink = EffectLinkEffects(eVis,eSleep);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,6.0f);
	
	// wired: no negative numbers!
	if (whatlevel <= 1) 
	{ 
		// make level 1
		SetXP(oPC, 1);
		return;
	}
	
	whatlevel += nECL;

	// set your level
	int i;
	for (i = 1; i < whatlevel; i++) 
	{
	  	totalxp += nextlvl;
		nextlvl += 1000;
	}
	SetXP(oPC, totalxp + 1);
	
	string sEndHD = IntToString(GetHitDice(oPC));
	
	WriteTimestampedLogEntry("DELEVEL: Player "+sPlayerName+" ("+sCDKey+") delevels character "+sCharName+", from "+sStartHD+" ("+IntToString(xp)+") to "+sEndHD+" ("+IntToString(totalxp)+")");
}