//	GLOBAL CONDITIONAL - RETURNS TRUE IF THE SPEAKER IS A MEMBER OF DASARIA'S STAFF
//
//	ROBERT HARRIS	10/31/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_misc"

int StartingConditional()
{

	return GetIsStaff(GetPCSpeaker());
}