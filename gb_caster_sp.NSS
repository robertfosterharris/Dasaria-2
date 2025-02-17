//	ONSPAWN SCRIPT 	BUFFS THE CREATURE USING A COMMA DELIMITED LIST OF SPELL IDS
//					SETS UP THE CASTER FOR COUNTERSPELLING AND DISPELLING
//
//	OBJECT VARIABLES
//	int SpawnScript 	- THE NAME OF THIS SCRIPT (CALLED FROM NW_C2_DEFAULT9)
//	string sBuffList 	- A COMMA DELIMITED LIST OF SPELL IDS (SEE SPELL_* IN NWSCRIPT.NSS)
//	int bDispel;		- (1) HAVE THE CASTER USE DISPELS
//	
//	
//
//	06/30/2007		ROBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM

#include "x0_i0_stringlib"
#include "ginc_ai"

void main()
{
	int bBuffCheat;
	int bCounterSpell;
	int bDispel;
	int bHasSpell;
	int nNth;
	int nSpell;
	string sSpell;
	string sBuffList;
//
//	CAST BUFFS FROM THE COMMA DELIMITED LIST SBUFFLIST
//
	nNth = 0;
	bBuffCheat = GetLocalInt(OBJECT_SELF, "bBuffCheat");
	sBuffList = GetLocalString(OBJECT_SELF, "sBuffList");
	sSpell = GetTokenByPosition(sBuffList, ",", nNth);
	
	while (sSpell != "")
	{
		nSpell = StringToInt(sSpell);
		if ((GetHasSpell(nSpell) || bBuffCheat) && !GetHasSpellEffect(nSpell))
		{
			ActionCastSpellAtObject(nSpell, OBJECT_SELF, METAMAGIC_NONE, bBuffCheat, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		}

		nNth++;
		sSpell = GetTokenByPosition(sBuffList, ",", nNth);
	}
//
//	SET COUNTER CASTING
//	
	bCounterSpell = GetLocalInt(OBJECT_SELF, "bCounterSpell");;
	bDispel = GetLocalInt(OBJECT_SELF, "bDispel");;

	if (bCounterSpell || bDispel)
	{
		if (bDispel && (GetHasSpell(SPELL_I_DEVOUR_MAGIC) || (GetHasSpell(SPELL_I_VORACIOUS_DISPELLING))))
		{
			SetLocalString(OBJECT_SELF, "X2_SPECIAL_COMBAT_AI_SCRIPT", "gai_warlock_dispel");
		}
		else
		{
			AIMakeCounterCaster(OBJECT_SELF, bCounterSpell, bDispel);
		}			
	}		
}