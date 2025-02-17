// ga_dmg

void main(int nDmg = 1, int nType = DAMAGE_TYPE_ALL )
{ 
	object oPC = GetPCSpeaker();
	ApplyEffectToObject(	DURATION_TYPE_INSTANT,EffectDamage(nDmg,nType,0,0),oPC	);

}