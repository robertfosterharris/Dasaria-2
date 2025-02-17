//This door leads to a bottomless pit in a cartoonish manner.
//frac

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;


//first 'if' has nothing to do with the pit fall, im just adding the scales desc here
if (GetTag(OBJECT_SELF) == "carc_scales_descrip")
{
string sTag = GetTag(OBJECT_SELF);
if (GetLocalInt(oPC,sTag)) return;
SetLocalInt(oPC,sTag,1);
SendMessageToPC(oPC,"<color=#C1AB89>[A set of enormous scales stands in the center of this room. On one end a heavy bronze statue is welded, depicting a man weeping over a coffin too small in size to belong to an adult.]");
return;
}


if (GetTag(OBJECT_SELF) == "carc_pitfall_check")
{
string sTag = GetTag(OBJECT_SELF);
if (GetLocalInt(oPC,sTag)) return;
SetLocalInt(oPC,sTag,1);
		if (GetIsSkillSuccessful(oPC, SKILL_SEARCH,25,TRUE))
		{
		SendMessageToPC(oPC,"<color=#C1AB89>[There is something unsettling about the door in front of you. Though there are no mechanisms to speak of, you suspect it may be some sort of devious trap...]");
		}
}


else
{
object oDoor = OBJECT_SELF;
string sName = GetName(oPC);
SendMessageToPC(oPC,"<color=#C1AB89>[As you pass through the door, you realize there is no floor! You fall down a chute..]");

AssignCommand(oPC,
JumpToLocation(GetLocation(GetWaypointByTag("carc_abelis_pittrapdoor"))));

AssignCommand(OBJECT_SELF,
ActionSpeakString(sName+" steps into the darkness... and promptly falls down the chasm! There is no floor!"));

DelayCommand(1.5,
AssignCommand(OBJECT_SELF,ActionSpeakString("<i>[Thud.]</i>")));


effect Dam=EffectDamage(d8(2),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL,TRUE);
DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,Dam,oPC));
DelayCommand(0.105,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC, 6.0));
DelayCommand(0.11,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC, 6.0));
}
}