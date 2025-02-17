// ginc_custom_skills
/*
Description: Holds constants for the Dasaria2 custom skills

// RW 19-10-2010
int SKILL_APPRAISE         = 20;
int SKILL_BLUFF            = 23;
int SKILL_CONCENTRATION    = 1;
int SKILL_CRAFT_ALCHEMY    = 27;
int SKILL_CRAFT_ARMOR      = 25;
int SKILL_CRAFT_TRAP       = 22;
int SKILL_CRAFT_WEAPON     = 26;
int SKILL_DIPLOMACY        = 12; 
int SKILL_DISABLE_TRAP     = 2; **
int SKILL_DISCIPLINE       = 3;
int SKILL_HEAL             = 4;
int SKILL_HIDE             = 5;
int SKILL_INTIMIDATE       = 24;
int SKILL_LISTEN           = 6;
int SKILL_LORE             = 7;
int SKILL_MOVE_SILENTLY    = 8;
int SKILL_OPEN_LOCK        = 9; **
int SKILL_PARRY            = 10;
int SKILL_PERFORM          = 11; **
int SKILL_SEARCH           = 14;
int SKILL_SET_TRAP         = 15; **
int SKILL_SLEIGHT_OF_HAND  = 13; **
int SKILL_SPELLCRAFT       = 16; **
int SKILL_SPOT             = 17;
int SKILL_SURVIVAL         = 29;
int SKILL_TAUNT            = 18;
int SKILL_TUMBLE           = 21; **
int SKILL_USE_MAGIC_DEVICE = 19; **
*/


const int SKILL_SPEAK_LANGUAGE	=	30;
const int SKILL_SENSE_MOTIVE	=	31;

string ReturnSkillName(int iSkill)
{
string sSkillName;
switch (iSkill)
{
case SKILL_CONCENTRATION:
sSkillName =	"Concentration";
break;
case SKILL_DISABLE_TRAP:
sSkillName = 	"Disable Trap";
break;
case SKILL_DISCIPLINE:
sSkillName =	"Discipline";
break;
case SKILL_HEAL:
sSkillName = 	"Heal";
break;
case SKILL_HIDE:
sSkillName = 	"Hide";
break;
case SKILL_LISTEN:
sSkillName = 	"Listen";
break;
case SKILL_LORE:
sSkillName = 	"Lore";
break;
case SKILL_MOVE_SILENTLY:
sSkillName = 		"Move Silently";
break;
case SKILL_OPEN_LOCK:
sSkillName =	"Open Lock";
break;
case SKILL_PARRY:
sSkillName =  	"Parry";
break;
case SKILL_PERFORM:
sSkillName =	"Perform";
break;
case SKILL_DIPLOMACY:
sSkillName =	"Diplomacy";
break;
case SKILL_SLEIGHT_OF_HAND:
sSkillName =	"Sleight Of Hand";
break;
case SKILL_SEARCH:
sSkillName =	"Search";
break;
case SKILL_SET_TRAP:
sSkillName =	"Set Trap";
break;
case SKILL_SPELLCRAFT:
sSkillName =	"Spellcraft";
break;
case SKILL_SPOT:
sSkillName =	"Spot";
break;
case SKILL_TAUNT:
sSkillName =	"Taunt";
break;
case SKILL_USE_MAGIC_DEVICE:
sSkillName = "Use Magic Device";
break;
case SKILL_APPRAISE:
sSkillName =	"Appraise";
break;
case SKILL_TUMBLE:
sSkillName = 	"Tumble";
break;
case SKILL_CRAFT_TRAP:
sSkillName =	"Craft Trap";
break;
case SKILL_BLUFF:
sSkillName =	"Bluff";
break;
case SKILL_INTIMIDATE:
sSkillName = 	"Intimidate";
break;
case SKILL_CRAFT_ARMOR:
sSkillName =	"Craft Armor";
break;
case SKILL_CRAFT_WEAPON:
sSkillName =	"Craft Weapon";
break;
case SKILL_CRAFT_ALCHEMY:
sSkillName = 	"Craft Alchemy";
break;
case SKILL_RIDE:
sSkillName = 	"Ride";
break;
case SKILL_SURVIVAL:
sSkillName = 	"Survival";
break;
case SKILL_SPEAK_LANGUAGE:
sSkillName =	"Speak Language";
break;
case SKILL_SENSE_MOTIVE:
sSkillName = 	"Sense Motive";
break;

}
return sSkillName;
}


const string SKILLROLL_PC_INVALID_TARGET = "You may only roll for yourself, your familiars, animal companions, or henchmen.";
const string SKILLROLL_DM_INVALID_TARGET = "The target you have selected appears to be invalid.";
const string SKILLROLL_VALID_TARGET = " Check vs Target: ";
const string SKILLROLL_BLURB = "Skill Check: ";
const string SKILLROLL_UNTRAINED = ". AUTOMATIC FAIL: Training is required to use this skill";
const string SKILLROLL_GENERAL_TARGET = "General";
const string SKILLROLL_SUCCESS = " (SUCCESS)";
const string SKILLROLL_FAILURE = " (FAILURE)";


string sSkill_Trained(object oPC, int iSkill)
{

string sOutput ="";
if(!GetHasSkill(iSkill, oPC))
{
sOutput = SKILLROLL_UNTRAINED;
}
//perform "fix" ala 3.5 rules
if(iSkill == SKILL_PERFORM)
{
sOutput ="";
}
return sOutput;
}


int iReturnSkill(string sSkillString, object oSender)
{
	int iSkillValue;
	string sSkillStringOutput = GetStringLowerCase(sSkillString);

	if(FindSubString( sSkillStringOutput,  "concentration") != -1) {iSkillValue = 1 ;}
	if(FindSubString( sSkillStringOutput,  "disabletrap") != -1) 	{iSkillValue = 2 ;}
	if(FindSubString( sSkillStringOutput,  "discipline") != -1) 	{iSkillValue = 3 ;}
	if(FindSubString( sSkillStringOutput,  "heal") != -1) 			{iSkillValue = 4 ;}
	if(FindSubString( sSkillStringOutput,  "hide") != -1) 			{iSkillValue = 5 ;}
	if(FindSubString( sSkillStringOutput,  "listen") != -1) 		{iSkillValue = 6 ;}
	if(FindSubString( sSkillStringOutput,  "lore") != -1) 			{iSkillValue = 7 ;}
	if(FindSubString( sSkillStringOutput,  "movesilently") != -1) 	{iSkillValue = 8 ;}
	if(FindSubString( sSkillStringOutput,  "openlock") != -1) 		{iSkillValue = 9 ;}
	if(FindSubString( sSkillStringOutput,  "parry") != -1) 		{iSkillValue = 10 ;}
	if(FindSubString( sSkillStringOutput,  "perform") != -1) 		{iSkillValue = 11 ;}
	if(FindSubString( sSkillStringOutput,  "diplomacy") != -1) 	{iSkillValue = 12 ;}
	if(FindSubString( sSkillStringOutput,  "sleightofhand") != -1) {iSkillValue = 13 ;}
	if(FindSubString( sSkillStringOutput,  "search") != -1) 		{iSkillValue = 14 ;}
	if(FindSubString( sSkillStringOutput,  "settrap") != -1) 		{iSkillValue = 15 ;}
	if(FindSubString( sSkillStringOutput,  "spellcraft") != -1) 	{iSkillValue = 16 ;}
	if(FindSubString( sSkillStringOutput,  "spot") != -1) 			{iSkillValue = 17 ;}
	if(FindSubString( sSkillStringOutput,  "taunt") != -1) 		{iSkillValue = 18 ;}
	if(FindSubString( sSkillStringOutput,  "usemagicdevice") != -1){iSkillValue = 19 ;}
	if(FindSubString( sSkillStringOutput,  "appraise") != -1) 		{iSkillValue = 20 ;}
	if(FindSubString( sSkillStringOutput,  "tumble") != -1) 		{iSkillValue = 21 ;}
	if(FindSubString( sSkillStringOutput,  "crafttrap") != -1) 	{iSkillValue = 22 ;}
	if(FindSubString( sSkillStringOutput,  "bluff") != -1) 		{iSkillValue = 23 ;}
	if(FindSubString( sSkillStringOutput,  "intimidate") != -1) 	{iSkillValue = 24 ;}
	if(FindSubString( sSkillStringOutput,  "craftarmor") != -1) 	{iSkillValue = 25 ;}
	if(FindSubString( sSkillStringOutput,  "craftweapon") != -1) 	{iSkillValue = 26 ;}
	if(FindSubString( sSkillStringOutput,  "craftalchemy") != -1) 	{iSkillValue = 27 ;}
	if(FindSubString( sSkillStringOutput,  "ride") != -1) 			{iSkillValue = 28 ;}
	if(FindSubString( sSkillStringOutput,  "survival") != -1) 		{iSkillValue = 29 ;}
	if(FindSubString( sSkillStringOutput,  "speaklanguage") != -1) {iSkillValue = 30 ;}
	if(FindSubString( sSkillStringOutput,  "sensemotive") != -1) 	{iSkillValue = 31 ;}
	
	if(FindSubString( sSkillStringOutput,  "skcon") != -1) {iSkillValue = 1 ;}
	if(FindSubString( sSkillStringOutput,  "skdt") != -1) 	{iSkillValue = 2 ;}
	if(FindSubString( sSkillStringOutput,  "skdis") != -1) {iSkillValue = 3 ;}
	if(FindSubString( sSkillStringOutput,  "skhe") != -1) 	{iSkillValue = 4 ;}
	if(FindSubString( sSkillStringOutput,  "skhi") != -1) 	{iSkillValue = 5 ;}
	if(FindSubString( sSkillStringOutput,  "skli") != -1) 	{iSkillValue = 6 ;}
	if(FindSubString( sSkillStringOutput,  "sklo") != -1) 	{iSkillValue = 7 ;}
	if(FindSubString( sSkillStringOutput,  "skms") != -1) 	{iSkillValue = 8 ;}
	if(FindSubString( sSkillStringOutput,  "skol") != -1) 	{iSkillValue = 9 ;}
	if(FindSubString( sSkillStringOutput,  "skpa") != -1) 	{iSkillValue = 10 ;}
	if(FindSubString( sSkillStringOutput,  "skpe") != -1) 	{iSkillValue = 11 ;}
	if(FindSubString( sSkillStringOutput,  "skdip") != -1) {iSkillValue = 12 ;}
	if(FindSubString( sSkillStringOutput,  "sksoh") != -1) {iSkillValue = 13 ;}
	if(FindSubString( sSkillStringOutput,  "skser") != -1) {iSkillValue = 14 ;}
	if(FindSubString( sSkillStringOutput,  "skst") != -1) 	{iSkillValue = 15 ;}
	if(FindSubString( sSkillStringOutput,  "sksc") != -1) 	{iSkillValue = 16 ;}
	if(FindSubString( sSkillStringOutput,  "sksp") != -1) 	{iSkillValue = 17 ;}
	if(FindSubString( sSkillStringOutput,  "skta") != -1) 	{iSkillValue = 18 ;}
	if(FindSubString( sSkillStringOutput,  "skumd") != -1)	{iSkillValue = 19 ;}
	if(FindSubString( sSkillStringOutput,  "ska") != -1) 	{iSkillValue = 20 ;}
	if(FindSubString( sSkillStringOutput,  "sktu") != -1) 	{iSkillValue = 21 ;}
	if(FindSubString( sSkillStringOutput,  "skct") != -1) 	{iSkillValue = 22 ;}
	if(FindSubString( sSkillStringOutput,  "skb") != -1) 	{iSkillValue = 23 ;}
	if(FindSubString( sSkillStringOutput,  "ski") != -1) 	{iSkillValue = 24 ;}
	if(FindSubString( sSkillStringOutput,  "skcar") != -1) {iSkillValue = 25 ;}
	if(FindSubString( sSkillStringOutput,  "skcw") != -1) 	{iSkillValue = 26 ;}
	if(FindSubString( sSkillStringOutput,  "skcal") != -1) {iSkillValue = 27 ;}
	if(FindSubString( sSkillStringOutput,  "skr") != -1) 	{iSkillValue = 28 ;}
	if(FindSubString( sSkillStringOutput,  "sksur") != -1) {iSkillValue = 29 ;}
	if(FindSubString( sSkillStringOutput,  "sksl") != -1) 	{iSkillValue = 30 ;}
	if(FindSubString( sSkillStringOutput,  "sksm") != -1) 	{iSkillValue = 31 ;}

	return iSkillValue;

}


//void main()