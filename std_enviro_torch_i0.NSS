/*
*/

void	std_enviro_torch_light( object oTorch );
int 	std_enviro_torch_IsLit( object oTorch );
void	std_enviro_torch_extinguish( object oTorch );


// The delta positions for x, y, z (only z is currently implemented)
string	std_enviro_torch_flame_dx = "cfg_flame_dx";
string	std_enviro_torch_flame_dy = "cfg_flame_dy";
string	std_enviro_torch_flame_dz = "cfg_flame_dz";




/*
	Implementation follows
*/


// Resrefs of key objects
string invis_object_resref = "std_plc_invisibleobject";
string	std_enviro_torch_kSoundTag = "cfg_SoundObject";

void	std_enviro_torch_light( object oTorch )
	{
		
	// Only light once (so we don't "lose" the 1st flame)
	if ( std_enviro_torch_IsLit(oTorch) )
		return;
		
		string sEffect = GetLocalString( oTorch, "sEffect");
		if (sEffect == "") sEffect = "fx_torchglow";
	
	// Calculate Location for flame
	// This calculation ignores rotation for now, hence it ignores x&y also
	// That limits it to tiki-torches for the time being
	location loc = GetLocation( oTorch );
	vector v = GetPositionFromLocation(loc);	
	v.z += GetLocalFloat( oTorch, std_enviro_torch_flame_dz);
	loc = Location( GetArea(oTorch), v, 0.0 );
		
	// Create and link the flame
	object oFlame = CreateObject( OBJECT_TYPE_PLACEABLE, 
		invis_object_resref, loc, FALSE, ""
		);
	SetLocalObject( oTorch, "myflame", oFlame );
		
	// Apply flame vfx and light effect
	effect eFlame = EffectNWN2SpecialEffectFile(sEffect, OBJECT_INVALID, v);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlame, oFlame	);
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15); 
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oFlame	);	
	
	
	// Load and play sound
	string SoundTag = GetLocalString( oTorch, std_enviro_torch_kSoundTag );
	object oSound = GetNearestObjectByTag( SoundTag, oFlame );
	if (!GetIsObjectValid(oSound))
		return;		
	if ( GetDistanceBetween(oFlame, oSound) > 3.0 )
		return;
	SoundObjectPlay(oSound);
	}






void	std_enviro_torch_extinguish( object oTorch )
	{
	object oFlame = GetLocalObject( oTorch, "myflame");
	DestroyObject( oFlame );

	// Stop playing sound
	string SoundTag = GetLocalString( oTorch, std_enviro_torch_kSoundTag );
	object oSound = GetNearestObjectByTag( SoundTag, oFlame );
	if (!GetIsObjectValid(oSound))
		return;	
	if ( GetDistanceBetween(oFlame, oSound) > 3.0 )
		return;
	SoundObjectStop(oSound);
	
	}




int 	std_enviro_torch_IsLit( object oTorch )
	{
	object oFlame = GetLocalObject( oTorch, "myflame");
	if ( GetIsObjectValid( oFlame ) )
		return TRUE;
		
	return FALSE;
	}

	
	

/*
*/	