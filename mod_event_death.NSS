/*
	We don't have to do much here.  Just what happens when they
	actually transition to death.
	
	The bleeding heartbeat does most of the work, including
	presenting the respawn screen
	
*/

// wired 09/27/2007 arena-specific death code
// wired 01/17/2010	print to log on pvp kill
// wired 06/09/2010 added lycan death-hook
// wired 09/02/2010 overland map deathhook
// wired 01/07/2010 send a DM shout on player death
// wired 02/04/2012 support for mounts

#include "death_i0_bleed"
#include "ginc_lycan"
#include "dasolm_inc"
#include "d2_sql_log"
#include "std_inc_mounts"

//
//	DROP ALL STOLEN ITEMS ON PVP DEATH
//
void CreatePvPDrop();

void main()
{
	
	object oPlayer = GetLastPlayerDied();
	object oLHA = GetLastHostileActor(oPlayer);
	string sPCName = GetName(oPlayer);
	string sLHAName = GetName (oLHA);
	string sPlayerName = GetLocalString(oPlayer, "PlayerName");
	string sPlayerCDKEY = GetLocalString(oPlayer, "PlayerPublicCDKey");
	int nPlayerHD = GetHitDice(oPlayer);
	string sLHAPlayerName;	
	string sLHACDKEY;
	int nLHAHD = GetHitDice(oLHA);
	string sAnnounce;
	
	int nLycan;	
	
	// Feedback
	SendMessageToPC(oPlayer, "You have died.");
	
	// wired 02/04/2012: mounted player
	DestroyObject(GetLocalObject(oPlayer,"oSaddle"));
	//AssignCommand(GetModule(),DestroyObject(GetLocalObject(oPlayer,"oSaddle")));
	
	if (GetIsMounted(oPlayer))
	{
		if (bDEBUG_mounts) SendMessageToPC(oPlayer,"DEBUG: GetIsMounted was just called from mod_event_death!");
		OnMountedPCDeath(oPlayer);
	}
	
	// clean them up again in case something went wrong
	MountedPCCleanUp(oPlayer);

	// wired 9/27/07: Check for death in arena
	object oArea = GetArea(oPlayer);
	string sArea = GetTag(oArea);
	string sAreaName = GetName(oArea);
	if( sArea == "ceararena")
	{
		// do something extra than normal
		ExecuteScript("arena_customdeath", oPlayer);
		return;
	}

	// Notify bleeding / death
	death_event_OnDeath( oPlayer );
		
	if ( GetIsPC(oLHA) && !GetIsDMPossessed(oLHA) )
	{
		// Wired 09/02/2010 Special Lendose OLM Logic
		if (FindSubString(sArea,"lendose_ol",0) != -1)
        {
				 DasOL_DeathHook(oPlayer, oLHA);
		}
		
		CreatePvPDrop();
		
		trackEvent(oLHA,"PVP_KILL",oPlayer,nLHAHD,nPlayerHD);
		
		sLHAPlayerName  = GetLocalString(oLHA, "PlayerName");
		sLHACDKEY = GetLocalString(oLHA, "PlayerPublicCDKey");
		
		sAnnounce = "PVP KILL: "+sLHAName+" ["+IntToString(nLHAHD)+"] "+sLHAPlayerName+" ("+sLHACDKEY+") kills "+sPCName+" ["+IntToString(nPlayerHD)+"] "+sPlayerName+" ("+sPlayerCDKEY+") in "+sAreaName;
		WriteTimestampedLogEntry(sAnnounce);
		SendMessageToAllDMs(sAnnounce);
			
		// if oPLayer killed by Lycan, spread the disease
		 nLycan = GetLocalInt(std_journal_get( oLHA ),"nLycan");
		 if (nLycan == 1) MakeLycan(oPlayer,1);
		 if (nLycan == 2) MakeLycan(oPlayer,2);					
	}
	
	trackEvent(oPlayer,"PC_DEATH",oLHA,nPlayerHD,nLHAHD,sLHAName);	
	SendMessageToAllDMs("PC DEATH: "+sPCName+" ["+IntToString(nPlayerHD)+"] "+sPlayerName+" ("+sPlayerCDKEY+") in "+sAreaName+" is killed by "+sLHAName+" ["+IntToString(nLHAHD)+"] ");
	
	// wired 06/09/2010 if killed by howling, infect player with lycanthropy
	if ( FindSubString(GetResRef(oLHA),"howling") != -1 ) MakeLycan(oPlayer,1);
		
	// * increment global tracking number of times that I died
	SetLocalInt(oPlayer, "NW_L_PLAYER_DIED", GetLocalInt(oPlayer, "NW_L_PLAYER_DIED") + 1);
	
	// * BK: Automation Control. Autopcs ignore death
	if (GetLocalInt(oPlayer, "NW_L_AUTOMATION") == 10)
	{
		//Raise(oPlayer);
		//DelayCommand(1.0, ExecuteScript("crawl", OBJECT_SELF));
		return; // Raise and return
	}
}

void CreatePvPDrop()
{
	object oContainer;
	object oItem;
	object oKiller;
	object oPC;
	object oEar;

	oPC = GetLastPlayerDied();;
	oKiller = GetLastHostileActor(oPC);
	
	oEar = CreateObject(OBJECT_TYPE_ITEM,"assassin_victim_ear",GetLocation(oPC));
	SetFirstName(oEar,GetFirstName(oPC)+" "+GetLastName(oPC)+"'s Ear");
	SetDescription(oEar,"This is a token of the defeat of "+GetFirstName(oPC)+" "+GetLastName(oPC)+" in combat.");

	oItem = GetFirstItemInInventory(oPC);
	while (GetIsObjectValid(oItem))
	{
		if (GetStolenFlag(oItem))
		{
			if (!GetIsObjectValid(oContainer))			//  CONTAINER NOT YET CREATED
			{
				oContainer = CreateObject(OBJECT_TYPE_PLACEABLE, "d2_pc_death_drop", GetLocation(oPC));
				SetFirstName(oContainer, GetName(oPC) + "'s Items");
				SetLocalObject(oContainer, "oPC", oPC);
				SetLocalObject(oContainer, "oKiller", oKiller);
			}
			SetLocalInt(oItem, "bStolenDrop", TRUE);	//  SECURITY MEASURE TO PREVENT KILLERS FROM ADDING ITEMS TO THE DROP CONTAINER INORDER TO CLEAR STOLEN FLAGS
			CopyItem(oItem, oContainer, TRUE);
			DestroyObject(oItem);
		}			
		oItem = GetNextItemInInventory(oPC);
	}
}
/*
*/