//remove vfx when PC exits
//target for placeable to vfx
//vfx for sef file
//reverse for reverse effect
//script - plugin script
//-frac
void main()
{
if (!GetIsPC(GetExitingObject())) return;
object oTarget = GetObjectByTag(GetLocalString(OBJECT_SELF,"target"));
int nCount = GetLocalInt(OBJECT_SELF,"peopleinside");
string sFinish = GetLocalString(oTarget,"finish");
nCount = nCount-1;
SetLocalInt(OBJECT_SELF,"peopleinside",nCount);
int nReverse = GetLocalInt(OBJECT_SELF,"reverse");

if (nCount < 1)
{
DeleteLocalInt(OBJECT_SELF,"turned_on");

//regular removal
	if (!nReverse)
	{
	effect eEffect = GetFirstEffect(oTarget);
		while (GetIsEffectValid(eEffect))
		{
		RemoveEffect(oTarget,eEffect);
		eEffect = GetNextEffect(oTarget);
		}
	}
//reverse! add effect.
	else 
	{
	string sVFX = GetLocalString(OBJECT_SELF,"vfx");
	effect eEffect = EffectNWN2SpecialEffectFile(sVFX);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect,oTarget);
	}

string sScript = GetLocalString(OBJECT_SELF,"script");
if (sScript != "") {DelayCommand(0.05,ExecuteScript(sScript,OBJECT_SELF));}
}
}