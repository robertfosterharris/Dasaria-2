// d2_sql

#include "dmfi_inc_inc_com"
#include "nwnx_sql"
#include "nwnx_include"
#include "std_persist_i0"

/************************************/
/* Function prototypes              */
/************************************/

// return/validate a PCid
string getPCid(object oPC);

// insert or update character statistics 
// enter = 0, exit = 1, levelup = null
void LogPCStats(object oPC, int nType);

// main (OCL-safe) save character function
void saveChar(object oPC);

// OCE save function, handles INSERTs and player information
void saveChar_OCE(object oPC);

// OCL save function, updates last_logged etc
void saveChar_OCL(object oPC);

//	Returns GE Axis String
string GetAlignmentGoodEvilString(int iAlignment);

//	Returns LC Axis String
string GetAlignmentLawChaosString(int iAlignment);

/************************************/
/* Implementation                   */
/************************************/

// OCL save function, updates last_logged etc
void saveChar_OCL(object oPC)
{
	if (!GetIsObjectValid(oPC) || GetLocalInt(oPC,"bVaultFailure") || GetIsDM(oPC) || !GetIsPC(oPC)) return;
	
	string sPCid;
	string sSQL;
	
	sPCid = GetLocalString( oPC, "pcid");
	
	if (sPCid == "ERROR_OBJ_INVALID" || sPCid == "") return;
	
	sSQL = "UPDATE pc_data SET last_logout_time=NOW(),time_on_server=time_on_server + TIMESTAMPDIFF(MINUTE,last_login_time,NOW()) WHERE pcid=" + sPCid;
	SQLExecDirect(sSQL);
	
	// now invoke the main save function
	saveChar(oPC);
}

// OCE save function, handles INSERTs and player information
void saveChar_OCE(object oPC)
{

	if (!GetIsObjectValid(oPC) || GetLocalInt(oPC,"bVaultFailure") || GetIsDM(oPC) || !GetIsPC(oPC)) return;
	
	int nLoginCount;
	
	string	sBicName;	
	string	sPlayerName;
	string	sPublicCDKey;
	string	sArea;
	
	string	sFName;
	string	sLName;
	string	sRacialType;
	string	sSubRace;
	string	sGender;
	string	sHP;	
		
	string 	sPCid;
	string 	sSQL;
	
	object oJournal;
		
	sBicName 		= 	SQLEncodeSpecialChars(GetBicFileName(oPC));
	sPlayerName		=	SQLEncodeSpecialChars(GetPCPlayerName(oPC));
	sPublicCDKey	=	SQLEncodeSpecialChars(GetPCPublicCDKey(oPC));
	sArea			=	SQLEncodeSpecialChars(GetName(GetArea(oPC)));

	sFName			=	SQLEncodeSpecialChars(GetFirstName(oPC));
	sLName			=	SQLEncodeSpecialChars(GetLastName(oPC));	
	sRacialType		= 	Get2DAString("racialtypes","Label",GetRacialType(oPC));
	sSubRace 		= 	Get2DAString("racialsubtypes","Label",GetSubRace(oPC));
	sGender			=	Get2DAString("gender","GENDER",GetGender(oPC));
	sHP				=	IntToString(GetCurrentHitPoints(oPC));	
	
	sPCid 			= 	getPCid(oPC);
	oJournal		=	std_journal_get(oPC);
	
	if (sPCid == "ERROR_OBJ_INVALID" || sPCid == "") return;
	
	if ( sPCid == "NEW" )
	{
		// collect some information on legacy characters 
		nLoginCount = GetLocalInt( oJournal, "std_login_count");
		
		// no longer log dms in this table
		// override the bicname for DMs on creation
		// if (GetIsDM(oPC)) sBicName = "[DM] "+sPlayerName;
		
		 sSQL = "INSERT INTO pc_data (bic_name,player_name,public_cd_key,o_fname,o_lname,race,subrace,gender,spawn_loc,first_login_time,hit_points,login_count) VALUES" +
	            "('" + sBicName + "','" +
					sPlayerName + "','" + 
					sPublicCDKey + "','" + 
					sFName + "','" + 
					sLName + "','" +
					sRacialType + "','" +
					sSubRace + "','" +
					sGender + "'," +
					"00,"+		
					"NOW(),"+
					sHP + "," +				 					 
					IntToString(nLoginCount) + ")";

		SQLExecDirect(sSQL);
        
		SQLExecDirect("SELECT LAST_INSERT_ID()");
        if (SQLFetch() == SQL_SUCCESS) 
		{
            sPCid = SQLGetData(1);
			// and record it on the character for posterity
			SetLocalString( oJournal, "pcid", sPCid);
        }
	}
	SetLocalString( oPC, "pcid", sPCid);
	
	// Update data
    sSQL = 	"UPDATE pc_data SET public_cd_key='" + sPublicCDKey + "',last_login_time=NOW(),last_enter='"+ sArea + "',login_count=login_count+1 WHERE pcid=" + sPCid;		
	SQLExecDirect(sSQL);
	
	// now invoke the main save function
	saveChar(oPC);
}

// main (OCL-safe) save character function
void saveChar(object oPC)
{

	if (!GetIsObjectValid(oPC) || GetLocalInt(oPC,"bVaultFailure") || GetIsDM(oPC) || !GetIsPC(oPC)) return;
	
	string 	sPCid;
	string 	sSQL;

	string	sFName		=	SQLEncodeSpecialChars(GetFirstName(oPC));
	string	sLName		=	SQLEncodeSpecialChars(GetLastName(oPC));	
	string	sHP			=	IntToString(GetCurrentHitPoints(oPC));	
	string	sAlignGE	=	GetAlignmentGoodEvilString(GetAlignmentGoodEvil(oPC));
	string	sAlignLC	=	GetAlignmentLawChaosString(GetAlignmentLawChaos(oPC));
	string	sClass1		=	Get2DAString("classes","Label",GetClassByPosition(1,oPC));
	string	sClass1n 	=	IntToString(GetLevelByPosition(1,oPC));
	string	sClass2		=	Get2DAString("classes","Label",GetClassByPosition(2,oPC));
	string	sClass2n	=	IntToString(GetLevelByPosition(2,oPC));
	string	sClass3		=	Get2DAString("classes","Label",GetClassByPosition(3,oPC));
	string	sClass3n	=	IntToString(GetLevelByPosition(3,oPC));
	string	sClass4		=	Get2DAString("classes","Label",GetClassByPosition(4,oPC));
	string	sClass4n	=	IntToString(GetLevelByPosition(4,oPC));
	string	sXP			=	IntToString(GetXP(oPC));
	string	sHD			=	IntToString(GetHitDice(oPC));
	string	sNW			= 	IntToString(DMFI_GetNetWorth(oPC));
	string	sSTR		=	IntToString(GetAbilityScore(oPC,0,TRUE));
	string	sDEX		=	IntToString(GetAbilityScore(oPC,1,TRUE));
	string	sCON		=	IntToString(GetAbilityScore(oPC,2,TRUE));
	string	sINT		=	IntToString(GetAbilityScore(oPC,3,TRUE));
	string	sWIS		=	IntToString(GetAbilityScore(oPC,4,TRUE));
	string	sCHA		=	IntToString(GetAbilityScore(oPC,5,TRUE));	
	
	// grab the PC's identifer
	sPCid = GetLocalString( oPC, "pcid");
	
	if (sPCid == "ERROR_OBJ_INVALID" || sPCid == "") return;
	
	// update pc_data
    sSQL = 	"UPDATE pc_data SET "+				
				"fname='" 		+ sFName + "'," +
				"lname='" 		+ sLName + "'," +
				"class1_cls='" 	+ sClass1 + "',"+
				"class1_lvl=" 	+ sClass1n + ","+
				"class2_cls='" 	+ sClass2 + "',"+
				"class2_lvl=" 	+ sClass2n + ","+
				"class3_cls='" 	+ sClass3 + "',"+
				"class3_lvl=" 	+ sClass3n + ","+
				"class4_cls='" 	+ sClass4 + "',"+				
				"class4_lvl=" 	+ sClass4n + ","+
				"xp=" 			+ sXP +","+
				"level=" 		+ sHD +","+
				"net_worth=" 	+ sNW + ","+
				"align_lc='" 	+ sAlignLC + "',"+		
				"align_ge='" 	+ sAlignGE + "',"+
				"strength=" 	+ sSTR + ","+		
				"dexterity=" 	+ sDEX + ","+	
				"constitution="	+ sCON + ","+	
				"intelligence=" + sINT + ","+	
				"wisdom=" 		+ sWIS + ","+
				"charisma=" 	+ sCHA + ","+
				"hit_points=" 	+ sHP + ","+	
				"max_hit_points=GREATEST(" + sHP + ",max_hit_points)"+
				" WHERE pcid=" + sPCid;
				
	SQLExecDirect(sSQL);
}

//	Return the Law/Chaos Alignment String
string GetAlignmentLawChaosString(int iAlignment)
{
	string sAlignmentString;
	
	switch (iAlignment)
	{
		case ALIGNMENT_CHAOTIC:
 			sAlignmentString = "Chaotic";
			break;
		case ALIGNMENT_LAWFUL:
 			sAlignmentString = "Lawful";
			break;
		case ALIGNMENT_NEUTRAL:
 			sAlignmentString = "Neutral";
			break;
	}	
	return sAlignmentString;
}

//	Return the Good/Evil Alignment String
string GetAlignmentGoodEvilString(int iAlignment)
{
	string sAlignmentString;
	
	switch (iAlignment)
	{
		case ALIGNMENT_EVIL:
 			sAlignmentString = "Evil";
			break;
		case ALIGNMENT_GOOD:
 			sAlignmentString = "Good";
			break;
		case ALIGNMENT_NEUTRAL:
 			sAlignmentString = "Neutral";
			break;
	}	
	return sAlignmentString;
}


string getPCid(object oPC)
{
	string sBicName;
	
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ) return "ERROR_OBJ_INVALID";
	
	// give DMs pcid zero
	if (GetIsDM(oPC)) 
	{
		//sBicName = "[DM] "+GetPCPlayerName(oPC);
		SetLocalString( oPC, "pcid", "0");	
		return "0";
	}
	// regular player
	else 
	{	
		sBicName = GetBicFileName(oPC);
		
		// local vault character, invalid
		if (sBicName == "SERVERVAULT:temp_char")
		{
			SetLocalString(oPC,"pcid","ERROR_OBJ_INVALID");
			return "ERROR_OBJ_INVALID";
		}
		
		// safety first!
		sBicName = SQLEncodeSpecialChars(sBicName);
	
	    SQLExecDirect("SELECT pcid FROM pc_data WHERE bic_name = '" + sBicName + "'");
	    if (SQLFetch()) 
		{
			// find the pc
	        return SQLGetData(1);
	    }
		else
		{
			// else new pc
	   		return "NEW";
		}
	}
}

/*
void main()
{
}/*

/*
CREATE TABLE  `nwnx`.`pc_data` (
  `pcid` bigint(20) unsigned NOT NULL auto_increment,
  `bic_name` varchar(100) NOT NULL,
  `player_name` varchar(128) NOT NULL default '',
  `public_cd_key` varchar(100) NOT NULL,
  `fname` varchar(100) NOT NULL default '',
  `lname` varchar(100) NOT NULL default '',
  `o_fname` varchar(100) NOT NULL default '',
  `o_lname` varchar(100) NOT NULL default '',  
  `race` varchar(32) NOT NULL default '',
  `subrace` varchar(32) NOT NULL default '',  
  `gender` varchar(10) NOT NULL default '',
  `class1_cls` varchar(32) NOT NULL default '',  
  `class1_lvl` smallint(6) NOT NULL default '0',
  `class2_cls` varchar(32) NOT NULL default '',
  `class2_lvl` smallint(6) NOT NULL default '0',  
  `class3_cls` varchar(32) NOT NULL default '',
  `class3_lvl` smallint(6) NOT NULL default '0',
  `class4_cls` varchar(32) NOT NULL default '',
  `class4_lvl` smallint(6) NOT NULL default '0',
  `xp` bigint(20) NOT NULL default '0',
  `level` tinyint(4) NOT NULL default '0',
  `align_lc` varchar(8) NOT NULL default '',
  `align_ge` varchar(8) NOT NULL default '',  
  `strength` tinyint(4) NOT NULL default '0',
  `intelligence` tinyint(4) NOT NULL default '0',
  `dexterity` tinyint(4) NOT NULL default '0',
  `wisdom` tinyint(4) NOT NULL default '0',
  `constitution` tinyint(4) NOT NULL default '0',
  `charisma` tinyint(4) NOT NULL default '0',
  `hit_points` smallint(6) NOT NULL default '0',
  `max_hit_points` smallint(6) NOT NULL default '0',  
  `bank_balance` bigint(20) NOT NULL default '0',
  `net_worth` bigint(20) NOT NULL default '0',  
  `spawn_loc` tinyint(2) NOT NULL default '0',
  `spells_used` varchar(128) NOT NULL default '', 
  `login_count` int(11) NOT NULL default '0',
  `death_count` smallint(6) NOT NULL default '0',
  `pvp_win_count` bigint(20) NOT NULL default '0',
  `pvp_loss_count` bigint(20) NOT NULL default '0',  
  `first_login_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_login_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_logout_time` datetime default '0000-00-00 00:00:00',
  `last_enter` varchar(100) NOT NULL default '',
  `last_exit` varchar(100) NOT NULL default '',
  `time_on_server` bigint(20) NOT NULL default '0',  
  `forum_name` varchar(128) NOT NULL default '',    
  PRIMARY KEY  (`pcid`),
  UNIQUE KEY (`bic_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
*/