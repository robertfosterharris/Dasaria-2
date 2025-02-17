// d2_sql_log

#include "d2_sql"

/************************************/
/* Constants		                */
/************************************/

/* Deprecated, I want a human-readable table
//
const int EVENT_LOGIN 			= 1;        // log in
const int EVENT_LOGOUT			= 2;        // log out
const int EVENT_COMMONER_KILL 	= 11;		// player killed a commoner
const int EVENT_PVP_KILL 		= 12;		// player was killed, by whom
const int EVENT_ROLL			= 3;		// new character
const int EVENT_AREA_ENTER		= 4;		// transition enter
const int EVENT_AREA_EXIT 		= 5;		// transition exit
const int EVENT_RENAME			= 6;		// character renamed
const int EVENT_START			= 7;		// start quest
const int EVENT_FINISH			= 8;		// finish quest
const int EVENT_PP_WIN			= 9;		// successful pickpocket, who and what
const int EVENT_PP_FAIL			= 10;		// pickpocket failure, who
const int EVENT_RAISED 			= 13;		// player raised or rezed, by whom 
const int EVENT_CRFT_WEAP 		= 14;		// craft weapon, track when
const int EVENT_CRFT_ARMR 		= 15;		// craft armor, track what
const int EVENT_CRFT_CMA 		= 16;		// craft magical arms and armor, track what
const int EVENT_CRFT_CWI 		= 17;		// craft wondrous item, track what
const int EVENT_CRFT_ALCHEMY	= 18;		// craft alchemy, track what
const int EVENT_FACTION_NEW 	= 19;		// faction created, by whom
const int EVENT_FACTION_DEL 	= 20;		// faction created, by who
const int EVENT_FACTION_ADD 	= 21;		// member added, who and by whom
const int EVENT_FACTION_REM 	= 22;		// member removed, who and by whom
const int EVENT_EXPLOIT1 		= 23;		// low sev exploit, who
const int EVENT_EXPLOIT2 		= 24;		// med sev exploit, who
const int EVENT_EXPLOIT3 		= 25;		// high sev exploit (ex: invoke gui, dm tool)
const int EVENT_BOOT			= 26;		// player booted, by whom

// implemented:
OCE
login
leave
commoner kill
pvp death
levelup
pc death
quest xp grant

/************************************/
/* Functions             			*/
/************************************/

void trackEvent(object oSource, string event_code, object oTarget = OBJECT_INVALID,  int int1 = 0, int int2 = 0, string string1 = "", string string2 = "")
{

	if (!GetIsObjectValid(oSource)) return;  // little point, no?
	
	string sSQL;

	// source info
    string source_name;
 	string source_cd;
	string source_area;
    string source_pcid = "0";
		
	// target info	
    string target_name;
	string target_cd;	
	string target_pcid = "0";	
	
	// additional info
    string event_int1;
    string event_int2;
	string event_string1;
	string event_string2;
	
	// source info
    source_name 	=	SQLEncodeSpecialChars(GetName(oSource));
 	source_cd		=	SQLEncodeSpecialChars(GetLocalString(oSource, "PlayerPublicCDKey"));  // information about player is invalid on exit, remember?
	source_area		=	SQLEncodeSpecialChars(GetTag(GetArea(oSource)));
	source_pcid		=	GetLocalString(oSource,"pcid");	
	
	// failsafes
	if (source_pcid	== "") source_pcid = getPCid(oSource);
	// it is still useful to log the actions of a localvault character
	if (source_pcid	== "ERROR_OBJ_INVALID") source_pcid = "0";
	
	// event info
	event_code		=	SQLEncodeSpecialChars(event_code);
    event_int1		=	IntToString(int1);
    event_int2		=	IntToString(int2);
    event_string1 	=	SQLEncodeSpecialChars(string1);
    event_string2 	=	SQLEncodeSpecialChars(string2);
	
	// target info	
	if (oTarget != OBJECT_INVALID && GetIsPC(oTarget) )   // never too careful!
	{
	    target_name 	=	SQLEncodeSpecialChars(GetName(oTarget));
		target_cd		=	SQLEncodeSpecialChars(GetLocalString(oTarget, "PlayerPublicCDKey"));	// information about player is invalid on exit, remember?
		target_pcid		=	GetLocalString(oTarget,"pcid");		
	}
	else
	{
		target_name 	= "NA";
		target_cd		= "NA";
		target_pcid		= "0";	
	}
	
    sSQL  = "INSERT DELAYED INTO event_log (timestamp, source_pcid, target_pcid, source_name, target_name, source_area, source_cd, target_cd, event_code, event_int1, event_int2, event_string1, event_string2) " +
        "VALUES (NOW(), " + source_pcid + ", " + target_pcid + ", '" + source_name + "', '" + target_name + "', '" + source_area + "', '" + source_cd + "', '" + target_cd + "','" + event_code + "' , " + event_int1 + ", " + event_int2 + ", '" + event_string1 + "', '" + event_string2 + "')";
	
	// REMOVE ME
	//SendMessageToPC(oSource,"sSQL was "+sSQL);
	SQLExecDirect(sSQL);
}


void initDB()
{
	SQLExecDirect("DELETE FROM event_log WHERE event_code = 'AREA_ENTER' AND DATEDIFF(NOW(),timestamp) > 5;");
	SQLExecDirect("DELETE FROM event_log WHERE (event_code = 'LOGIN' OR event_code = 'LOG_OUT') AND DATEDIFF(NOW(),timestamp) > 30;");
	SQLExecDirect("OPTIMIZE TABLE event_log");
	SQLExecDirect("OPTIMIZE TABLE ph_decor");
}

int UnlockVault(object oPC)
{
	string sPCid;
	string sStoredKey;
	string sKey;

	if (!GetIsObjectValid(oPC) || GetIsDM(oPC) || !GetIsPC(oPC) || GetLocalInt(GetModule(),"bUnlockVault") == TRUE) return TRUE;
	
	sPCid  = 	getPCid(oPC);
	
	if (sPCid != "NEW" && sPCid != "ERROR_OBJ_INVALID" && GetBicFileName(oPC) != "SERVERVAULT:temp_char" )
	{
		sKey = GetPCPublicCDKey(oPC);
	
		SQLExecDirect("SELECT public_cd_key FROM pc_data WHERE pcid = '" + sPCid + "'");
		
	    if (SQLFetch()) 
		{
	        sStoredKey = SQLGetData(1);
			
			if (sStoredKey != sKey)
			{
				SendMessageToPC(oPC,"Vault cannot be unlocked with that key.  If you believe you are receiving this message in error, contact an Administrator.");
				trackEvent(oPC, "VAULT_FAILURE", OBJECT_INVALID,0,0,GetLocalString(oPC, "PlayerName"),GetLocalString(oPC, "PlayerIPAddy"));
				WriteTimestampedLogEntry("VAULT FAILURE: User "+GetLocalString(oPC, "PlayerName")+" CD KEY "+sKey+" attempts access to "+GetFirstName(oPC)+" "+GetLastName(oPC)+" normally authed to CD KEY "+sStoredKey);
				SetLocalInt(oPC,"bVaultFailure",TRUE);
				
				//SendMessageToPC(oPC,"Leaving UnlockVault FALSE");
				return FALSE;
			}
			else
			{
				// AuthorizedPlayer
				SendMessageToPC(oPC,"Vault unlocked");
				return TRUE;
			}
	    }
	}

	// probably new pc, but let's default 
	// any unforseen paths to TRUE
	
	// REMOVE
	//SendMessageToPC(oPC,"Leaving UnlockVault TRUE/DEFAULT");
	return TRUE;
}


/*
INSERT DELAYED INTO nwnx.delimiter $$

CREATE TABLE `event_log` (
  `entry_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `event_code` varchar(16) NOT NULL DEFAULT 'none',
  `source_pcid` bigint(20) unsigned DEFAULT '0',
  `source_name` varchar(100) DEFAULT NULL,
  `source_cd` varchar(8) DEFAULT NULL,
  `source_area` varchar(32) DEFAULT NULL,
  `event_int1` bigint(20) DEFAULT NULL,
  `event_int2` bigint(20) DEFAULT NULL,
  `event_string1` varchar(255) DEFAULT NULL,
  `event_string2` varchar(255) DEFAULT NULL,
  `target_name` varchar(100) DEFAULT NULL,
  `target_pcid` bigint(20) unsigned DEFAULT '0',
  `target_cd` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10271 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC$$


*/