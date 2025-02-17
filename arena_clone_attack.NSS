// from two snippets of code found on bioware boards, heavy editing by wired 10/2/07
//#include "nw_i0_generic"
#include "ginc_group"

void RemoveAllProperties(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipProperty))
    {
        RemoveItemProperty(oItem, ipProperty);
        ipProperty = GetNextItemProperty(oItem);
    }
}
void main()
{
    object oPC = GetPCSpeaker();
    string sName = GetName(oPC);
    string sClone = "BlueFighter";
    object oSpawn = GetWaypointByTag("arena_spawn1");
    location lLoc = GetLocation(oSpawn);

	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(99),lLoc);
    object oClone = CopyObject(oPC, lLoc, OBJECT_INVALID, sClone);
	// getobjectbytag() = workaround for 1.10 broken copyobject()
	//object oClone = GetObjectByTag(sClone); 
	
	AssignCommand(oClone,SetIsDestroyable(TRUE,FALSE,FALSE));

		// let's buff the clone up a little, yes?
	effect eSRInc = EffectSpellResistanceIncrease(30);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eSRInc, oClone);
	effect eACInc = EffectACIncrease(10);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eACInc, oClone);
	effect eImmuneKD = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
	effect eImmuneCrit = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eImmuneKD, oClone);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eImmuneCrit, oClone);
	effect eAttk = EffectAttackIncrease(5);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eAttk, oClone);
	ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, oClone,METAMAGIC_ANY,TRUE);
	
	// we don't want them dropping a full duplicate of the PCs inventory, so...
    int i = 0;
    object oGear;
    for (i = INVENTORY_SLOT_HEAD; i <= INVENTORY_SLOT_CARMOUR; i++)
    {
        oGear = GetItemInSlot(i, oClone);
        if (GetIsObjectValid(oGear) == TRUE)
        {
            SetDroppableFlag(oGear, FALSE);
            RemoveAllProperties(oGear);
        }
    }
    oGear = GetFirstItemInInventory(oClone);
    while (oGear != OBJECT_INVALID)
    {
        SetDroppableFlag(oGear, FALSE);
        RemoveAllProperties(oGear);
        oGear = GetNextItemInInventory(oClone);
    }
    int iGold = GetGold(oClone);
    TakeGoldFromCreature(iGold, oClone, TRUE);
	
	ChangeFaction(oClone,GetObjectByTag("blue_pig"));  // just start them in blue	
	// Tell the Blue Fighter who they are fighting
	SetLocalObject(oClone,"oPCFighting",oPC);  // journal will be updated by ondeath() on PC Death, bluefighter on NPC death
		
	// Make blue hate the PC
	AdjustReputation(oPC,oClone,-50);		

	//Let's close the door first	
	object oGate = GetObjectByTag("arena_gate");
	object oDoor = GetObjectByTag("arena_upper");
	AssignCommand(oGate, ActionCloseDoor(oGate));
	AssignCommand(oGate, SetLocked(oGate, TRUE));
	AssignCommand(oDoor, ActionCloseDoor(oDoor));
	
	// Error Recovery: Delete oClone after 10 minutes
	DelayCommand(600.0,DestroyObject(oClone, 2.0));

	// Add a special OnDeath handler
   	SetEventHandler( oClone, CREATURE_SCRIPT_ON_DEATH, "arena_gladiator_deathscript" );
	
	// Earmark me as the clone
	SetLocalInt(oClone, "clone",1);
	
	// Set up our commoner's group so we can send them a joint command
	if (!GetIsGroupValid("crowd"))
	{		
		GroupAddTag("crowd","arena_stupid_commoner1");
	}	
	
	AssignCommand(oPC, PlaySound("al_pl_crwdroar1"));
	GroupPlayAnimation("crowd",ANIMATION_FIREFORGET_VICTORY2);	

    AssignCommand(oClone, ClearAllActions());
    AssignCommand(oClone, ActionEquipMostDamagingMelee(oPC));
    DelayCommand(2.0, AssignCommand(oClone, ActionAttack(oPC)));
}