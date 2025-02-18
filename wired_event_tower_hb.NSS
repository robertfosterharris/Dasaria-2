//wired_event_tower_hb
void main()
{
	string sDestWP = GetLocalString(OBJECT_SELF,"sDestWP");
	ActionMoveToObject(GetNearestObjectByTag(sDestWP),TRUE,1.0f);
}
