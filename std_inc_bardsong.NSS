// std_inc_bardsong
// wired 01/26/13
//

void d2_PlayBardSongSound()
{
	int nItemType;
	int nGender = GetGender(OBJECT_SELF);
	string sWavRoot;
	string sAnim;
	string sSound;
	object oInstrument = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
	int bDEBUG = FALSE;
	
	if (bDEBUG)SendMessageToPC(OBJECT_SELF,"debug: STD_INC_BARDSONG RUNNING!"); 
	
	//if (GetIsObjectValid(oInstrument))
	//{	
		// does this instrument have a custom song?
		sWavRoot = GetLocalString(oInstrument,"sWavRoot");
		if (bDEBUG) SendMessageToPC(OBJECT_SELF,"debug: Found custom sound?: "+sWavRoot); 
		
		nItemType = GetBaseItemType(oInstrument);
		if (bDEBUG) SendMessageToPC(OBJECT_SELF,"debug: Got basetype: "+IntToString(nItemType)); 
		
		// if not, choose the default song for instrument type
		// (whistle will persist if a non-instrument falls through)
		if (sWavRoot == "")
		{	
			switch (nItemType)
			{
				case BASE_ITEM_FLUTE: 	 	sWavRoot = "flute"; sAnim = "playflute"; break;
				case BASE_ITEM_MANDOLIN: 	sWavRoot = "mando"; sAnim = "playguitar"; break;
				case BASE_ITEM_DRUM: 		sWavRoot = "drum"; sAnim = "playdrum"; break;
				case 202: 					sWavRoot = "bagpipe"; sAnim = "bagpipe"; break;
				default:
				// default to whistle
				sWavRoot ="whistle";	
			}
		}
	//}PlaySound
	sSound = "d2_"+sWavRoot+"song0"+IntToString( d4(1) );
	if (bDEBUG) SendMessageToPC(OBJECT_SELF,"debug: sSound is "+sSound);
	PlaySound(sSound);
	PlayCustomAnimation(OBJECT_SELF,sAnim,0,1.0);
}