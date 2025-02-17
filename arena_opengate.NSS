// open the arena door in an emergency
void main()
{
	object oGate = GetObjectByTag("arena_gate");	
	// Open ze door
	AssignCommand(oGate, SetLocked(oGate, FALSE));
	AssignCommand(oGate, ActionCloseDoor(oGate));
}