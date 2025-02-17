// gc_npc_is_male

int StartingConditional()
{
    if ( GetGender(OBJECT_SELF) == GENDER_MALE ) return TRUE;

    return FALSE;
}