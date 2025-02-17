/*
  Simple gladitorial wager script for NWN2 by Wired
*/

void main()
{
	string rTemplate;
	string bTemplate;
	object oPC;
	object oRedFighter;
	object oBlueFighter;
	object oBookie;
	object oGate;
	location rLoc;
	location bLoc;
	effect eACInc;
	effect eAttk;
	
	oPC 		= GetPCSpeaker();
	oBookie 	= GetObjectByTag("arena_marius");	
	rTemplate 	= GetLocalString(oBookie, "rTemplate");
	bTemplate 	= GetLocalString(oBookie, "bTemplate");	
	oGate 		= GetObjectByTag("arena_gate");
	rLoc		= GetLocation(GetObjectByTag("arena_spawn2"));
	bLoc 		= GetLocation(GetObjectByTag("arena_spawn1"));	
	
	DelayCommand(300.0, DeleteLocalInt(oBookie, "activefight"));  // strip after 5 minutes
	SetLocalInt(oPC,"justbet",1);
	DelayCommand(180.0, DeleteLocalInt(oPC, "justbet")); // must wait 3 minutes between bets
	
	//Let's close the door first	
	AssignCommand(oGate, ActionCloseDoor(oGate));
	AssignCommand(oGate, SetLocked(oGate, TRUE));

	// Create the Blue Team	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(99), bLoc);
	oBlueFighter = CreateObject(OBJECT_TYPE_CREATURE, bTemplate, bLoc, TRUE, "BlueFighter");
	oBlueFighter = GetNearestObjectByTag("BlueFighter"); // workaround createobject bug
	if (GetFirstName(oBlueFighter) == "Name") { SetFirstName(oBlueFighter, RandomName()); }
	SetLastName(oBlueFighter,GetLastName(oBlueFighter)+" for the Blue");
	ChangeFaction(oBlueFighter,GetObjectByTag("blue_pig"));
	DelayCommand(3.0,ChangeFaction(oBlueFighter,GetObjectByTag("blue_pig")));
	SetLocalObject(oBlueFighter,"oBettor",oPC);
	
	// Blue gets an "unfair" advantage
	eACInc = EffectACIncrease(2);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eACInc, oBlueFighter);
	eAttk = EffectAttackIncrease(2);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eAttk, oBlueFighter);
	
	// Create the Red Team
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(99), rLoc);	
	oRedFighter = CreateObject(OBJECT_TYPE_CREATURE, rTemplate, rLoc, TRUE, "RedFighter");
	oRedFighter = GetNearestObjectByTag("RedFighter"); // workaround createobject bug
	if (GetFirstName(oRedFighter) == "Name") { SetFirstName(oRedFighter, RandomName()); }
	SetLastName(oRedFighter,GetLastName(oRedFighter)+" for the Red");
	ChangeFaction(oRedFighter,GetObjectByTag("red_pig"));	
	DelayCommand(3.0,ChangeFaction(oRedFighter,GetObjectByTag("red_pig")));
	SetLocalObject(oRedFighter,"oBettor",oPC);
	
	AssignCommand(oPC, PlaySound("al_pl_crwdroar1"));
	MusicBattlePlay(GetArea(GetObjectByTag("arena_marius")));
	
	//Attack!
	AssignCommand(oRedFighter, ActionAttack(oBlueFighter));
	AssignCommand(oBlueFighter, ActionAttack(oRedFighter));
	
	// Error Recovery: Delete oBlueFighter after 5 minutes
	DelayCommand(300.0,DestroyObject(oBlueFighter, 2.0));
	DelayCommand(300.0,DestroyObject(oRedFighter, 2.0));
}