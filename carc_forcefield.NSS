//remove/add collision box to forcefield
//-frac

void PeopleInside(string sRef,object oTarget)
{
//AssignCommand(oTarget,ActionSpeakString("Destroying!"));
location lTarget = GetLocation(oTarget);
sRef = sRef;
DestroyObject(GetObjectByTag(sRef));
DestroyObject(GetObjectByTag("carc_frcfild1_light"));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_energy_field_1_exp"),oTarget);
}

void NobodyInside(string sRef,object oTarget)
{
//AssignCommand(oTarget,ActionSpeakString("Creating!"));
location lTarget = GetLocation(oTarget);
CreateObject(OBJECT_TYPE_PLACEABLE,sRef,lTarget,FALSE);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_teleport"),oTarget);


CreateObject(OBJECT_TYPE_LIGHT,"carc_mrlochorb_blu_light",lTarget,FALSE,"carc_frcfild1_light");
}


void main()
{
//object oSelf = GetObjectByTag("carc_abelis_field01");
object oSelf = OBJECT_SELF;
int nCount = GetLocalInt(oSelf,"peopleinside");
object oTarget = GetObjectByTag(GetLocalString(oSelf,"target"));
string sRef = "carc_forcefield";
int IsOn = GetLocalInt(OBJECT_SELF,"turned_on");
	//if (nCount == 1)
	if (IsOn > 0)
	{ 	PeopleInside(sRef,oTarget); }
//	else if (nCount < 1)
	else if (!IsOn)
	{	NobodyInside(sRef,oTarget); }
	else return;
}