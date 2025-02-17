// gtr_plc_trap_exit
//
void main()
{
	string sPlcTag = GetLocalString(OBJECT_SELF,"sPlcTag");
	AssignCommand(GetNearestObjectByTag(sPlcTag),PlayAnimation(ANIMATION_PLACEABLE_CLOSE)); 
}