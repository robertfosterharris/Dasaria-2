// 10/13/2008 	wired	simple destroy on close
// 09/11/2010	rob		destroying an object doesn't make its ondeath event fire.  kill object.
void main()
{
	SetPlotFlag(OBJECT_SELF, FALSE);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
}