// mod_event_chat
//
// This was the xp_chat hook at one point 2009-02-23
// wired 2009/07/17   Rewritten for 1.23's SendChatMessage
// DMs can 'subscribe' to out of zone local chat/whispers

// lots of help on useful dm commands and gui work from pain/brainmeyer @ the citadel

// oSender - the person, NPC, or object who spoke
// oTarget - for CHAT_MODE_TELL and CHAT_MODE_SERVER, this is the person who is receiving the message. 
// nChannel - the CHAT_MODE_* const indicating which channel (tell, dm , shout, etc) was spoken on
// sMessage - the message that is spoken 
// return - return  FALSE to suppress the original message. return TRUE to allow it to display.

#include "ginc_das_jail"
#include "std_i0_markofdeath"
#include "x0_i0_partywide"
#include "ginc_cutscene"
#include "x0_i0_position"
#include "ginc_renown"
#include "std_i0_misc"
#include "ginc_henchman"


//Parses a command in sMessage and runs the corresponding function
//This should only be used in mod_event_chat and it is the master handler for all other functions
int das_ParseCommand(object oSender, object oTarget, string sMessage);

//Make oSender voicethrow to oTarget using sMessage on vChannel
void das_Voicethrow(object oSender, object oTarget, string sMessage, string vChannel);

//Toggles custom channel in sMessage on/off for oSender
//Chat syntax: "+channel" makes oSender listen for messages on the "channel" channel
void das_Channelset(object oSender, string sMessage);

//Make oSender speak in a custom channel in sMessage
//Chat syntax: ";channel Insert Text Here" makes oSender say Insert Text Here on the "channel" channel
void das_Channelsay(object oSender, string sMessage);

//Controls Dasaria DM Chat Commands
void das_DMCommand(object oDM, string sInput, object oTarget = OBJECT_INVALID);

// Handles callback to allow DM Player Description Viewing
void DMExamine(object oDM, object oTarget);

// Send a URL to the player which will open in a separate browser window
void CSLOpenUrl( string sUrl, object oPlayer = OBJECT_SELF );

// Shrink/Restore Player
void ShrinkRestore(object oTarget);

// dump the variables on an object (useful for area or module)
void ListVars(object oObject, object oDM);

void DoDMUninvis(object oPC);
void DoDMInvis(object  oPC);
void CleanPlc(object oTarget);
void SwapDeity(object oDM, object oTarget);
void ToggleEncountersInArea(object oDM);
void SwapAppearance(object oDM, object oTarget);
void DoZombie(object oTarget);
void DoMorph(object oDM, object oTarget);
void togOLM(object oDM);


//Main Function
int StartingConditional(object oSender, object oTarget, int nChannel, string sMessage)
{
	object oDM;
	object oPartyMember;
	string sPre;
	string sSender = GetName(oSender);
	
	string vChannel = GetStringLeft(sMessage,2); //Get first 2 characters
	string sChannel = GetStringLeft(sMessage,1); //Get first character
	string sCommand = GetStringLeft(sMessage,1); //Get first character
	
	// debug
	//object oPig = GetObjectByTag("chat_relay");	
	//SendMessageToAllDMs("Chathook firing");
	
	// surpress the dislikes you message
	if (	FindSubString(sMessage,"dislikes you",0) != -1 ) return FALSE;
	
	if(!GetIsDM(oSender) && GetIsPC(oSender))
	{
		if (nChannel == CHAT_MODE_SILENT_SHOUT)
		{
			SendChatMessage(oSender,oSender,CHAT_MODE_TELL,"<Color=Cyan>"+sMessage);
		}
	}
   
	if(GetIsDM(oSender)||GetIsDMPossessed(oSender) ||GetIsStaff(oSender))
	{
		if (oTarget == OBJECT_INVALID) oTarget = GetPlayerCurrentTarget(oSender);
		
		if(vChannel == ">>") {	das_Voicethrow(oSender,oTarget,sMessage,"n");	return FALSE;	}
		if(vChannel == ">w") {	das_Voicethrow(oSender,oTarget,sMessage,"w");	return FALSE;	}
		if(vChannel == ">s") {	das_Voicethrow(oSender,oTarget,sMessage,"s");	return FALSE;	}
		if(sCommand == "!" ) {	das_DMCommand (oSender,sMessage,oTarget);		return FALSE;	}
	}
	
	if(sChannel == "+"  ) {das_Channelset(oSender, sMessage);            return FALSE;}
   	if(sChannel == ";"  ) {das_Channelsay(oSender, sMessage);            return FALSE;}	

	// if no DM has asked the server to do anything special,
	// don't bother parsing anything further
	if (	GetLocalInt(GetModule(),"chat_active") != 1 && GetLocalInt(GetModule(),"party_supress") != 1	)
	{
		return TRUE;
	}
	
	// allow text to be spoken normally for objects other than
	// PCs, and for any channel other than the standard 'talk' channel.
	if (!GetIsPC(oSender)  )
	{
		return TRUE;
	}
	
	// handle a special case where a DM is supressing partychat
	if (GetLocalInt(GetModule(),"party_supress") == 1)
	{
		if (nChannel == CHAT_MODE_PARTY )
		{
			// loop through the party and send them the message directly
			oPartyMember = GetFirstFactionMember(oSender);
			while (GetIsObjectValid(oPartyMember))
			{
				SendChatMessage(oSender,oPartyMember,CHAT_MODE_TELL,"<Color=#EEEEEE>[Party] "+sMessage,FALSE);				
				oPartyMember = GetNextFactionMember(oSender);
			}
			
			// and make sure any non-supressing DMs also hear it
			oDM = GetFirstPC();
			while ( GetIsObjectValid(oDM) )
			{
				if( GetIsDM(oDM) && GetLocalInt(oDM,"party_supress") != 1)
				{			       
	            	SendChatMessage(OBJECT_INVALID,oDM,CHAT_MODE_SERVER,"<Color=Pink>"+sSender+":</Color> <Color=#EEEEEE>[Party] "+sMessage,FALSE);				
		        }
				oDM = GetNextPC();
			}			
		return FALSE;	// normal partychat is bypassed, so the DM never hears it
		}	
	}		
	
	//	loop over any DMs that are on the server.  if chat_active is true
	//	there must be at least one so we're not wasting our time here
	oDM = GetFirstPC();
	while ( GetIsObjectValid(oDM) )
	{
		if( GetIsDM(oDM) && GetLocalInt(oDM,"chat_listen") == 1 )
		{		
	       	 if(nChannel==CHAT_MODE_TALK)
            	SendChatMessage(OBJECT_INVALID,oDM,CHAT_MODE_SERVER,"<Color=Pink>"+sSender+"</Color>: <Color=#EEEEEE>[Talk] "+sMessage,FALSE);
				// debug
				//SendChatMessage(oPig,oDM,CHAT_MODE_TELL,"<Color=Pink>"+sSender+"</Color>: <Color=#EEEEEE>[Talk] "+sMessage,FALSE);	
         	if(nChannel	==CHAT_MODE_WHISPER)
            	SendChatMessage(OBJECT_INVALID,oDM,CHAT_MODE_SERVER,"<Color=Pink>"+sSender+"</Color>: <Color=Gray>[Whisper] "+sMessage,FALSE);
				// debug
				//SendChatMessage(oPig,oDM,CHAT_MODE_TELL,"<Color=Pink>"+sSender+"</Color>: <Color=Gray>[Whisper] "+sMessage,FALSE);
		}
		oDM = GetNextPC();
	}

	// treat all other cases normally, allowing the text to spoken aloud	
	//debug
	return TRUE;
}


void das_DMCommand(object oDM, string sInput, object oTarget = OBJECT_INVALID)
{
	//if (!GetIsDM(oDM) || !GetIsObjectValid(oDM) ) return;
	//if (!GetIsObjectValid(oTarget)) { SendMessageToPC(oDM,"Invalid Target"); return; }

	int  nLength  	=   GetStringLength(sInput);
	int nSpace   	=   FindSubString(sInput," ");
	int n;
	location lDest;
	object oPartyMem;
   
	// ALL STAFF PERMITTED COMMANDS
	
	if(sInput=="!help")		{	SendMessageToPC(oDM,"!help, !killarea, !kill, !destroy, !boot, !cdkey, !where, !msg, !desc, !sendurl <i>url</i>,"+
													"!rez, !raise, !rezarea, !heal, !eos, !pardon, !jail, !come, !back, !dmgo, !rename <i>newname</i>"+
													"!partyjump, !damage ###, !freeze, !free, !look, !rest, !shrink, !vars, !varsA, !varsM"+
													"!invis, !unvis, !chat, !quiet, !partyxp ####, !xp ####, !motd <i>message</i> !spawn <i>resref</i>"+
													"!setunlock, !setdetect, !setdisarm, !clean, !deity, !togencs, !appear, !zombie, !morph, !moditem, "+
													"!renown ##, !canite, !imperial, !rebel, !hostile, !commoner, !defender, !neutral, !aion, !aioff, !givefeat ####, !removefeat ####, !addhench <i>objecttag</i>, !gettag, !lockvault, !unlockvault");	}
	if(sInput=="!boot")			{	BootPC(oTarget);	}
	if(sInput=="!cdkey")		{	SendMessageToPC(oDM,GetPCPlayerName(oTarget)+"'s CD Key is: "+GetPCPublicCDKey(oTarget));	}
	if(sInput=="!vars")			{ 	ListVars(oTarget,oDM);	}
	if(sInput=="!varsA")		{ 	ListVars(GetArea(oDM),oDM);	}
	if(sInput=="!varsM")		{ 	ListVars(GetModule(),oDM);	}
	if(sInput=="!lockvault")	{ 	DeleteLocalInt(GetModule(),"bUnlockVault");	}
	if(sInput=="!unlockvault")	{ 	SetLocalInt(GetModule(),"bUnlockVault",TRUE);	}			
	if(sInput=="!where")		
	{	
		object oTarger = GetFirstPC();	
		string player_or_dm = "Player ";
	
		while (OBJECT_INVALID != oTarget) 
		{
			if (TRUE == GetIsDM(oTarget)) 
			{
				player_or_dm = "DM ";
			}
			else
			{
				player_or_dm = "Player ";	
			}
			SendMessageToPC(oDM, player_or_dm + GetFirstName(oTarget) + " " + GetLastName(oTarget) + "("+IntToString(GetHitDice(oTarget))+") is in " + GetName(GetArea(oTarget)));
			oTarget = GetNextPC();
		}	
	}
	if(sInput=="!destroy")	{	DestroyObject(oTarget);	}
	if(GetStringLeft(sInput,5)=="!motd") 	{	SetLocalString(GetModule(),"motd",GetSubString(sInput,6,200)); }	
	
	// DM ONLY COMMANDS
	
	if (GetIsDM(oDM) || GetIsDMPossessed(oDM))
	{
		if(sInput=="!jail")    	{	issueWarrant(oTarget,oDM); lDest = GetOpenCell(oTarget); AssignCommand( oTarget, JumpToLocation(lDest)); 	} 	
		if(sInput=="!kill")		{	ApplyEffectToObject(0,EffectDeath(0,1,1),oTarget);	}
		if(sInput=="!rez")		{	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); std_death_mark_remove( oTarget ); ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget); 	}
		if(sInput=="!aioff")
		{
			n = 1;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			while (GetIsObjectValid(oTarget))
			{
				SetAILevel(oTarget,AI_LEVEL_VERY_LOW);
				n++;
				oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			}		
		}		
		if(sInput=="!aion")
		{
			n = 1;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			while (GetIsObjectValid(oTarget))
			{
				SetAILevel(oTarget,AI_LEVEL_DEFAULT);
				n++;
				oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			}		
		}	
		if(sInput=="!killarea")
		{
			n = 1;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			while (GetIsObjectValid(oTarget))
			{
				DestroyObject(oTarget);
				n++;
				oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oDM, n);
			}		
		}			
		if(sInput=="!rezarea")
		{
			n = 1;
			oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oDM, n);
			while (GetIsObjectValid(oTarget))
			{
				ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); 
				std_death_mark_remove( oTarget ); 
				ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget); 
				
				n++;
				oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oDM, n);
			}	
		}	
		if(sInput=="!raise")	{	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oTarget); std_death_mark_remove( oTarget );  }
		if(sInput=="!heal")    	{	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oTarget)),oTarget);	}
		if(sInput=="!eos")     	{	std_reputation_set( oTarget, "cearguard", 1 ); std_reputation_reset( oTarget, "cearguard" ); 	}
		if(sInput=="!pardon")  	{	std_reputation_set( oTarget, "cearguard", 80 ); std_reputation_reset( oTarget, "cearguard" ); 	}
		if(sInput=="!come")  	{	SetLocalLocation(oTarget,"came_from",GetLocation(oTarget)); AssignCommand(oTarget,JumpToLocation(GetLocation(oDM)));	}
		if(sInput=="!back")  	{	AssignCommand(oTarget,JumpToLocation( GetLocalLocation(oTarget,"came_from")) );	}
		if(sInput=="!dmgo")    	{	AssignCommand(oDM,JumpToLocation(GetLocation(oTarget)));	}
		if(sInput=="!freeze")   {	AssignCommand(oTarget,ClearAllActions()); SetCommandable(FALSE,oTarget);  }
		if(sInput=="!free")    	{	AssignCommand(oTarget,ClearAllActions()); SetCommandable(TRUE,oTarget);  }
		if(sInput=="!rest")    	{	ForceRest(oTarget);	}
		if(sInput=="!look")    	{	AssignCommand(oDM,ActionExamine(oTarget));	}
		if(sInput=="!desc")    	{	DMExamine(oDM,oTarget);	}
		if(sInput=="!invis")	{	DoDMInvis(oDM);	}
		if(sInput=="!unvis")	{	DoDMUninvis(oDM);	}
		if(sInput=="!clean")	{	CleanPlc(oTarget);	}
		if(sInput=="!deity")	{	SwapDeity(oDM,oTarget);	}
		if(sInput=="!togencs")	{ 	ToggleEncountersInArea(oDM);	}
		if(sInput=="!appear")	{ 	SwapAppearance(oDM,oTarget); }
		if(sInput=="!zombie")	{ 	DoZombie(oTarget); }	
		if(sInput=="!morph")	{ 	DoMorph(oDM, oTarget); }
		if(sInput=="!chat")		{	SetLocalInt(oDM,"chat_listen",1); SetLocalInt(GetModule(),"chat_active",1); }
		if(sInput=="!quiet")	{	DeleteLocalInt(oDM,"chat_listen"); DeleteLocalInt(GetModule(),"chat_active"); }	
		if(sInput=="!shrink")	{	ShrinkRestore(oTarget); }
		if(sInput=="!togOLM")	{	togOLM(oDM); }
		if(sInput=="!canite")	{ 	ChangeFaction(oTarget, GetObjectByTag(METAFAC_CANITE_PROXY)); }	
		if(sInput=="!rebel")	{ 	ChangeFaction(oTarget, GetObjectByTag(METAFAC_REBEL_PROXY)); }	
		if(sInput=="!imperial")	{ 	ChangeFaction(oTarget, GetObjectByTag(METAFAC_IMPERIAL_PROXY)); }	
		if(sInput=="!neutral")	{ 	ChangeFaction(oTarget, GetObjectByTag("d2_faction_neutral")); }	
		if(sInput=="!hostile")	{	ChangeToStandardFaction(oTarget,STANDARD_FACTION_HOSTILE);  }
		if(sInput=="!commoner")	{	ChangeToStandardFaction(oTarget,STANDARD_FACTION_COMMONER);  }
		if(sInput=="!defender")	{	ChangeToStandardFaction(oTarget,STANDARD_FACTION_DEFENDER);  }
		if(sInput=="!lightning"){	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_SPELL_DUR_CALL_LIGHTNING),GetLocation(oDM));  }
		if(sInput=="!moditem")	{	AssignCommand(oDM,ActionStartConversation(oDM,"vn_mdp_moditem_conversation",TRUE,FALSE)); }
		
		if(sInput=="!partyjump")
		{
			oPartyMem = GetFirstFactionMember(oTarget, FALSE);
			while (GetIsObjectValid(oPartyMem)) 
			{
				FadeToBlack(oPartyMem);
				AssignCommand(oPartyMem, JumpToLocation(GetLocation(oDM)));
				FadeFromBlack(oPartyMem);
		        oPartyMem = GetNextFactionMember(oTarget, FALSE);
		    }
		}	
		if(GetStringLeft(sInput,7)=="!damage") 	{ 	int nDamage=StringToInt(GetSubString(sInput,8,3)); ApplyEffectToObject(0,EffectDamage(nDamage,1,6,1),oTarget); }
		if(GetStringLeft(sInput,8)=="!partyxp") {	GiveXPToAll(oTarget,StringToInt(GetSubString(sInput,9,4))); }
		if(GetStringLeft(sInput,3)=="!xp") 		
		{	
			GiveXPToCreature(oTarget,StringToInt(GetSubString(sInput,4,4))); 
			SendMessageToAllDMs(GetName(oDM)+" awarded "+GetSubString(sInput,4,4)+"xp to "+GetName(oTarget));
			SendMessageToPC(oTarget,"DM rewarded you "+GetSubString(sInput,4,4)+"xp.");
		}
		if(GetStringLeft(sInput,7)=="!renown") 		
		{	
			changePCMetaFactionRenown(oTarget,StringToInt(GetSubString(sInput,8,2))); 
			SendMessageToAllDMs(GetName(oDM)+" awarded "+GetSubString(sInput,8,2)+" renown to "+GetName(oTarget));
			SendMessageToPC(oTarget,"DM rewarded you "+GetSubString(sInput,8,2)+" renown.");
		}	
		if(GetStringLeft(sInput,9)=="!givefeat") 		
		{	
 			FeatAdd(oTarget, StringToInt(GetSubString(sInput,10,4)), TRUE);
		}	
		if(GetStringLeft(sInput,11)=="!removefeat") 		
		{	
 			FeatRemove(oTarget, StringToInt(GetSubString(sInput,12,4)));
		}
		if(GetStringLeft(sInput,9)=="!addhench") 		
		{	
			HenchmanAdd(oTarget,GetNearestObjectByTag(GetSubString(sInput,10,32),oTarget),TRUE,TRUE);
 		}
		if(GetStringLeft(sInput,7)=="!gettag") 		
		{	
			SendMessageToPC(oDM,"Tag of Object is: "+GetTag(oTarget));
 		}					
			
		if(GetStringLeft(sInput,8)=="!sendurl") {	CSLOpenUrl( GetSubString(sInput,9,200),oTarget ); }
		if(GetStringLeft(sInput,7)=="!rename")
		{	
				SetLocalObject(oDM, "oTarget", oTarget);
				DisplayInputBox (oDM, 0, "Enter New Name", "gui_name_change_ok", "gui_name_change_cancel",
				TRUE, "", 0, "", 0, "", GetName(oTarget));
		}	
		if(GetStringLeft(sInput,6)=="!spawn") 	
		{			
			CreateObject(OBJECT_TYPE_CREATURE,GetSubString(sInput,7,GetStringLength(sInput)-7),CalcSafeLocation(oTarget,GetBehindLocation(oTarget),30.0,TRUE,FALSE));
		}	
		if(GetStringLeft(sInput,10)=="!setunlock") 	{ 	int nDC=StringToInt(GetSubString(sInput,11,3)); SetLockUnlockDC(oTarget, nDC); }
		if(GetStringLeft(sInput,10)=="!setdisarm") 	{ 	int nDC=StringToInt(GetSubString(sInput,11,3)); SetTrapDisarmDC(oTarget, nDC); }
		if(GetStringLeft(sInput,10)=="!setdetect") 	{ 	int nDC=StringToInt(GetSubString(sInput,11,3)); SetTrapDisarmDC(oTarget, nDC); }
	}
}

void das_Voicethrow(object oSender, object oTarget, string sMessage, string vChannel)
{
	if (!GetIsDM(oSender) || !GetIsObjectValid(oSender) ) return;
	if (!GetIsObjectValid(oTarget)) { SendMessageToPC(oSender,"Invalid Target"); return; }
	
	int nLength = GetStringLength(sMessage);
	if(vChannel=="n") SendChatMessage(oTarget,oSender,CHAT_MODE_TALK,GetSubString(sMessage,4,nLength - 4));
	if(vChannel=="w") SendChatMessage(oTarget,oSender,CHAT_MODE_WHISPER,GetSubString(sMessage,4,nLength - 4));
	if(vChannel=="s") SendChatMessage(oTarget,oSender,CHAT_MODE_SHOUT,GetSubString(sMessage,4,nLength - 4));
}


void das_Channelset(object oSender, string sMessage)
{
   int nLength  = GetStringLength(sMessage);
   string sChannel = GetLocalString(oSender,"chat_"+GetStringRight(sMessage,nLength-1));
   if(sChannel=="")
   SetLocalString(oSender,"chat_"+GetStringRight(sMessage,nLength-1),GetStringRight(sMessage,nLength-1));
   else
   DeleteLocalString(oSender,"chat_"+GetStringRight(sMessage,nLength-1));
}


void das_Channelsay(object oSender, string sMessage)
{
   int nSpace		= FindSubString(sMessage," ");
   object oTarget	= GetFirstPC();
   string sChan		= GetSubString(sMessage,1,nSpace - 1);
   int nLength		= GetStringLength(sMessage);
   
   while(GetIsObjectValid(oTarget))
   {
      int nListening = (GetIsDM(oTarget)==TRUE&&GetLocalInt(oTarget,"chat_listen")==TRUE?TRUE:FALSE);
      if(GetLocalString(oTarget,"chat_"+sChan)==sChan||nListening==TRUE)
         SendChatMessage(oSender,oTarget,CHAT_MODE_TELL,"<Color=#DDDDDD>["+sChan+"] "+
                        GetStringRight(sMessage,nLength-nSpace));
      oTarget = GetNextPC();
   }
}

void DMExamine(object oDM, object oTarget)
{
	// only works on PCs
	if ( GetIsPC( oTarget ) )
	{
		DisplayGuiScreen(oTarget,"SCREEN_EXAMINE_DESCRIPTION", FALSE, "_SCdescription_data.xml");
		// SetLocalGUIVariable(oDM,"SCREEN_EXAMINE_DESCRIPTION", 0, ObjectToString(oDM) ); //IntToString(ObjectToInt(oDM) )
		int iRandom = Random(20000)+1;
		SetLocalInt( oTarget, "CSL_DATACALLBACKDESCRIPTION", iRandom );
		SetLocalGUIVariable(oTarget,"SCREEN_EXAMINE_DESCRIPTION", 5, IntToString(iRandom) );
		DelayCommand( 2.0f, DeleteLocalInt( oTarget,"CSL_DATACALLBACKDESCRIPTION") );

		DelayCommand( 2.0f, SendMessageToPC( oDM, "Description: "+GetLocalString( oTarget, "DESCRIPTION") ) );
	}
	else
	{
		SendMessageToPC( oDM, "This only works on PC's");
	}
}


void CSLOpenUrl( string sUrl, object oPlayer = OBJECT_SELF )
{
	DisplayGuiScreen( oPlayer, "SCREEN_OPENURL", TRUE, "_CSLOpenURL.xml");
	SetLocalGUIVariable( oPlayer, "SCREEN_OPENURL", 1, sUrl );
}

void ShrinkRestore(object oTarget)
{
	if (GetLocalInt(oTarget, "pcshrunk") == 1)
	{
		SendMessageToAllDMs("Restoring Player "+GetName(oTarget));
		effect eff = GetFirstEffect(oTarget);
	    while (GetIsEffectValid(eff))
	    {
	    	if(GetEffectSpellId(eff) == -1066)
	        {
	        	RemoveEffect(oTarget, eff);
	 		}
	         eff=GetNextEffect(oTarget);
		}
		SetMovementRateFactor(oTarget, 1.00f);
		DeleteLocalInt(oTarget, "pcshrunk");
	}
	else if (GetLocalInt(oTarget, "pcshrunk") != 1)
	{
		SendMessageToAllDMs("Shrinking Player "+GetName(oTarget));
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SetEffectSpellId(SupernaturalEffect(EffectSetScale(0.5, 0.5, 0.5)),-1066),oTarget);
		SetMovementRateFactor(oTarget, 0.5f);
		SetLocalInt(oTarget, "pcshrunk", 1);
	}
}


void DoDMInvis(object  oPC)
{
	effect eEffect = EffectCutsceneGhost();
	eEffect = EffectLinkEffects(eEffect, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY) );
	eEffect = EffectLinkEffects(eEffect, EffectEthereal() );
	eEffect = SupernaturalEffect( eEffect );
	eEffect = SetEffectSpellId(eEffect, -55 );
	SetCollision(oPC, FALSE);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC );
	SetLocalInt(oPC, "appearance", GetAppearanceType(oPC));	
	SetCreatureAppearanceType(oPC, 611);
 }

void DoDMUninvis(object oPC)
{
	SetCollision(oPC, TRUE);
	DelayCommand(2.0, SetCreatureAppearanceType(oPC, GetLocalInt(oPC, "appearance")));
	
	effect eff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eff))
    {
    	if(GetEffectSpellId(eff) == -55)
        {
        	RemoveEffect(oPC, eff);
 		}
         eff=GetNextEffect(oPC);
	}
}

void CleanPlc(object oTarget)
{
	object oInShape = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
	//Cycle through the targets within the spell shape until an invalid object is captured.
	while (GetIsObjectValid(oInShape))
	{
		DestroyObject(oInShape);
		SendMessageToAllDMs("Destroyed Object " + GetTag(oInShape));
	    oInShape = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
	}
}
void SwapDeity(object oDM, object oTarget)
{
	SetLocalObject(oDM,"deity_switch_player",oTarget);
	AssignCommand(oDM,ActionStartConversation(oDM,"dmwand_cnv_setdeity",TRUE,FALSE));
}

void ToggleEncountersInArea(object oDM)
{
   int i = 1;
   object oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oDM );
   while ( GetIsObjectValid( oEncounter ) )
   {
      if (GetEncounterActive( oEncounter ))
      {
         // disable the encounter and flag as dm disabled
         SetEncounterActive( 0, oEncounter );
         SetLocalInt(oEncounter, "DM_DISABLED", 1);
         SendMessageToAllDMs( "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oDM ) ) +
            " switched off by " + GetName( oDM ));
      }
      // if the encounter is disabled, check to see if a dm disabled it
      else if (GetLocalInt(oEncounter, "DM_DISABLED"))
      {
         // re-enable the encounter and clear the dm flag
         SetEncounterActive( 1, oEncounter );
         SetLocalInt(oEncounter, "DM_DISABLED", 0);
         SendMessageToAllDMs( "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oDM ) ) +
            " switched on by " + GetName( oDM ));
      }
      // otherwise, the encounter is disabled and we leave it that way
      oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oDM, ++i);
   }
}

void SwapAppearance(object oDM, object oTarget)
{
	SetLocalObject(oDM, "oTarget", oTarget);	
	
	DisplayInputBox (oDM, 0, "Enter Appearance #", "gui_wand_appearance_ok", "gui_wand_appearance_cancel",
	TRUE, "", 0, "", 0, "", "");
}
	
void DoZombie(object oTarget)
{
    effect eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
    effect ePoly;
    int nPoly = POLYMORPH_TYPE_ZOMBIE;
    int nDuration = 10;
    ePoly = EffectPolymorph(nPoly);
	ePoly = EffectLinkEffects( ePoly, eVis );
	
    //Apply the VFX impact and effects
    AssignCommand(oTarget, ClearAllActions()); // prevents an exploit
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration));	
}

void DoMorph(object oDM, object oTarget)
{
	SetLocalObject(oDM, "oTarget", oTarget);
	
	DisplayInputBox (oDM, 0, "Enter POLYMORPH_TYPE", "gui_wand_polymorph_ok", "gui_wand_polymorph_cancel",
	TRUE, "", 0, "", 0, "", "");

}

void ListVars(object oObject, object oDM)
{
	int iNumVar = GetVariableCount(oObject);
	while (iNumVar >= 0)
	{
		string sVarName = GetVariableName(oObject, iNumVar);
		int iVarType = GetVariableType(oObject, iNumVar);
		
		if (GetVariableType(oObject, iNumVar) == VARIABLE_TYPE_INT)
		{
			SendMessageToPC(oDM,"int "+sVarName+" = "+IntToString( GetVariableValueInt(oObject,iNumVar) ));
		}
		else if (GetVariableType(oObject, iNumVar) == VARIABLE_TYPE_FLOAT)
		{
			SendMessageToPC(oDM,"float "+sVarName+" = "+FloatToString( GetVariableValueFloat(oObject,iNumVar) ));
		}
		else if (GetVariableType(oObject, iNumVar) == VARIABLE_TYPE_STRING)
		{
			SendMessageToPC(oDM,"string "+sVarName+" = "+GetVariableValueString(oObject,iNumVar) );
		}
		else if (GetVariableType(oObject, iNumVar) == VARIABLE_TYPE_DWORD)
		{
			SendMessageToPC(oDM,"object "+sVarName+" = "+ObjectToString( GetVariableValueObject(oObject,iNumVar) ));
		}
		else if (GetVariableType(oObject, iNumVar) == VARIABLE_TYPE_LOCATION)
		{
			SendMessageToPC(oDM,"location "+sVarName+" = "+LocationToString( GetVariableValueLocation(oObject,iNumVar) ));
		}
		iNumVar--;
	}
}

void togOLM(object oDM)
{
	object oArea = GetArea(oDM);
	int bSupress = GetLocalInt(oArea,"bSupress");
	if (bSupress == 1)
	{
		 SetLocalInt(oArea,"bSupress",1);
		 SendMessageToAllDMs("OLM Area "+GetName(oArea)+" encounters supressed"+GetName(oDM));
	}
	if (bSupress == 0) 
	{
		 DeleteLocalInt(oArea,"bSupress");
		 SendMessageToAllDMs("OLM Area "+GetName(oArea)+" encounters enabled by "+GetName(oDM));
	}	
	 
}