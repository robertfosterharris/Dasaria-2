#include "X0_I0_POSITION"

void doThrow(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance);
void doLanding(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance);
void doFlag(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance);
void doMeasurment(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance);

void main()
{
	int nThrowDistance;
	float fHammerOrientation;
	location lHammerLocation;
	location lThrowLocation;
	object oFlag;
	object oOfficial;
	object oPC;
	object oHammer;
	vector vHammerVector;

	oPC = GetLastUsedBy();

	oHammer = GetObjectByTag("d2_hammer_standing");
	fHammerOrientation = GetFacing(oHammer);
	lHammerLocation = GetLocation(oHammer);
	vHammerVector = GetPosition(oHammer);

	if (Random(2) > 0)
	{
			fHammerOrientation = fHammerOrientation + Random(20);
	}
	else
	{
			fHammerOrientation = fHammerOrientation - Random(20);
	}

	nThrowDistance = GetAbilityScore(oPC, ABILITY_STRENGTH) * 2 + d20();
	lThrowLocation = Location(GetArea(oPC), GetChangedPosition(vHammerVector, IntToFloat(nThrowDistance), fHammerOrientation), GetFacing(oHammer));

	oOfficial = GetNearestObjectByTag("d2_hammer_official");
	if (!GetIsObjectValid(oOfficial)) oOfficial = CreateObject(OBJECT_TYPE_CREATURE, "d2_hammer_official", lHammerLocation);

	if (GetLocalInt(oPC, "nHammerThrowAttempts") < 3)
	{
		SetLocalInt(oPC, "nHammerThrowAttempts", GetLocalInt(oPC, "nHammerThrowAttempts")+1);
		DestroyObject(oHammer);
		AssignCommand(GetModule(), DelayCommand(2.0f, doThrow(oPC, oOfficial, lHammerLocation, lThrowLocation, nThrowDistance)));
		AssignCommand(GetModule(), DelayCommand(3.0f, doLanding(oPC, oOfficial, lHammerLocation, lThrowLocation, nThrowDistance)));
		AssignCommand(GetModule(), DelayCommand(9.0f, doFlag(oPC, oOfficial, lHammerLocation, lThrowLocation, nThrowDistance)));
		AssignCommand(GetModule(), DelayCommand(14.0f, doMeasurment(oPC, oOfficial, lHammerLocation, lThrowLocation, nThrowDistance)));
	}
	else
	{
		AssignCommand(oOfficial, ActionSpeakString("You've already throw three times " + GetFirstName(oPC) + ".  You're not allowed to throw again.", TALKVOLUME_SHOUT));
	}
}

void doThrow(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance)
{
	AssignCommand(oPC, SetFacingPoint(GetPositionFromLocation(lThrowLocation)));
	PlayCustomAnimation(oPC, "atk_cast", 0);
	PlayVoiceChat(VOICE_CHAT_GATTACK1, oPC);
}
void doLanding(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance)
{
	CreateObject(OBJECT_TYPE_PLACEABLE, "d2_hammer_resting", lThrowLocation);
	AssignCommand(oOfficial, ActionForceMoveToLocation(lThrowLocation, TRUE, 6.0f));
}
void doFlag(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance)
{
	DestroyObject(GetNearestObjectByTag("d2_hammer_resting", oOfficial));

	AssignCommand(oOfficial, SetFacingPoint(GetPosition(oPC)));
	PlayCustomAnimation(oOfficial, "disableground", 0);
	
}
void doMeasurment(object oPC, object oOfficial, location lHammerLocation, location lThrowLocation, int nThrowDistance)
{
	object oFlag;
	
	oFlag = CreateObject(OBJECT_TYPE_PLACEABLE, "d2_hammer_flag", lThrowLocation);
	SetFirstName(oFlag, GetName(oPC));
	SetDescription(oFlag, "Hammer throw of " + IntToString(nThrowDistance) + " meters.");

	AssignCommand(oOfficial, ActionSpeakString(GetName(oPC) + " threw for " + IntToString(nThrowDistance) + " meters!", TALKVOLUME_SHOUT));
	
	CreateObject(OBJECT_TYPE_PLACEABLE, "d2_hammer_standing", lHammerLocation);
}