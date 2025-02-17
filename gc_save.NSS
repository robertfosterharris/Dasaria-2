// gc_save
// wired 12/12/2009
//
// this doesn't exist already?  i must be blind
/*
int SAVING_THROW_ALL                    = 0;
int SAVING_THROW_FORT                   = 1;
int SAVING_THROW_REFLEX                 = 2;
int SAVING_THROW_WILL                   = 3;

int SAVING_THROW_CHECK_FAILED           = 0;
int SAVING_THROW_CHECK_SUCCEEDED        = 1;
int SAVING_THROW_CHECK_IMMUNE           = 2;

int SAVING_THROW_TYPE_ALL               = 0;
int SAVING_THROW_TYPE_NONE              = 0;
int SAVING_THROW_TYPE_MIND_SPELLS       = 1;
int SAVING_THROW_TYPE_POISON            = 2;
int SAVING_THROW_TYPE_DISEASE           = 3;
int SAVING_THROW_TYPE_FEAR              = 4;
int SAVING_THROW_TYPE_SONIC             = 5;
int SAVING_THROW_TYPE_ACID              = 6;
int SAVING_THROW_TYPE_FIRE              = 7;
int SAVING_THROW_TYPE_ELECTRICITY       = 8;
int SAVING_THROW_TYPE_POSITIVE          = 9;
int SAVING_THROW_TYPE_NEGATIVE          = 10;
int SAVING_THROW_TYPE_DEATH             = 11;
int SAVING_THROW_TYPE_COLD              = 12;
int SAVING_THROW_TYPE_DIVINE            = 13;
int SAVING_THROW_TYPE_TRAP              = 14;
int SAVING_THROW_TYPE_SPELL             = 15;
int SAVING_THROW_TYPE_GOOD              = 16;
int SAVING_THROW_TYPE_EVIL              = 17;
int SAVING_THROW_TYPE_LAW               = 18;
int SAVING_THROW_TYPE_CHAOS             = 19;

*/
int StartingConditional(int nMajor, int nDC, int nMinor = 0)
{
	object oPC = GetPCSpeaker();
	
	if (nMajor == 1)return FortitudeSave(oPC, nDC, nMinor);
	if (nMajor == 2)return ReflexSave(oPC, nDC, nMinor);
	if (nMajor == 3)return WillSave(oPC, nDC, nMinor);
	else return FALSE;
}