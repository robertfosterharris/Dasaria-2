// assign a random number ore veins when triggered
void main()
{
	int nLive = GetLocalInt(OBJECT_SELF,"OreID");
	if (nLive == 0)
	{
		SetLocalInt(OBJECT_SELF,"OreID",Random(10000));
	} 

}