/*
*/


void main()
	{
	object oPix = OBJECT_SELF;
	
	object oArea = oArea;
	
	object  oWounded = GetFirstObjectInArea(oArea);
	while ( GetIsObjectValid(oWounded) )
		{
		if (GetCurrentHitPoints(oWounded) < -5 )
			{
			ActionCastSpellAtObject( SPELL_HEAL, oWounded, METAMAGIC_ANY, TRUE);
			SpeakString( "You are wounded!" );			
			}
		
		oWounded = GetNextObjectInArea(oArea);
		}
	}