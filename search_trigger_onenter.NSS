/*
When the PC enters, do a skill check, and spawn a placeable.

2009/07/25 RW
Hacked about gather_trigger_onenter to make it work for scrolls. 
*/

#include "x0_i0_position"
#include "std_i0_time"
#include "std_i0_skill"

// The find DCs
string kFindSearch = "cfg_find_search";
string kFindLore = "cfg_find_lore";

// Respawn rates
string kRespawn1 = "cfg_respawn_search"; // wired 2008/12/28

int gather_scrollsearch_new( object oTrigger, object oPC, int iSkilltoCheck )
{ 

if(iSkilltoCheck = SKILL_SEARCH)
{

int iSearch = GetLocalInt( oTrigger, kFindSearch );

if ( GetActionMode( oPC, ACTION_MODE_DETECT ) && GetIsSkillSuccessfulPrivate(oPC, SKILL_SEARCH, iSearch) )
{
return TRUE;
}

return FALSE;
}
if(iSkilltoCheck = SKILL_LORE)
{

int iSearch = GetLocalInt( oTrigger, kFindLore );

if (GetIsSkillSuccessfulPrivate(oPC, SKILL_LORE, iSearch) )
{
return TRUE;
}
return FALSE; 
}
//anything else passed end
return FALSE;
}

void main()
{

object oPC = GetEnteringObject();
if ( !GetIsPC(oPC) )
return;

int i; 
int nMaxHerbs = 1;
int nDist;
location lRandom;
location lFinal;
effect eID;
string herb_ownerpc = "herb_ownerpc";
object oArea = GetArea(OBJECT_SELF);
object oTrigger = OBJECT_SELF;

object oScroll;
string sSearchableScrollPile = "sSearchableScrollPile";
string sScroll ="dt2_generic_scroll_2";

int nRespawnSecs = GetLocalInt( oTrigger, kRespawn1 );

int debug = GetLocalInt(oTrigger,"debug");
if (debug) SendMessageToPC(oPC, "Running");

// You can check a trigger every 30 seconds
int elapsed_skillchecks = time_stamp_seconds_elapsed( oTrigger, "skillchecktimestamp");
if ( elapsed_skillchecks < 30 )
{
if (debug) SendMessageToPC(oPC, "Skillcheck Timer: " + IntToString(elapsed_skillchecks) );
return;
}

if (debug) SendMessageToPC(oPC, "Allowed to check");
// Only do checks if there is something to find
int elapsed = time_stamp_seconds_elapsed( oTrigger, "respawntimestamp");
if ( elapsed < nRespawnSecs )
{
if (debug) SendMessageToPC(oPC, "Respawn Timer: " + IntToString(elapsed) );
return;
}

if (debug) SendMessageToPC(oPC, "Something to find");

// Mark the last search, and search
time_stamp_seconds_set( oTrigger, "skillchecktimestamp"); 
if ( !gather_scrollsearch_new(oTrigger, oPC, SKILL_SEARCH) )
return;

if (debug) SendMessageToPC(oPC, "Check Passed");
// Set last spawn timer
time_stamp_seconds_set( oTrigger, "respawntimestamp");

//Lore check here 

if ( !gather_scrollsearch_new(oTrigger, oPC, SKILL_LORE) )
return;



lFinal = GetLocation(GetNearestObjectByTag(sSearchableScrollPile));
// Create the random placeable
oScroll = CreateObject( OBJECT_TYPE_PLACEABLE, sScroll, lFinal, FALSE);

if (!GetIsObjectValid(oScroll) && debug) SendMessageToPC(GetFirstPC(),"Scroll not valid."); 
if (!GetIsObjectValid(oPC) && debug) SendMessageToPC(GetFirstPC(),"PC not valid."); 


// Send message to PC
eID = EffectVisualEffect( VFX_DUR_SPELL_IDENTIFY );
ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eID, oPC, 10.0f); 
SendMessageToPC(oPC, "Scroll spotted!!!!");
}
