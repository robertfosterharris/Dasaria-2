/*

	2006/1/2	wyvern
		Initial revision
	2011/06/24	Wired	Log levelup-event to db
	

*/



#include "std_i0_xp"
#include "d2_sql_log"

void reset_xp_for_level(object oPC, int pc_level);
int get_xp_for_level(object oPC, int level);




void main() {

	object oPC = GetPCLevellingUp();
	int pc_level = GetHitDice(oPC);
	reset_xp_for_level(oPC, pc_level);
	trackEvent(oPC,"LEVELUP",OBJECT_INVALID,pc_level);
}




void reset_xp_for_level(object oPC, int pc_level) {
	
	int ecl_modifier = xp_util_level_ecl_modifier(GetSubRace(oPC));
	int pc_effective_level = pc_level + ecl_modifier;
	SendMessageToPC(oPC, "ECL modifier is " + IntToString(ecl_modifier));
	SendMessageToPC(oPC, "effective level is " + IntToString(pc_effective_level));

	int xp_limit_for_level = get_xp_for_level(oPC, pc_effective_level);
	int xp_limit_for_next_level = get_xp_for_level(oPC, pc_effective_level + 1);
	int xp_buffer = (xp_limit_for_next_level - xp_limit_for_level) / 2;
	int pc_xp = GetXP(oPC);
	int xp_difference = pc_xp - xp_limit_for_level;
	if (xp_difference > xp_buffer) {
		xp_difference = xp_buffer;
	}
	
	
	SendMessageToPC(oPC, "rebalancing experience gained based on level: " +  IntToString(xp_limit_for_level + xp_difference));
	SetXP(oPC, xp_limit_for_level + xp_difference);
}







int get_xp_for_level(object oPC, int level) {
	switch (level) {
		case 1:
			return 0;
		case 2:
			return 1000;
		case 3:
			return 3000;
		case 4:
			return 6000;
		case 5:
			return 10000;
		case 6:
			return 15000;
		case 7:
			return 21000;
		case 8:
			return 28000;
		case 9:
			return 36000;
		case 10:
			return 45000;
		case 11:
			return 55000;
		case 12:
			return 66000;
		case 13:
			return 78000;
		case 14:
			return 91000;
		case 15:
			return 105000;
		case 16:
			return 120000;
		case 17:
			return 136000;
		case 18:
			return 153000;
		case 19:
			return 171000;
		case 20:
			return 190000;
		case 21:
			return 210000;
		case 22:
			return 231000;
		case 23:
			return 253000;
		default:
			return GetXP(oPC);
		}
		return GetXP(oPC);
}



/*
*/