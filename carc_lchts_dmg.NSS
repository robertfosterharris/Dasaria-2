//carc_lchts_dmg
//Damge script for Lochti, making them un-killable by anything but divine or electric damage.
//Just a clone of the troll script.
//-frac
#include "nw_i0_generic"
void TrollRessurect()
{
	// Clears combat round flag to prevent trolls from staring blankly at player
	SetLocalInt(OBJECT_SELF, VAR_X2_L_MUTEXCOMBATROUND, FALSE);
	ClearAllActions(TRUE);
//	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints()),OBJECT_SELF);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(20,6.0),OBJECT_SELF, 54.0);
	ClearAllActions(TRUE);
	SetLocalInt(OBJECT_SELF,"gb_troll_dmg_down",0);
	DetermineCombatRound();
}

void main()
{
	int nAcid = GetDamageDealtByType(DAMAGE_TYPE_DIVINE)+1; //returns -1 if none is dealt, 0 if acid damage was dealt, but a very meager amount
	int nFire = GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL)+1;
	if ((nFire+nAcid)!=0)
	{
		if ((GetCurrentHitPoints()<=nAcid+nFire+1)||GetLocalInt(OBJECT_SELF,"gb_troll_dmg_down"))	//if I am knocked down or near death, this kills me.
		{
			SetImmortal(OBJECT_SELF,FALSE);
			object oTroll = OBJECT_SELF;
			AssignCommand(GetLastDamager(),ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oTroll));
			return;
		}
	}
	//If I'm down, put out a fake "weapon ineffective" message.
	if (GetLocalInt(OBJECT_SELF,"gb_troll_dmg_down")==1)
	{
		FloatingTextStrRefOnCreature(4725,GetLastDamager(),FALSE);	
	}
	else if (GetCurrentHitPoints()<=1)//If I've been beaten down, but am not in a knocked down state, put me in one.
	{	
		//int nDuration = GetMaxHitPoints()/3;	
		int nDuration = d10(1);	
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),OBJECT_SELF,IntToFloat(nDuration));		
		SetLocalInt(OBJECT_SELF,"gb_troll_dmg_down",1);
		DelayCommand(IntToFloat(nDuration-1),TrollRessurect());
	}
	//otherwise, heal 1HP so that the onDamageevent does fire again.
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1),OBJECT_SELF);
	
	ExecuteScript("nw_c2_default6",OBJECT_SELF);
}