/*
	11/13/06	RFH		Set GetExitingObject to GetEnteringObject
						Changed condtion to check for != True instead of == 0
    04/29/07    RFH     DON'T SWEEP - SWEEP ONLY ON AREA EXIT
	02/14/09	Wired	Moved RW's spawnsystem code here
	08/22/10	Wired	lDefaultAreaRespawn goes here again
	14/01/14	RW 		Added Custom Human code
*/
#include "std_persist_i0"
#include "ginc_custom_races"
#include "ginc_gui_d2_languages"


#include "j4acs_uglyhack"
#include "ginc_spawnsystem"
#include "d2_sql_log"
#include "std_inc_mounts"

void main()
{
	object oPC;
	location lDefaultAreaRespawn;
 	object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
	object oJournal;	
	effect eDeath = EffectDeath(FALSE,FALSE,TRUE,TRUE);
	int iDoAtFirstLogin;
//
//	TRANSITION TESTING CODE
//
	oPC = GetFirstEnteringPC();
	while (GetIsObjectValid(oPC))
	{
		//	set failsafe respawn location 
		//	to spot from which player exited
		//  make sure its a safe location
		//  it doesn't matter if this is the best place to respawn, it's only used in an
		//  emergency and the mistyvale is the next best location after this failsafe			
		lDefaultAreaRespawn = CalcSafeLocation(oPC,GetLocation(oPC),3.0,TRUE,FALSE);
		if (GetIsObjectValid( GetAreaFromLocation(lDefaultAreaRespawn) ) )
		{
			SetLocalLocation(oPC,"lDefaultAreaRespawn",lDefaultAreaRespawn);
		}
		
		FetchMountFromLimbo(oPC);
		
		// temporary code... if i somehow got in here with a mount/companion, nuke it!
		//
		if ( 	GetIsObjectValid(oAssociate1) && 					// there is a companion
				GetIsMount(oAssociate1) &&							// and it's a mount
				GetIsAreaInterior(OBJECT_SELF) && 						// and you're headed for an interior
				GetLocalInt(OBJECT_SELF,"nAllowMountedTransition") !=1	// where mounts aren't explicitly permitted
			)
		{
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Running the failsafe code in j4acs_ha_oce to get rid of this mount");
			RemoveSummonedAssociate(oPC,oAssociate1);
			RemoveHenchman(oPC,oAssociate1);
			AssignCommand(oAssociate1,JumpToObject(GetObjectByTag("XC_HIDDEN_WP")));
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oAssociate1);		
			DestroyObject(oAssociate1);			
		}		
	
		if (!GetIsDM(oPC))
		{
		
			oJournal = std_journal_get(oPC);
			iDoAtFirstLogin = GetLocalInt(oPC, "iDoAtFirstLogin" );
			
			if(GetLocalInt( oJournal, "std_login_count") ==1 && iDoAtFirstLogin == 0)
			{
			
				SetLocalInt( oPC, "iDoAtFirstLogin", 1);
				
				if(GetSubRace(oPC) == RACIAL_SUBTYPE_HUMAN )
				{
					OpenHumanGUI(oPC);
				}
				else
				{
				
					SetLocalInt(oPC, "iCloseLanguageGUI", 1);
					
									
					if(	GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0 )	
					{
						if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_KALEM)), oPC) )
						{
							AddSelectLanguageFeatToPC( oPC, LNG_KALEM);
						}
						
					}
			
					if(	GetLevelByClass(CLASS_TYPE_DRAGON, oPC) > 0 )	
					{
						if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRAGON_D)), oPC) )
						{
							AddSelectLanguageFeatToPC( oPC, LNG_DRAGON_D );
						}
						
					}
					
					if(	GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0 || GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0 )	
					{
						if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DAWN_TONGUE)), oPC) )
						{
							AddSelectLanguageFeatToPC( oPC, LNG_DAWN_TONGUE );
						}
							
					}
					
					if(	GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 )	
					{
						if(!GetHasFeat(StringToInt(Get2DAString(LANG_DAS_2DA, LANG_COL_FT, LNG_DRUID_D)), oPC) )
						{
							AddSelectLanguageFeatToPC( oPC, LNG_DRUID_D );
						}
					}				
				
					Build_LanguageTable_For_GUI(oPC);
					DisplayGuiScreen(oPC, LNG_GUINAME, FALSE, LNG_XMLNAME); 
					DoLanguageListbox(oPC, LNG_GUINAME, LNG_XMLNAME);				
				}
			
			}
		
			//	default spawn point logic
			ManageDasariaSpawnEnter(oPC);
			
			trackEvent(oPC,"AREA_ENTER",OBJECT_INVALID,0,0,GetLocalString(oPC, "LastEntry"),GetLocalString(oPC, "LastExit"));
			WriteTimestampedLogEntry ("	Transition v1.7:	" + GetLocalString(oPC, "PlayerName") + "	" + GetName(oPC) + "	" + GetLocalString(oPC, "LastExit") + "	" + GetLocalString(oPC, "LastEntry") + "	0");
			DeleteLocalInt(oPC, "TransitionState");
						
		}
		oPC = GetNextEnteringPC();
	}
	

}

/*

	11/13/06	RFH		Set GetExitingObject to GetEnteringObject
						Changed condtion to check for != True instead of == 0
    04/29/07    RFH     DON'T SWEEP - SWEEP ONLY ON AREA EXIT
	02/14/09	Wired	Moved RW's spawnsystem code here
	08/22/10	Wired	lDefaultAreaRespawn goes here again
	14/01/14


#include "j4acs_uglyhack"
#include "ginc_spawnsystem"
#include "d2_sql_log"
#include "std_inc_mounts"

void main()
{
	object oPC;
	location lDefaultAreaRespawn;
 	object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);	
	effect eDeath = EffectDeath(FALSE,FALSE,TRUE,TRUE);
//
//	TRANSITION TESTING CODE
//
	oPC = GetFirstEnteringPC();
	while (GetIsObjectValid(oPC))
	{
		//	set failsafe respawn location 
		//	to spot from which player exited
		//  make sure its a safe location
		//  it doesn't matter if this is the best place to respawn, it's only used in an
		//  emergency and the mistyvale is the next best location after this failsafe			
		lDefaultAreaRespawn = CalcSafeLocation(oPC,GetLocation(oPC),3.0,TRUE,FALSE);
		if (GetIsObjectValid( GetAreaFromLocation(lDefaultAreaRespawn) ) )
		{
			SetLocalLocation(oPC,"lDefaultAreaRespawn",lDefaultAreaRespawn);
		}
		
		FetchMountFromLimbo(oPC);
		
		// temporary code... if i somehow got in here with a mount/companion, nuke it!
		//
		if ( 	GetIsObjectValid(oAssociate1) && 					// there is a companion
				GetIsMount(oAssociate1) &&							// and it's a mount
				GetIsAreaInterior(OBJECT_SELF) && 						// and you're headed for an interior
				GetLocalInt(OBJECT_SELF,"nAllowMountedTransition") !=1	// where mounts aren't explicitly permitted
			)
		{
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Running the failsafe code in j4acs_ha_oce to get rid of this mount");
			RemoveSummonedAssociate(oPC,oAssociate1);
			RemoveHenchman(oPC,oAssociate1);
			AssignCommand(oAssociate1,JumpToObject(GetObjectByTag("XC_HIDDEN_WP")));
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oAssociate1);		
			DestroyObject(oAssociate1);			
		}		
	
		if (!GetIsDM(oPC))
		{

			//	default spawn point logic
			ManageDasariaSpawnEnter(oPC);
			
			trackEvent(oPC,"AREA_ENTER",OBJECT_INVALID,0,0,GetLocalString(oPC, "LastEntry"),GetLocalString(oPC, "LastExit"));
			WriteTimestampedLogEntry ("	Transition v1.7:	" + GetLocalString(oPC, "PlayerName") + "	" + GetName(oPC) + "	" + GetLocalString(oPC, "LastExit") + "	" + GetLocalString(oPC, "LastEntry") + "	0");
			DeleteLocalInt(oPC, "TransitionState");
						
		}
		oPC = GetNextEnteringPC();
	}
	

}