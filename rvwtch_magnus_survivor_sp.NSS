//rvwtch_magnus_survivor_sp
#include "ginc_event_handlers"
void main()
{
	effect eCocoon		=	EffectVisualEffect(VFX_SPELL_DUR_COCOON);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eCocoon,OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPetrify(), OBJECT_SELF);
	SaveEventHandlers(OBJECT_SELF);
	SetAllEventHandlers(OBJECT_SELF, SCRIPT_OBJECT_NOTHING);
}