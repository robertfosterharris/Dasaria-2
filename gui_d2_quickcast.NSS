// gui_d2_quickcast

#include "std_i0_misc"

void main()
{
	object oPC = OBJECT_SELF;
	
	if (!GetIsObjectValid(oPC) || GetIsDM(oPC)) return;
	
	if (GetIsShapechanged(oPC))
	{
		if (GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF) && GetHasFeat(FEAT_NATURAL_SPELL,OBJECT_SELF))
		{
			//do nothing
		}
		else
		{
			CloseGUIScreen(oPC,"SCREEN_SPELLS_QUICK");
		}
	}
}