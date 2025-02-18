
#include "ginc_playerhousing"

void main(int nClass)
{
	int nPrice = GetPrice(nClass);
	SetCustomToken(8675310,IntToString(nPrice));		
}