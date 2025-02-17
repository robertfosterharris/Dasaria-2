// ga_gtr_teleport
//
//	GetLocalInt(oPC,"tel_target"); 1=self 2=portal stone 0=other
//
//	RW 201402020 retained if required for roll back to spawnsystem v1

#include "x0_i0_partywide"
#include "ginc_spawnsystem"
#include "std_inc_mounts"


int CheckPartyGathered(object oPC);

void PortParty(object oPC, location lLoc);

void DoMishap(object oPC);

void KillParty(object oPC);

void main(string sDest, int iTargetWP)
{

}
/*

	object oPC 			= GetPCSpeaker();
	object oArea;
	int nCasterLevel 	= GetCasterLevel(oPC);
	int nLimit 			= nCasterLevel/3;
	int nMembers		= GetNumberPartyMembers(oPC)-2;
	int nType			= GetLocalInt(oPC,"tel_target");
	int nRoll;
	int nWP;
	object oWP;
	location lLoc;
	
	if (sDest == "")
	{
		iTargetWP = (DASARIA_SPAWN_WP1_KNOW << iTargetWP-1);
		oWP = GetObjectByTag(sGet_LocationsName(iTargetWP,0));
	}
	else
	{
		oWP = GetWaypointByTag( sDest );
	}
	
	DeleteLocalInt(oPC,"tel_target");
	
	// can't jump to an interior area if somebody in the party is mounted
	if (!GetCanTransition(oPC,oArea, TRUE))
	{
		SendMessageToPC(oPC, "Spell Failed! Cannot teleport to an indoor area while mounted.");
		return;	
	}
	
	// last spell was something different
	if (GetLocalInt(oPC, "LASTSPELL") != 1804)
	{
		SendMessageToPC(oPC, "Spell Failed! You lost concentration while casting another spell.");
		return;	
	}

	// can't teleport if encumbered
	if (GetEncumbranceState(oPC) != ENCUMBRANCE_STATE_NORMAL)
	{
		SendMessageToPC(oPC, "Spell Failed! You are encumbered and cannot cast this spell.");
		return;
	}
	
	// need 100gp
	if (GetGold(oPC) < 100)
	{
		SendMessageToPC(oPC, "Spell Failed! You lack the material components necessary for this spell.");
		return;
	}
	
	// You may also bring one per three caster levels. 
	if ( nMembers > nLimit)
	{
		SendMessageToPC(oPC, "Spell Failed! There are too many members in your party.  You can transport a maximum of " +IntToString(nLimit)+ " additional party members at your Caster Level.");
		return;
	}
	
	// party must be gathered
	if (!CheckPartyGathered(oPC))
	{
		SendMessageToPC(oPC, "Spell Failed! You must gather your party members  All creatures to be transported must be within close proximity or in contact with one another.");
		return;
	}

	TakeGoldFromCreature(100,oPC,TRUE,TRUE);
	
	switch(nType)
	{
		case 1:
		{
			SendMessageToPC(oPC, "Casting <i>Greater Teleport</i> without a proper Focus can be dangerous!");
		
			nRoll = d10(1);
			
			// give a 1/3rd caster level bonus if they can pass a spellcraft
			if (GetIsSkillSuccessful(oPC,SKILL_SPELLCRAFT,20,TRUE))
			{
				nRoll = nRoll+nLimit;
			}
			
			switch(nRoll)
			{
				case 1: KillParty(oPC);
				break;
				case 2: 
				case 3: 
				case 4: DoMishap(oPC);
				break;		
				case 5: 
				{
					// port to CURRENT location
					PortParty(oPC,GetLocation(oPC)); 
					FloatingTextStringOnCreature("You've teleported to your current location.",oPC);			
				}	
				break;			
				case 6: 
				{
					// random distance from current location					
					lLoc = GetLocation(oPC); 
					lLoc = CalcPointAwayFromPoint( lLoc, lLoc, IntToFloat(d20(2)), IntToFloat(d100(1)), FALSE );
					lLoc = CalcSafeLocation(oPC,lLoc,20.0f,FALSE,FALSE);
					PortParty(oPC,lLoc); 
					FloatingTextStringOnCreature("You've teleported a distance not far from where you started.",oPC);
				}
				break;
				
				case 7: 
				{
					// random spawn system area
					nWP = d20()-1;
					lLoc = GetLocation(	GetWaypointByTag("SPAWN_WP_"+IntToString(nWP))	);
					PortParty(oPC,lLoc); 
					FloatingTextStringOnCreature("You've arrived in an unexpected location.",oPC);
				}
				break;
				
				case 8:  
				{
					//port to starting area
					PortParty(oPC,GetLocation(GetObjectByTag("SPAWN_WP_00"))); 
					FloatingTextStringOnCreature("You've arrived in an unexpected location.",oPC);
				}
				break;
				
				case 9:  
				{
					// random distance away from intended target
					lLoc = GetLocation(oWP); 
					lLoc = CalcPointAwayFromPoint( lLoc, lLoc, IntToFloat(d20(2)), IntToFloat(d100(1)), FALSE );
					lLoc = CalcSafeLocation(oPC,lLoc,20.0f,FALSE,FALSE);
					PortParty(oPC,lLoc); 
					FloatingTextStringOnCreature("You've arrived near to your target.",oPC);
				}
				break;
				
				case 10: // or higher with bonuses
				default:
					PortParty(oPC,GetLocation(oWP)); // normal
			}
			break;
		}
		
		case 2:
		{
			if ( !GetIsObjectValid( oWP ) )
			{
				SendMessageToPC(oPC, "Spell Failed! False Destination.");
				return;
			}
		
			PortParty(oPC,GetLocation(oWP));
			break;
		}
		default:
		
		SendMessageToPC(oPC, "Spell Failed! Invalid Target.");
		return;
	}
		
}

int CheckPartyGathered(object oPC)
{
	object oMember = GetFirstFactionMember(oPC,1);
	while (GetIsObjectValid(oMember))
	{
		float fDist = GetDistanceBetween(oPC,oMember);
		if  ( (fDist > 2.0 || fDist == 0.0) && oMember != oPC)
		{
			return FALSE;
		}
		oMember = GetNextFactionMember(oPC,1);
	}
		return TRUE;
}

void PortParty(object oPC, location lLoc)
{
	object oPartyMem;
	effect eTeleport2	= EffectNWN2SpecialEffectFile("fx_teleport");
	
	oPartyMem = GetFirstFactionMember(oPC);	
	while (GetIsObjectValid(oPartyMem)) 
	{			
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTeleport2,GetLocation(oPartyMem));
		AssignCommand(oPartyMem, JumpToLocation(lLoc));
		
		oPartyMem = GetNextFactionMember(oPC);
	}
}

void DoMishap(object oPC)
{
	object oPartyMem;
	effect eTeleport2	= EffectNWN2SpecialEffectFile("fx_teleport");
	effect eDMG;
	
	oPartyMem = GetFirstFactionMember(oPC);	
	while (GetIsObjectValid(oPartyMem)) 
	{			
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTeleport2,GetLocation(oPartyMem));
		eDMG = EffectDamage(d10());
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eDMG,oPartyMem);
		SendMessageToPC(oPartyMem,"Teleportation Failed: Mishap!");		
		oPartyMem = GetNextFactionMember(oPC);
	}
}

void KillParty(object oPC)
{
	object oPartyMem;
	effect eTeleport2	= EffectNWN2SpecialEffectFile("fx_teleport");
	effect eDeath = EffectDeath();
	
	oPartyMem = GetFirstFactionMember(oPC);	
	while (GetIsObjectValid(oPartyMem)) 
	{			
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTeleport2,GetLocation(oPartyMem));
		AssignCommand(oPartyMem, JumpToLocation(GetLocation(oPC)));
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oPartyMem);
		SendMessageToPC(oPartyMem,"Teleportation Failed: Party Scrambled!");		
		oPartyMem = GetNextFactionMember(oPC);
	}
}