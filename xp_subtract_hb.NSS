void main() {
	object oPC = GetFirstPC();
	float range = GetLocalFloat(OBJECT_SELF, "range");
	int xp_to_remove = GetLocalInt(OBJECT_SELF, "xp_to_remove");
	while (GetIsObjectValid(oPC)) {
		
		if(GetArea(oPC) == GetArea(OBJECT_SELF)) {
			if(GetDistanceToObject(oPC) < range) {
				SendMessageToPC(oPC, "You feel an overwhelming power tugging at your very soul.  You literally feel your lifeforce draining away.");
				SetXP(oPC, GetXP(oPC) - xp_to_remove);
			}
		}
		oPC = GetNextPC();
	}
}