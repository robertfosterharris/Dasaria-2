// 2bridges_nightwig_ondam
// OnDamaged script for Nightwig
// wired 12/19/07

#include "NW_I0_GENERIC"

void main()
{
	int nEvent = GetUserDefinedEventNumber();
	
	switch( nEvent )
	{
		case EVENT_DAMAGED:
		{
			object oPC = GetLastHostileActor();
			// if PC isn't on the quest, ignore this
			if (GetJournalEntry("2bridges_dragon",oPC) > 0 &&
				GetJournalEntry("2bridges_dragon",oPC) < 5)
			{
				int nHP = GetCurrentHitPoints( OBJECT_SELF );
				int nMaxHP = GetMaxHitPoints( OBJECT_SELF );
				float CUR_HP = IntToFloat(nHP)/IntToFloat(nMaxHP);
				float MIN_HP = 0.15f;
					
				if ( CUR_HP < MIN_HP )
				{					
					ClearAllActions( TRUE );
					SurrenderToEnemies();					
					SetPlotFlag(OBJECT_SELF,TRUE); 
					effect eHeal = EffectHeal(200);
    				effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    			    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);	
					ActionStartConversation(oPC,"2bridges_nightwig");		
					SetPlotFlag(OBJECT_SELF,FALSE);
			    }
			}
			else
			{
				SetImmortal(OBJECT_SELF,FALSE);
			}		
		}
		break;		
	}
    return;
}