//vfx spawns onenter
//required variables:
//string "vfx" - .sef file
//reverse - VFX plays when people leave the trigger and diminishes when they enter
//script - plugin script
//-frac
void main()
{
if (!GetIsPC(GetEnteringObject())) return;
int nCount = GetLocalInt(OBJECT_SELF,"peopleinside");
nCount = nCount+1;
SetLocalInt(OBJECT_SELF,"peopleinside",nCount);
string sVFX = GetLocalString(OBJECT_SELF,"vfx");
object oTarget = GetObjectByTag(GetLocalString(OBJECT_SELF,"target"));
effect eEffect = EffectNWN2SpecialEffectFile(sVFX);

int nReverse = GetLocalInt(OBJECT_SELF,"reverse");

int IsOn = GetLocalInt(OBJECT_SELF,"turned_on");
if (!IsOn) 
//if (nCount == 1)//at least one person is inside.
{
SetLocalInt(OBJECT_SELF,"turned_on",1);
//regular vfx applies, not reverse.
if (!nReverse) { ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect,oTarget); }
//reverse..
	else
	{
	eEffect = GetFirstEffect(oTarget);
		while (GetIsEffectValid(eEffect))
		{
		RemoveEffect(oTarget,eEffect);
		eEffect = GetNextEffect(oTarget);
		}
	}

string sScript = GetLocalString(OBJECT_SELF,"script");
if (sScript != "") {DelayCommand(0.05,ExecuteScript(sScript,OBJECT_SELF));}
}
//AssignCommand(oTarget,ActionSpeakString("People inside: "+IntToString(nCount)));
}