//
// ph_gc_occupied
//

#include "ginc_playerhousing"

int StartingConditional()
{
	if ( CountOccupants() > 0)
	{
		return TRUE;
	}
	return FALSE;
}