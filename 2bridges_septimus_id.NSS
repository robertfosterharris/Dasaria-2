// 2bridges_septimus_id
void main()
{
	// excuse me, did you just remove my head?
	if (GetTag(GetInventoryDisturbItem()) == "2bridges_septimushead" )
	{
		SetIsDestroyable( TRUE );
		DestroyObject(OBJECT_SELF);
	}
}