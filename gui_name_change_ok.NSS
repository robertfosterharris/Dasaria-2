//	GUI OK - CHANGES A CREATURES VIA QUILL OF NAME CHANGING.
//
//	07/16/07	RORBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//
//	07/20/07	RFH		CHANGED TO WORK WITH BOTH CREATURES AND ITEMS
//
//  07/27/12	Wired 	If naming companion/familiar, record on journal



#include "std_persist_i0"

void main(string sInput)
{
	int nCharacter;
	object oTarget;
	string sCharacter;
	string sFirstName;
	string sLastName;
	string sOriginalName;
	object oJournal;
	
	oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	sOriginalName = GetName(oTarget);
	
	// Special case where PC is naming their mount for the first time
	if (GetLocalInt(OBJECT_SELF, "nMount") == 1)
	{
		oJournal = std_journal_get( OBJECT_SELF );
		
		if (GetIsObjectValid(oJournal) )
		{
		 	SetLocalString(oJournal,"sMountName",sInput);
			DelayCommand(1.0,DeleteLocalInt(OBJECT_SELF,"nMount"));
		}		
	}	
		
	switch (GetObjectType(oTarget))
	{
		//
		//	CREATURES HAVE BOTH FIRST AND LAST NAMES
		//
		case OBJECT_TYPE_CREATURE:
			//
			//	PARSE OUT FIRST NAME DELIMITED BY SPACE
			//
			nCharacter = 0;
			sCharacter = GetSubString(sInput, nCharacter, 1);
			while ((sCharacter != " ") && (sCharacter != ""))
			{
				sFirstName += sCharacter;
				nCharacter++;
				sCharacter = GetSubString(sInput, nCharacter, 1);
			}
			//
			//	PARSE OUT LAST NAME DELIMITED BY EOL
			//
			nCharacter++;
			sCharacter = GetSubString(sInput, nCharacter, 1);
			while (sCharacter != "")
			{
				sLastName += sCharacter;
				nCharacter++;
				sCharacter = GetSubString(sInput, nCharacter, 1);
			}
	
			SetFirstName(oTarget, sFirstName);
			SetLastName(oTarget, sLastName);
			break;
		//
		//	EVERYTHING ELSE ONLY HAS ONE NAME
		//	
		default:
			SetFirstName(oTarget, sInput);		
			break;
	}
	
	WriteTimestampedLogEntry("NAME CHANGE: " + sOriginalName + " to " + sInput);
}