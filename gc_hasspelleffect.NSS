// wired 2008/01/16
// gc_hasspelleffect
int StartingConditional(int nSpellEffect)
{
	if ( GetHasSpellEffect(nSpellEffect,OBJECT_SELF) )
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}