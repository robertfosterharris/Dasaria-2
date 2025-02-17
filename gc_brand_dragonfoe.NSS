// gc_brand_dragonfoe
int StartingConditional()
{
	object oPlayer = GetPCSpeaker();
	if (GetCampaignInt("Cear","Dragonfoe",oPlayer) == 1)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}