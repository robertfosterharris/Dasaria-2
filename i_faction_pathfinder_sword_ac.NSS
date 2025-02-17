// wired 2008-01-21
// i_faction_pathfinder_sword_ac
// variation on faction admission wands

// let us use PlayCustomAnimation() with a delay
void wrapAnimation(object oActor, string sAnim, int nLoop, float fSpeed);
// faction specific: if there are any pre-reqs, put them here (race, alignment, etc.)
int checkFactionPreReqs(object oTarget);
// faction specific: animations, effects, speakstrings, items, etc.
void wrapFactionAdmit(object oPC, object oTarget);

// intent is to be reusable
void main()
{
	object oPC = GetItemActivator();
	object oTarget = GetItemActivatedTarget();	
	
	effect eFNF = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oPC));
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oTarget));	
	
 	if (checkFactionPreReqs(oTarget))
	{	
		// wait for activate animation to finish 1.36s then play admission fireworks
		DelayCommand(1.36,wrapFactionAdmit(oPC,oTarget));
	}
	else
	{
		// sorry, charlie
		DelayCommand(1.36,AssignCommand(oTarget,SpeakString("I am not worthy to accept this honor.")));
	}
}

// let us use PlayCustomAnimation() with a delay
void wrapAnimation(object oActor, string sAnim, int nLoop, float fSpeed)
{
	PlayCustomAnimation(oActor,sAnim,nLoop,fSpeed);
}

// faction specific: if there are any pre-reqs, put them here (race, alignment, etc.)
int checkFactionPreReqs(object oTarget)
{
	// none
	//return TRUE;
	
	if (GetAlignmentGoodEvil(oTarget) != 5)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

// faction specific: animations, effects, speakstrings, items, etc.
void wrapFactionAdmit(object oPC, object oTarget)
{
	// faction-specific stuff defined here
	string sPlayerName = GetName(oTarget);
	string sWelcome = "Welcome, " + sPlayerName + ", Pathfinder.  Take up this mantle and wear it proudly.";
	string sAccept = "I hereby pledge my life to assist the helpless, defend and preserve civilization against those who would seek to destroy it.";
	string sItemResRef = "faction_pathfinder_cloak";
	effect eGive = EffectVisualEffect(VFX_DUR_SHINING_SHIELD);
	string sSoundToPlay = "as_pl_horngood1";

	// target kneelbows 2.59
	PlayCustomAnimation(oTarget,"kneelbow",1,0.25);
			
	// nonhumans, raise sword for 4 seconds, then salute
	// liftswordloop        4        4
	DelayCommand(0.5, wrapAnimation(oPC,"liftswordloop",0,1.0));
	
	// human and elven males, play the default animation
	// will override the prior command if valid for the model
	DelayCommand(0.5, wrapAnimation(oPC,"knighting",0,1.0));
	
	 //liftsworddown        1        1           
	DelayCommand(4.5, wrapAnimation(oPC,"liftsworddown",0,1.0));
	
	// welcome target to the faction	
	DelayCommand(4.5,AssignCommand(oTarget,SpeakString(sAccept)));
	DelayCommand(5.5,AssignCommand(oPC,SpeakString(sWelcome)));
		
	// give target the item
	CreateItemOnObject(sItemResRef, oTarget);
	
	// some pretty effects on the target		
	DelayCommand(5.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGive, oTarget, 7.0));
	DelayCommand(5.5,AssignCommand(oPC, PlaySound(sSoundToPlay)));    
	DelayCommand(5.5,AssignCommand(oTarget, PlaySound(sSoundToPlay))); 
	// stand up
	DelayCommand(6.0, wrapAnimation(oTarget,"%",0,1.0));
}