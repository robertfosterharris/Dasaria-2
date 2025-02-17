//	GA_LEGION_SET_RANK		

//	CHANGES THE CHARACTERS NAME TO REFLECT RANK IN THE LEGION
//	RANK IS COMPUTED BASED ON EXPERIENCE, SENORITY AND NATURAL LEADERSHIP ABILITY
//	THIS FUNCTION WILL NOT DEMOTE CHARACTERS PROMOTED BY A DM

#include "nwnx_include"
#include "nwnx_sql"

//	BASED ON LEADERSHIP FEAT (http://www.d20srd.org/srd/feats.htm#leadership)
//	THE ACTUAL D&D FORMULA TO DETERMINE LEADERSHIP RANK IS LEVEL + CHARISMA MODIFIER
//	TO FAVOR ROLEPLAY OVER POWERLEVELING OUR FORMULA IS LEVEL * 2/3 + DAYS ON SERVER / 90 + CHARISMA MODIFIER
//
const int CENTURION		= 22;	//	COMMANDS 100 MEN	(91)
const int OPTIO			= 20;	//	COMMANDS 60 MEN		(61)	
const int TESSERARIUS	= 18;	//	COMMANDS 40 MEN		(40)
const int DECANUS		= 12;	//	COMMANDS 10 MEN		(08)
const int MILITES		= 6;	//	NO COMMAND ABILITY
const int TIRONES		= 0;	//	NO COMMAND ABILITY


void main()
{
	int nExperience;
	int nSenority;
	int nLeadership;
	int nComputedRank;
	int nCurrentRank;
	int nAge;
	object oPC;
	string sComputedRank;
	string sCurrentRank;
	string sSQL;
	
	oPC = GetPCSpeaker();
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
	
	sSQL = "select datediff(now(), first_login_time) from pc_data where pc_data.bic_name = '" + SQLEncodeSpecialChars(GetBicFileName(oPC)) + "'";
	SQLExecDirect(sSQL);
	
	while (SQLFetch() == SQL_SUCCESS)
	{
		nCurrentRank = -99;
		sCurrentRank = GetFirstName(oPC);
		if (sCurrentRank == "Tirones")		nCurrentRank = TIRONES;
		if (sCurrentRank == "Milites")		nCurrentRank = MILITES;
		if (sCurrentRank == "Decanus")		nCurrentRank = DECANUS;
		if (sCurrentRank == "Tesserarius")	nCurrentRank = TESSERARIUS;
		if (sCurrentRank == "Optio")		nCurrentRank = OPTIO;
		if (sCurrentRank == "Centurion")	nCurrentRank = CENTURION;
		
		nExperience = GetHitDice(oPC) * 2/3;
		nSenority = StringToInt(SQLGetData(1)) / 90;
		nLeadership = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE) / 2 - 5;

		if (nSenority > 8) nSenority = 8;
		
		nComputedRank = nExperience + nSenority + nLeadership;
		
		if (nComputedRank < 0) nComputedRank = 0;
		//
		//	PREVENT DEMOTIONS
		//		
		if (nComputedRank > nCurrentRank)
		{
			if (nComputedRank >= TIRONES)		sComputedRank = "Tirones";
			if (nComputedRank >= MILITES)		sComputedRank = "Milites";
			if (nComputedRank >= DECANUS)		sComputedRank = "Decanus";
			if (nComputedRank >= TESSERARIUS)	sComputedRank = "Tesserarius";
			if (nComputedRank >= OPTIO) 		sComputedRank = "Optio";
			if (nComputedRank >= CENTURION)		sComputedRank = "Centurion";
			//
			//	GRANT PROMOTION
			//
			if (sCurrentRank != sComputedRank)
			{
				SetLocalInt(oPC, "bLegionPromotion", 1);
				if (nCurrentRank < TIRONES) SetLastName(oPC, GetName(oPC));
				SetFirstName(oPC, sComputedRank);
			}
		}
	}
}