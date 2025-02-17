/*
  Simple gladitorial fight script for NWN2 by Wired
  2008/12/30 Wired Updated to autolevel opponent 
*/
#include "std_inc_npc_levelup"
//#include "x2_inc_itemprop"
#include "ginc_group"

void main(string sTemplate, int nDiff)
{
	int nPCHD;
	int nOppHD;
	int nBonus;
	int nRand;
	int nLevel;
	object oPC;
	object oBookie;
	object oGate;
	object oDoor;
	object oOpp;
	location lPCLoc;
	location lOppLoc;
	itemproperty ipEB;
	itemproperty ipDB;
	itemproperty ipAC;
	
	oPC 		=	GetPCSpeaker();
	oBookie		=	GetObjectByTag("arena_marius");
	oGate 		=	GetObjectByTag("arena_gate");
	oDoor		=	GetObjectByTag("arena_upper");
	lPCLoc 		=	GetLocation(GetObjectByTag("arena_spawn2"));
	lOppLoc		=	GetLocation(GetObjectByTag("arena_spawn1"));	
	nPCHD 		=	GetHitDice(oPC);	
	nDiff 		= 	nDiff+GetLocalInt(oPC,"glad_fights");
	nLevel		=	nPCHD+nDiff;
	
	if (sTemplate == "")
	{
		nRand = Random(11);
		switch (nRand)
		{
			case 0:	sTemplate =	"c_cear_gladiator"; break;
			case 1:	sTemplate =	"c_cuhanna_gladiator"; break;
			case 2:	sTemplate =	"c_morel_gladiator"; break;
			case 3:	sTemplate =	"c_telkhmar_gladiator"; break;
			case 4:	sTemplate =	"c_tyrak_gladiator"; break;
			case 5:	sTemplate =	"c_varana_gladiator"; break;
			case 6:	sTemplate =	"c_rel_gladiator"; break;
			case 7:	sTemplate =	"c_ling_gladiator"; break;
			case 8:	sTemplate =	"c_horc_gladiator"; break;
			case 9:	sTemplate =	"c_tersii_gladiator"; break;
			case 10:sTemplate =	"c_daris_gladiator"; 
		}			
	}
	
	// Set up our commoner's group so we can send them a joint command
	if (!GetIsGroupValid("crowd"))
	{		
		GroupAddTag("crowd","arena_stupid_commoner1");
	}		
	
	//Let's close the door first	
	AssignCommand(oGate, ActionCloseDoor(oGate));
	AssignCommand(oGate, SetLocked(oGate, TRUE));
	AssignCommand(oDoor, ActionCloseDoor(oDoor));
	AssignCommand(oDoor, SetLocked(oDoor, TRUE));	
	
	// Instruct Marius not to start any new fights
	SetLocalInt(oBookie,"activefight",1);
	DelayCommand(300.0, DeleteLocalInt(oBookie, "activefight"));  // strip after 5 minutes
	
	// Create the Blue Fighter (PC is Red)	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(99),lOppLoc);
	oOpp = CreateObject(OBJECT_TYPE_CREATURE, sTemplate, lOppLoc, TRUE,"BlueFighter");
	// Level him up!
	DelayCommand(1.0f,DoLevelMeUpTo(oOpp,nLevel));
	// force these scripts as we're reusing the wager fighters now
	SetEventHandler(oOpp,CREATURE_SCRIPT_ON_USER_DEFINED_EVENT,"arena_gladiator_onuserdefined");
	SetEventHandler(oOpp,CREATURE_SCRIPT_ON_DEATH,"arena_gladiator_deathscript");
	
	ChangeFaction(oOpp,GetObjectByTag("blue_pig"));  // just start them in blue
	SetFirstName(oOpp, RandomName());
	if (GetGender(oOpp) == GENDER_FEMALE) SetFirstName(oOpp,GetFirstName(oOpp)+"a");
	
	// Tell the Blue Fighter who they are fighting
	SetLocalObject(oOpp,"oPCFighting",oPC);  // journal will be updated by ondeath() on PC Death, bluefighter on NPC death
		
	// Make blue hate the PC
	AdjustReputation(oPC,oOpp,-50);
	
	// Make his equipment more appropriate
	nOppHD = nPCHD+nDiff;	
	if (nOppHD >= 5) 	nBonus = 1;
	if (nOppHD >= 7)	nBonus = 2;
	if (nOppHD >= 13) 	nBonus = 3;
	if (nOppHD >= 17) 	nBonus = 4;
	//if (nOppHD >= 21) 	nBonus = 5;
	//if (nOppHD >= 25) 	nBonus = 6;	
	
	object oWeapon	=	GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oOpp);
	object oArmor	=	GetItemInSlot(INVENTORY_SLOT_CHEST,oOpp);
	
	ipEB = ItemPropertyEnhancementBonus(nBonus);
	AddItemProperty(DURATION_TYPE_PERMANENT,ipEB,oWeapon);
	ipAC = ItemPropertyACBonus(nBonus);	
	AddItemProperty(DURATION_TYPE_PERMANENT,ipAC,oArmor);	
	
	// Position the PC in the arena
	ForceRest(oPC);	
	DelayCommand(0.5f,AssignCommand(oPC, ActionJumpToLocation(lPCLoc)));
	DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(99), oPC));
	MusicBattlePlay(GetArea(OBJECT_SELF));
	
	AssignCommand(oPC, PlaySound("al_pl_crwdroar1"));
	GroupPlayAnimation("crowd",ANIMATION_FIREFORGET_VICTORY2);
	
	//Attack!
	AssignCommand(oOpp, ActionAttack(oPC));
	
	// Error Recovery: Delete oOpp after 7 minutes
	DelayCommand(420.0,DestroyObject(oOpp, 2.0));
}