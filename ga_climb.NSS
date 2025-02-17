/////////////////////////////////////////////////////////
//                                                     //
//  Markshire Climbing System - By Thrym of Markshire  //
//                                                     //
//  Created: 3/17/07                                   //
//                                                     //
/////////////////////////////////////////////////////////

// ***** FUNCTION DECLARATIONS ***** //

// Determine if the PC can climb
// Fails if oClimber has anything in their right hand
// or are fully overloaded with encumbrance.
int ms_ClimbCheck(object oClimber);

// Returns the penalty (if any for oClimber)
// Heavey Encumbrance Penalty = +3
// Armor Check Penalty = +2/+4/+7 dependent
// Stealth Penalty = +5
int ms_CalcClimbPenalty(object oClimber);

// Returns the bonus (if any) for oClimber
// Climbing Gear Equipped Bonus = varies
// Climbing Magic Item (on person) Bonus = varies
// Halfling Race Bonus = +2
// Size Large or Greater Bonus = +2
int ms_CalcClimbBonus(object oClimber);

// Returns Success of an Ability
// Includes minor failure (5 or less under DC)
// and critical failure
// (termed as critical but only to differentiate between failure types)
int ms_GetAbilityCheckSuccessful(object oTarget, int iAbility, int iDC);

// Handle the move to the new location.
void ms_ClimbToDestination(object oClimber);

// Cause oClimber to animate falling down.
void ms_FallAnimation(object oClimber);


// ***** MAIN FUNCTION ***** //

void main ()
{
     object oPC = GetLastUsedBy();

     /*
     SendMessageToPC(oPC, "You have clicked on " + GetTag(OBJECT_SELF));
     int iDebugDC  = GetLocalInt(OBJECT_SELF, "CLIMB_BASE_DC");
     int iDebugHT  = GetLocalInt(OBJECT_SELF, "CLIMB_HEIGHT");
     int iDebugDIR = GetLocalInt(OBJECT_SELF, "CLIMB_DIRECTION");
     SendMessageToPC(oPC, "It's variables are...");
     SendMessageToPC(oPC, "Climb DC: " + IntToString(iDebugDC));
     SendMessageToPC(oPC, "Climb Height: " + IntToString(iDebugHT));
     SendMessageToPC(oPC, "Climb Direction: " + IntToString(iDebugDIR));     */

     if (GetLocalString(OBJECT_SELF, "CLIMB_DESTINATION") == "")
     {
          SendMessageToPC(oPC, "ERROR: Please inform the admins that this climb point has no destination. "
                                    + GetTag(OBJECT_SELF) + " in " + GetName(GetArea(OBJECT_SELF)));
          return;
     }

     // If the user is a DM just send em.
     if (GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE)
     {
          ms_ClimbToDestination(oPC);
          return;
     }

     // If they fail the check stop.
     if (ms_ClimbCheck(oPC) == FALSE) return;

     // Now we concern ourselves with variables
     int iDC = ms_CalcClimbPenalty(oPC) + GetLocalInt(OBJECT_SELF, "CLIMB_BASE_DC") - ms_CalcClimbBonus(oPC);
     int iHeight = GetLocalInt(OBJECT_SELF, "CLIMB_HEIGHT");
     int iDirection = GetLocalInt(OBJECT_SELF, "CLIMB_DIRECTION");

     int iDamage;
     int iAbility = ABILITY_STRENGTH;

     if (GetResRef(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)) == "arm_climbinggear") iAbility = ABILITY_DEXTERITY;


     // Check their success.
     switch (ms_GetAbilityCheckSuccessful(oPC, iAbility, iDC))
     {
          case 0: // Critical Failure
               iHeight = iHeight > 20 ? 20 : iHeight;
               iDamage = d6(iHeight > 1 ? iHeight : 1);
               if (iDirection == 0) DelayCommand(1.5, ms_ClimbToDestination(oPC));
               DelayCommand(2.0, ms_FallAnimation(oPC));
               DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(iDamage), oPC));
               SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
               break;

          case 1:  // Minor Failure
               iHeight = iHeight/2 > 20 ? 20 : iHeight/2;
               iDamage = d6(iHeight/2 > 1 ? iHeight/2 : 1);
               if (iDirection == 0) DelayCommand(1.5, ms_ClimbToDestination(oPC));
               DelayCommand(2.0, ms_FallAnimation(oPC));
               DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(iDamage), oPC));
               SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
               break;

          case 2: // Success
               DelayCommand(1.5, ms_ClimbToDestination(oPC));
               break;
     }
}


// ***** FUNCTION ***** //

// Returns the penalty (if any for oClimber)
// Heavey Encumbrance Penalty = +3
// Armor Check Penalty = +2/+4/+7 dependent
// Stealth Penalty = +5
int ms_CalcClimbPenalty(object oClimber)
{
     object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oClimber);
     object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oClimber);

     int iEncumbrance = GetEncumbranceState(oClimber);

     int iPenalty = 0;

     if (iEncumbrance == ENCUMBRANCE_STATE_HEAVY) iPenalty = iPenalty + 3;

     switch (GetArmorRank(oArmor))
     {
          case ARMOR_RANK_LIGHT:  iPenalty = iPenalty + 2; break;
          case ARMOR_RANK_MEDIUM: iPenalty = iPenalty + 4; break;
          case ARMOR_RANK_HEAVY:  iPenalty = iPenalty + 7; break;
     }

     if (GetStealthMode(oClimber) == STEALTH_MODE_ACTIVATED) iPenalty = iPenalty + 5;

     return iPenalty;
}

// Returns the bonus (if any) for oClimber
// Climbing Gear Equipped Bonus = varies
// Climbing Magic Item (on person) Bonus = varies
// Halfling Race Bonus = +2
// Size Large or Greater Bonus = +2
int ms_CalcClimbBonus(object oClimber)
{
     object oItem;
     int iBonus = 0;

     // Check for items that are equipped only.

     // Climbing Gloves
     if (GetResRef(GetItemInSlot(INVENTORY_SLOT_ARMS, oClimber)) == "glv_climbinggloves") iBonus = iBonus + 2;

     // Ring of Feather Falling (Either Hand but not both)
     if (GetResRef(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oClimber)) == "rin_ringoffeatherfalling" ||
          GetResRef(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oClimber)) == "rin_ringoffeatherfalling")
          {iBonus = iBonus + 5;}

     // Check the PC for each of the possible climbing magic item resrefs.

     oItem = GetFirstItemInInventory(oClimber);
     string sResRef = GetResRef(oItem);

     while (oItem != OBJECT_INVALID)
     {
          sResRef = GetResRef(oItem);

          // if (sResRef == "resref_of_climbing_item") iBonus = iBonus + 1;

          oItem = GetNextItemInInventory(oClimber);
     }

     if (GetRacialType(oClimber) == RACIAL_TYPE_HALFLING) iBonus = iBonus + 2;

     if (GetCreatureSize(oClimber) >= CREATURE_SIZE_LARGE) iBonus = iBonus + 2;

     return iBonus;

}

// Returns the penalty (if any for oClimber)
// Based on Armor, Encumbrance, and type of gear in hand
int ms_ClimbCheck(object oClimber)
{
     object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oClimber);
     object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oClimber);
     object oPrimary = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oClimber);

     int iEncumbrance = GetEncumbranceState(oClimber);
     int iTwoHanded;
     string sError = "";

     // Set Error Message if their offhand is occupied
     if (GetIsObjectValid(oShield) == TRUE) sError = "You can't climb with your left hand occupied";

     // Set Error Message if they are carrying WAY to much gear
     if (iEncumbrance == ENCUMBRANCE_STATE_OVERLOADED) sError = "You are too encumbered to climb.";

     switch (GetBaseItemType(oPrimary))
     {
          case BASE_ITEM_DIREMACE:        iTwoHanded = 1; break;
          case BASE_ITEM_DOUBLEAXE:       iTwoHanded = 1; break;
          case BASE_ITEM_GREATAXE:        iTwoHanded = 1; break;
          case BASE_ITEM_GREATSWORD:      iTwoHanded = 1; break;
          case BASE_ITEM_HALBERD:         iTwoHanded = 1; break;
          case BASE_ITEM_HEAVYCROSSBOW:   iTwoHanded = 1; break;
          case BASE_ITEM_FALCHION:        iTwoHanded = 1; break;
          case BASE_ITEM_HEAVYFLAIL:      iTwoHanded = 1; break;
          case BASE_ITEM_QUARTERSTAFF:    iTwoHanded = 1; break;
          case BASE_ITEM_SCYTHE:          iTwoHanded = 1; break;
          case BASE_ITEM_SHORTSPEAR:      iTwoHanded = 1; break;
          case BASE_ITEM_TWOBLADEDSWORD:  iTwoHanded = 1; break;
          case BASE_ITEM_WARMACE:         iTwoHanded = 1; break;
          default:  iTwoHanded = 0; break;
     }

     if (iTwoHanded == 1) sError = "You can't climb with a two-handed weapon out.";

     int iTotalDC = GetLocalInt(OBJECT_SELF, "CLIMB_BASE_DC") + ms_CalcClimbPenalty(oClimber);

     // Give them a chance to realize the climb is TOO difficult
     if (iTotalDC > 20 + ms_CalcClimbBonus(oClimber) )
     {
          if (GetIsSkillSuccessful(oClimber, SKILL_SPOT, 18)) sError = "You feel that you won't make the climb under these conditions";
     }

     // PC Fails conditions to climb
     // Let em know and return FALSE
     if (sError != "")
     {
          FloatingTextStringOnCreature(sError, oClimber, FALSE);
          return FALSE;
     }

     // PC Passed conditions
     // Return TRUE
     return TRUE;
}

// Returns Success of an Ability
// Includes minor failure (5 or less under DC)
// and critical failure
// (termed as critical but only to differentiate between failure types)
int ms_GetAbilityCheckSuccessful(object oTarget, int iAbility, int iDC)
{
     int iCheck = GetAbilityModifier(iAbility, oTarget);

     switch(GetIsInCombat(oTarget))
     {
          case TRUE:
               iCheck = iCheck + d20();
               break;

          case FALSE:
               switch (iCheck + 10 >= iDC)
               {
                    case TRUE:  iCheck = iCheck + 10;    break;
                    case FALSE: iCheck = iCheck + d20(); break;
               }
               break;
     }

     // DEBUG
     // SendMessageToPC(oTarget, "<color=green>You rolled: " + IntToString(iCheck) +"</color>");
     // SendMessageToPC(oTarget, "<color=blue>The adjusted DC: " + IntToString(iDC) +"</color>");

     if (iCheck >= iDC) return 2;
     if (iCheck <= iDC-5) return 0;
     return 1;
}

// Handle the move to the new location.
void ms_ClimbToDestination(object oClimber)
{
     object oDestination = GetObjectByTag(GetLocalString(OBJECT_SELF, "CLIMB_DESTINATION"));

     AssignCommand(oClimber, ClearAllActions());
     AssignCommand(oClimber, ActionJumpToObject(oDestination, FALSE));
}

void ms_FallAnimation(object oClimber)
{
          AssignCommand(oClimber, ClearAllActions());
          AssignCommand(oClimber, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0));
          AssignCommand(oClimber, SpeakString("*" + GetName(oClimber) + " falls down*"));
}