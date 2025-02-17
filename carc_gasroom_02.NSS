//Gas chamber! 
//Doors will only open once listening pattern is met (gassed varint will be removed from PCs).

void Gas(object oPC, object oCenter)
{
if (!GetLocalInt(oCenter,"Gasing")) return;
object oGassed = GetFirstObjectInShape(SHAPE_CUBE,6.0,GetLocation(oCenter),FALSE,OBJECT_TYPE_CREATURE);
while (GetIsObjectValid(oGassed))
{
	if (GetLocalInt(oGassed,"gassed"))
	{
	if (!GetIsDead(oGassed))
	{
	effect eDam = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oGassed);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_draining_hit"),oGassed);
		if (GetAbilityScore(oGassed,ABILITY_CONSTITUTION) < 1 )
		{ 
		eDam =EffectDeath(FALSE,TRUE,TRUE,TRUE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oGassed); 
		}
	}
	}
oGassed = GetNextObjectInShape(SHAPE_CUBE,6.0,GetLocation(oCenter),FALSE,OBJECT_TYPE_CREATURE);
}
DelayCommand(6.0,Gas(oPC,oCenter));
}

void main()
{
object oPC = GetEnteringObject();
if (GetLocalInt(OBJECT_SELF,"DONE")) return;
object oDoor1 = GetObjectByTag("carc_abelis_gaschamb01");
object oDoor2 = GetObjectByTag("carc_abelis_gaschamb02");
object oCenter = GetObjectByTag("carc_abelis_gascenter");
SetLocalInt(oCenter,"Gasing",1);
SetLocalInt(OBJECT_SELF,"DONE",1);

AssignCommand(oDoor1,ActionCloseDoor(oDoor1));
SetLocked(oDoor1, TRUE);
AssignCommand(oDoor2,ActionCloseDoor(oDoor2));
SetLocked(oDoor2, TRUE);
AssignCommand(oDoor1,ActionSpeakString("[You hear some kind of mechanism shift and groan somewhere above the ceiling...]"));
DelayCommand(0.5,AssignCommand(oDoor1,ActionSpeakString("[Soon after, a noxious gas filters it's way into the sealed chamber. You feel yourself suffocating!]")));


DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectNWN2SpecialEffectFile("sp_cloudkill"),oCenter));
DelayCommand(3.0,AssignCommand(oDoor1,
ActionSpeakString("<b>PRAISE AND SPEAK MY UNHOLY NAME, I WHO LORD OVER THIS PLACE!")));

DelayCommand(4.0, Gas(oPC,oCenter));
DelayCommand(90.0,DeleteLocalInt(oCenter,"Gasing"));
DelayCommand(90.0,SetLocked(oDoor1,FALSE));
DelayCommand(90.0,SetLocked(oDoor2,FALSE));
}