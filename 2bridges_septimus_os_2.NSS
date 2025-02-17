// wired 12/26/07
// 2bridges_septimus_os_2
// leave corpse selectable

// gb_spawn_dead_sp
/*
    This spawns in a creature dead
*/
// FAB 2/8
// ChazM 3/8/05

void main()
{

    SetIsDestroyable( FALSE,FALSE,TRUE );
    effect eFX = EffectDeath();
    ApplyEffectToObject( DURATION_TYPE_INSTANT,eFX,OBJECT_SELF );

}