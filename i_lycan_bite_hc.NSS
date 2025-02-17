#include "ginc_lycan"

void main()
{
	object oSpellTarget = GetSpellTargetObject();
	
	if (FortitudeSave(oSpellTarget,GetHitDice(OBJECT_SELF),SAVING_THROW_TYPE_DISEASE) == 0)
	{
		MakeLycan(oSpellTarget, GetLocalInt(std_journal_get( OBJECT_SELF ),"nLycan") );
	}
}