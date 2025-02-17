// attrio heartbeat
void main()
{
	if (!IsInConversation(OBJECT_SELF))
	{
		object oTeen1 = GetNearestObjectByTag("2bridges_teen_carmichael");
		object oTeen2 = GetNearestObjectByTag("2bridges_teen_masha");
		object oTeen3 = GetNearestObjectByTag("2bridges_teen_carissa");
		
		int nRandom=Random(7);
		if (nRandom==0)
		{
			PlayCustomAnimation(OBJECT_SELF,"idlefidgetguitar", 1);
			SoundObjectStop(GetObjectByTag("lute"));
			ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);	
			PlayCustomAnimation(oTeen1,"clapping", 0);
			PlayCustomAnimation(oTeen2,"clapping", 0);		
			PlayCustomAnimation(oTeen3,"clapping", 0);	
			
		}
		else if (nRandom==1)
		{
			PlayCustomAnimation(OBJECT_SELF,"idleguitar", 1);
			SoundObjectStop(GetObjectByTag("lute"));
			ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);	
			PlayCustomAnimation(oTeen1,"clapping", 0);
			PlayCustomAnimation(oTeen2,"clapping", 0);		
			PlayCustomAnimation(oTeen3,"clapping", 0);		
		}
		else
		{
			PlayCustomAnimation(OBJECT_SELF,"playguitar", 1);
			SoundObjectPlay(GetObjectByTag("lute"));
			AssignCommand(oTeen1,ActionPlayAnimation(ANIMATION_LOOPING_DANCE01));
			AssignCommand(oTeen2,ActionPlayAnimation(ANIMATION_LOOPING_DANCE01));
			AssignCommand(oTeen3,ActionPlayAnimation(ANIMATION_LOOPING_DANCE01));		
		}
	}
}