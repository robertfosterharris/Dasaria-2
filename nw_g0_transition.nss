////////////////////////////////////////////////////////////
// OnClick/OnAreaTransitionClick
// NW_G0_Transition.nss
// Copyright (c) 2001 Bioware Corp.
////////////////////////////////////////////////////////////
// Created By: Sydney Tang 
// Created On: 2001-10-26
// Description: This is the default script that is called
//              if no OnClick script is specified for an
//              Area Transition Trigger or
//              if no OnAreaTransitionClick script is
//              specified for a Door that has a LinkedTo
//              Destination Type other than None.
////////////////////////////////////////////////////////////
// ChazM 3/3/06 - parameterized GatherPartyTransition()
// BMA-OEI 6/24/06 - Moved transition to AttemptAreaTransition()
// NLC 10/8/08 - Recompiling to catch fixes for NX2. 

// wired ?? oct 2011 >> forward companions through transitions
// wired 01/29/2012  >> stop mounted players from using transitions to an interior area unless marked for it
// wired 02/21/2012  >> include henchmen
// wired 07/28/2012  >> exclude mounts

#include "ginc_transition"
#include "std_inc_mounts"

void main()
{
	object oClicker = GetClickingObject();
	object oTarget = GetTransitionTarget( OBJECT_SELF );
	object oHench;
	object oArea = GetArea(oTarget);
	location lLoc = GetLocation(oClicker);
	int nMax = GetMaxHenchmen();
	int nCounter;
	effect eDeath = EffectDeath(FALSE,FALSE,TRUE,TRUE);
 	object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oClicker);
 	object oAssociate2;
 	object oAssociate3;
 	object oAssociate4;	
	
	if ( 	GetIsObjectValid(oAssociate1) && 					// there is a companion
			GetIsMount(oAssociate1))							// and it's a mount
		{		
			// you're mounted, so your companion should be invisible		
			if (GetIsMounted(oClicker))
			{
				SetScriptHidden(oAssociate1,TRUE,TRUE);
			}
			
			if (		
					GetIsAreaInterior(oArea) == TRUE && 				// and you're headed for an interior
					GetLocalInt(oArea,"nAllowMountedTransition") !=1	// where mounts aren't explicitly permitted
				)
			{
				if (bDEBUG_mounts) SendMessageToPC(oClicker,"DEBUG: Running the nw_g0_transition code to get rid of this mount.");
				SetLocalString(oClicker,"sAreaParkedMount",GetTag(GetArea(oClicker)));
				SetLocalInt(oClicker,"PallyParkedMount",1);			
				RemoveSummonedAssociate(oClicker,oAssociate1);
				RemoveHenchman(oClicker,oAssociate1);
				AssignCommand(oAssociate1,JumpToObject(GetObjectByTag("XC_HIDDEN_WP")));
				ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oAssociate1);		
				DestroyObject(oAssociate1);
			}
		
		}			
	
	// block mounted transition into interior areas unless so marked
	if (!GetCanTransition(oClicker, oArea)) return;
	
	//	set failsafe respawn location 
	//	to spot from which player exited
	//  make sure its a safe location	
	//  it doesn't matter if this is the best place to respawn, it's only used in an
	//  emergency and the mistyvale is the next best location after this failsafe
	location lDefaultAreaRespawn = CalcSafeLocation(oClicker,GetLocation(oClicker),3.0,TRUE,FALSE);
	if (GetIsObjectValid( GetAreaFromLocation(lDefaultAreaRespawn) ) )
	{
		SetLocalLocation(oClicker,"lDefaultAreaRespawn",lDefaultAreaRespawn);
	}		
	
	SetAreaTransitionBMP( AREA_TRANSITION_RANDOM );
	
	AttemptAreaTransition( oClicker, oTarget );
	
	oAssociate2 = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oClicker);
	oAssociate3 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oClicker);
	oAssociate4 = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oClicker);
	
	// wired 07/28/12 don't pull the animal companion if it's limboed
	// becaused that would mean it's a mount and it was put there on purpose
	if (GetIsObjectValid(oAssociate1) &&  GetLocalInt(oAssociate1,"bLimboed") != TRUE) 
	{ 
		if (bDEBUG_mounts) SendMessageToPC(oClicker,"DEBUG: nw_g0_transition is jumping your animal companion");
		DelayCommand(1.0f,AssignCommand( oAssociate1, JumpToObject( oTarget ) )); 		
	}
	
	if (GetIsObjectValid(oAssociate2)) { DelayCommand(1.0f,AssignCommand( oAssociate2, JumpToObject( oTarget ) )); }
	if (GetIsObjectValid(oAssociate3)) { DelayCommand(1.0f,AssignCommand( oAssociate3, JumpToObject( oTarget ) )); }
	if (GetIsObjectValid(oAssociate4)) { DelayCommand(1.0f,AssignCommand( oAssociate4, JumpToObject( oTarget ) )); }
	
	for (nCounter=nMax; nCounter>0; nCounter--)
	{
		oHench = GetHenchman(oClicker,nCounter);
		DelayCommand(1.0f,AssignCommand( oHench, JumpToObject( oTarget ) ));	
	}
}