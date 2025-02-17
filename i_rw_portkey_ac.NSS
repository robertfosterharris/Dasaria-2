// //i_rw_portkey_ac
//Used for in game teleporting of NPCs

void rw_portkey_destination(object oStoredNPC, location lTarget, int iVFXDisappear1, int iVFXDisappear2, int iVFXAppear1, int iVFXAppear2)
{
effect ePortOut1;
effect ePortOut2;
effect ePortIn1 = EffectVisualEffect(iVFXAppear1);
effect ePortIn2 = EffectVisualEffect(iVFXDisappear2);
AssignCommand(oStoredNPC, ClearAllActions());

if(iVFXDisappear1!=0)
{ 
	ePortOut1  = EffectVisualEffect(iVFXDisappear1);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortOut1, GetLocation(oStoredNPC), 0.0);
}
if(iVFXDisappear2!=0)
{ 
	ePortOut2  = EffectVisualEffect(iVFXDisappear2);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortOut2, GetLocation(oStoredNPC), 0.0);
}
if(iVFXAppear1!=0)
{ 
	ePortIn1 = EffectVisualEffect(iVFXAppear1);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortIn1, lTarget, 0.0);
}
if(iVFXAppear2!=0)
{
	ePortIn1 = EffectVisualEffect(iVFXAppear1); 
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortIn2, lTarget, 0.0);
}
AssignCommand(oStoredNPC, ActionJumpToLocation(lTarget));
}

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
	object oStoredNPC;
    location lTarget = GetItemActivatedTargetLocation();

	int iVFXDisappear1;
	int iVFXDisappear2; 
	int iVFXAppear1;
	int iVFXAppear2;

if	(!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
{
DestroyObject(oItem);
SendMessageToPC(oPC,"DM tool destroyed");
return;
}
	
if(oTarget == OBJECT_INVALID)
{

	oStoredNPC = GetLocalObject(oItem,"StoredNPC");
	iVFXDisappear1 = GetLocalInt(oItem,"iVFXDisappear1");
	iVFXDisappear2 = GetLocalInt(oItem,"iVFXDisappear2"); 
	iVFXAppear1 = GetLocalInt(oItem,"iVFXAppear1");
	iVFXAppear2 = GetLocalInt(oItem,"iVFXAppear2");	
	
	
	if(oStoredNPC == OBJECT_INVALID)
	{
	SendMessageToPC(oPC,"No Stored NPC - Please select one..." );	
	}
	else{
	AssignCommand(oStoredNPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1 ,2.0, 2.0));
	SendMessageToPC(oPC,"Jumping "+GetName(oStoredNPC)+" now" );	
 	DelayCommand(3.0f, rw_portkey_destination(oStoredNPC, lTarget, iVFXDisappear1, iVFXDisappear2, iVFXAppear1, iVFXAppear2));	
	}
}
else
{
	if (GetObjectType(oTarget)  != OBJECT_TYPE_CREATURE) return;
	SetLocalObject(oItem, "StoredNPC", oTarget);
	SendMessageToPC(oPC,"NPC "+GetName(oTarget)+" stored now" );
	SetLocalObject(oPC,"PortKey",oItem);
	AssignCommand(oPC,ActionStartConversation(oPC,"rw_portkey_tool",TRUE,FALSE));

	}
	
	
}