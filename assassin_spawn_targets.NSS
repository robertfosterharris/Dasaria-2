/*
  Wired 11/807
  Assassin's Quest
  Spawn victim and witnesses/defenders  
*/
//#include "NW_I0_GENERIC"
#include "x0_i0_position"
void main()
{
	object oPC = GetPCSpeaker();
	object oAssassin = GetObjectByTag("assassin_stalkinghorse");	

	// randomly pick one of X potential spawn points	
	int nRand = Random(13);	// one of x
	int nTarget = nRand+1;	// starts with 0, so increment by one for sanity
	string sWaypoint = "WP_assassin_" + IntToString(nTarget);
	object oWaypoint = GetObjectByTag(sWaypoint);
	object oArea = GetArea(oWaypoint);
	string sAreaName = GetName(oArea);   
	SetCustomToken(6661, sAreaName);	// conversation will access area name as <CUSTOM6661>
	SetLocalString(oPC,"sTargetArea",sAreaName);  // put it on the PC in case they forget where they are going
	location lLoc = GetLocation(oWaypoint);
	//location lLoc2 = GetBehindLocation(oWaypoint);	
	
	// read the resref of the creatures off of oAssassin's conversation
	string sVictim = GetLocalString(oAssassin, "sVictim");
	string sWitness1 = GetLocalString(oAssassin, "sWitness1");
	string sWitness2 = GetLocalString(oAssassin, "sWitness2");
	string sWitness3 = GetLocalString(oAssassin, "sWitness3");

	object oVictim 		= CreateObject(OBJECT_TYPE_CREATURE, sVictim, lLoc, TRUE);
	object oWitness1 	= CreateObject(OBJECT_TYPE_CREATURE, sWitness1, lLoc, TRUE);
	object oWitness2 	= CreateObject(OBJECT_TYPE_CREATURE, sWitness2, lLoc, TRUE);
	object oWitness3 	= CreateObject(OBJECT_TYPE_CREATURE, sWitness3, lLoc, TRUE);
	
	// put a reference to the Witnesses on oPC so we can make sure they're destroyed later
	SetLocalObject(oPC,"oWitness1",oWitness1);
	SetLocalObject(oPC,"oWitness2",oWitness2);
	SetLocalObject(oPC,"oWitness3",oWitness3);

	string sNewname = RandomName();
	//if female add an 'a'
	if (1==GetGender(oVictim))
	{
		sNewname = sNewname +"a";
	}
	SetFirstName(oVictim, sNewname);
    SetCustomToken(6662, sNewname);				// conversation will access name as <CUSTOM6662>
	SetLocalString(oPC,"sTargetName",sNewname); // put it on the PC in case they forget where they are going
	
	// create a droppable 'ear' on the Victim
	string sEarName = sNewname + "'s ear";
	string sVictimEar = "assassin_victim_ear";
	string sEarTag = GetLocalString(oAssassin,"sEarTag");
	object oEar = CreateItemOnObject(sVictimEar, oVictim, 1, sEarTag);
	SetFirstName(oEar, sEarName);
	
	// set oPC as the 'authorized' killer of oVictim
	SetLocalObject(oVictim,"AuthKiller",oPC);
}