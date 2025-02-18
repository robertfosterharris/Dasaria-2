#include "i_utility"

// Get Is MyDebug Mode On/Off
// iBol : 1 for On, 0 for Off
int StartingConditional(int iBol){
	return (GetLocalInt(GetModule(), MDB) == iBol);
}