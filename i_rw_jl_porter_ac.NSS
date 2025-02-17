// //i_rw_jl_porter_ac

//Used for in game teleporting of JiLyn

void rw_jl_port_destination(object oStoredJiLyn, location lTarget)
{
effect ePortOut  = EffectVisualEffect(VFX_FNF_IMPLOSION);
effect ePortIn1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
effect ePortIn2 = EffectVisualEffect(VFX_IMP_FLAME_M);
AssignCommand(oStoredJiLyn, ClearAllActions());
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortOut, GetLocation(oStoredJiLyn), 0.0);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortIn1, lTarget, 0.0);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortIn2, lTarget, 0.0);
AssignCommand(oStoredJiLyn, ActionJumpToLocation(lTarget));
}

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
	object oStoredJiLyn;
    location lTarget = GetItemActivatedTargetLocation();

	string sJiLynTagCheck;

if(oTarget == OBJECT_INVALID)
{

	oStoredJiLyn = GetLocalObject(oItem,"StoredJiLyn");
	if(oStoredJiLyn == OBJECT_INVALID)
	{
	SendMessageToPC(oPC,"No Stored JiLyn - Please select one..." );	
	}
	else{
	AssignCommand(oStoredJiLyn, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1 ,2.0, 2.0));
	SendMessageToPC(oPC,"Jump Time!" );	
 	DelayCommand(3.0f, rw_jl_port_destination(oStoredJiLyn,lTarget));	
	}
}
else
{
	if (GetObjectType(oTarget)  != OBJECT_TYPE_CREATURE) return;
	
	sJiLynTagCheck = GetTag(oTarget);
	if(FindSubString(sJiLynTagCheck, "jilyn") == -1) return;
	SetLocalObject(oItem, "StoredJiLyn", oTarget);
	SendMessageToPC(oPC,"JiLyn stored now :}" );
}
	
	
}