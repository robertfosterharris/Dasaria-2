//	MODULE SPELL HOOK
//
//	PREVENTS UNAPPROVED MOTB SPELLS FROM BEING CAST
//
//	01/10/2007	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//	10/02/2008 	WIRED 			ADDED SPELLTRACKING HOOK
//	11/25/2008	ROBERT HARRIS	ADDED GETISSTAFF FOR MOTB SPELLS
//	12/01/2008	ROBERT HARRIS	ALLOW MOTB SPELL CASTING
//	12/17/2008	WIRED			FAIL SPELLS FOR EVIL PALADINS
//	10/03/2009  WIRED			REMOVE SPELLTRACKING HOOK
//  11/31/2009  Wired			Restore Spelltracking Hook
//	02/21/2010	Wired			Per-area hook
//  08/09/2011  Wired			Work around quickcast exploit for polymorphed PCs
//	02/04/2012  Wired			Control Mounted Spellcasting
//  07/06/2012  Wired 			Hard quickcast exploit workaround (include wildshape)
//  01/27/2013  Wired			Bardsong hook?
//  02/02/2013  Wired			AVOID META MAGIC ITEM EXPLOITS

#include "x2_inc_switches"
#include "std_inc_mounts"
#include "std_i0_misc"
#include "std_inc_bardsong"

void main()
{
	int nSpell;	 
	int bDEBUG = FALSE;
	nSpell = GetSpellId();
	
	string sAreaSpellHook = GetLocalString(GetArea(OBJECT_SELF),"sAreaSpellHook");
	
	if (bDEBUG) SendMessageToPC(OBJECT_SELF,"DEBUG: SpellHook Running on Spell "+IntToString(nSpell));
	
	SetLocalInt(OBJECT_SELF, "LASTSPELL",nSpell);
	
	// MOUNTED SPELLCASTING (item OR spell)
	if (GetIsMounted(OBJECT_SELF))	// you're mounted
	{
		if (bDEBUG_mounts) SendMessageToPC(OBJECT_SELF,"DEBUG: GetIsMounted was just called from mod_spell_script, spell was !"+IntToString(nSpell));
		if (!CheckMountedSpell(OBJECT_SELF,nSpell))	// you failed your concentration check
		{
				SetModuleOverrideSpellScriptFinished();
				return;		
		}
	}
	
	//	IGNORE SPELLS CAST FROM AN ITEM
	if(GetIsObjectValid(GetSpellCastItem())){return;}	

	// RW: CUSTOM WORD OF CHANGING SCRIPT
	// wired 08/16/2011 do the least amount of work possible
	if(nSpell == 843)	
	{
		if (GetDeity(OBJECT_SELF) == "Teshalia (Ishtar)")
		{
			if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
			{
				ExecuteScript("nw_s0_iwordchng_das2",OBJECT_SELF);
			}
		}
	}
	
	// AVOID META MAGIC ITEM EXPLOITS
	if (
		( GetMetaMagicFeat() == METAMAGIC_SILENT && !GetHasFeat(FEAT_SILENCE_SPELL,OBJECT_SELF) ) ||
		( GetMetaMagicFeat() == METAMAGIC_STILL && !GetHasFeat(FEAT_STILL_SPELL,OBJECT_SELF) )
		)
		{
			SetModuleOverrideSpellScriptFinished();
			SendMessageToPC(OBJECT_SELF, "You lack the appropriate feat to use this metamagic!");
		}
	
	// POLYMORPH QUICK CAST ANTI-EXPLOIT
	if (GetIsShapechanged(OBJECT_SELF))
	{
		// you are a druid with the natural spell feat
		if (GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF) > 0 && GetHasFeat(FEAT_NATURAL_SPELL,OBJECT_SELF))
		{	
			// carry on!
		}
		// everybody else
		else
		{
			// surprise, motherfucker!
			CloseGUIScreen(OBJECT_SELF,"SCREEN_SPELLS_QUICK");  
			SetModuleOverrideSpellScriptFinished();
			SendMessageToPC(OBJECT_SELF, "Cannot cast spells while polymorphed.");
			return;	
		}	
	}
		
	//  NO SPELLS FOR EVIL PALADINS
	if ((GetLastSpellCastClass() == CLASS_TYPE_PALADIN && (GetAlignmentGoodEvil(OBJECT_SELF) != ALIGNMENT_GOOD || GetAlignmentLawChaos(OBJECT_SELF) != ALIGNMENT_LAWFUL)))
	{
			SetModuleOverrideSpellScriptFinished();
			SendMessageToPC(OBJECT_SELF, "You have forsaken the path of the righteous.  The Gods will grant you no spells until you return to the path.");
	}
		
	if ( (	GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF) > 0 && ( GetAlignmentGoodEvil(OBJECT_SELF) != ALIGNMENT_NEUTRAL && GetAlignmentLawChaos(OBJECT_SELF) != ALIGNMENT_NEUTRAL ))	)
	{
			SetModuleOverrideSpellScriptFinished();
			SendMessageToPC(OBJECT_SELF, "You have left the path of balance,  Ioasia grants you no spells until you return to her path.");
	}
	

//	SKIP SPELL-LIKE ABILITIES

	if ( 
		(nSpell <= 549) 						// 1-549 initial NWN2 spells
		|| (nSpell >= 845 && nSpell <= 900) 	// 845-900 3.5E spells
		|| (nSpell == 967)						// least spell mantle (straggler)
		|| (nSpell >= 969 && nSpell <= 1046) 	// MOTB Spell Range
		&& (nSpell !=985)						// devour magic spelllikeability (straggler)
		)
	{
  		string sSpells = GetLocalString(OBJECT_SELF, "Spells");
  		SetLocalString(OBJECT_SELF, "Spells", sSpells + IntToString(GetSpellId()) + ":");
	}
	
	if (sAreaSpellHook !="")
	{
		//AddScriptParameterInt(nSpell);
		// We don't need to pass param because up above we set: SetLocalInt(OBJECT_SELF, "LASTSPELL",nSpell);
		ExecuteScript(sAreaSpellHook,OBJECT_SELF);
		//	Spell may continue normally, so set finished in the override
		// 	SetModuleOverrideSpellScriptFinished();
	}
	
	if (GetLastSpellCastClass() == CLASS_TYPE_BARD && GetLocalInt(OBJECT_SELF,"BardHotBarBypass") != 1)
	// am i a bard?  sing for your dinner!
	{
			d2_PlayBardSongSound();
	}
}