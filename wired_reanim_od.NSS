//wired_reanim_od
void main()
{
	string sName;
	string sTemplate;
	location lLoc;
	effect eWail;
	string sRand; // is createobject still broken?

	sName = GetFirstName(OBJECT_SELF);
	sName = "Risen "+sName;
	lLoc = GetLocation(OBJECT_SELF);
	sRand = RandomName();
	eWail = EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	sTemplate = GetLocalString(OBJECT_SELF,"sUndeadTemplate");
	if (sTemplate == "") sTemplate = "c_shadow";
	
	CreateObject(OBJECT_TYPE_CREATURE,sTemplate,lLoc,TRUE,sRand);
	SetFirstName(GetNearestObjectByTag(sRand),sName);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eWail,lLoc);
}