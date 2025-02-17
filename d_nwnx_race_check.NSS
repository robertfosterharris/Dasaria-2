// Checks for dummy model appearance...
// Atharin
int StartingConditional(int nApp)
{

if ((nApp == 1) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_HUMAN)) return FALSE;
if ((nApp == 2) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_HALF_ELF)) return FALSE;
if ((nApp == 3) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_ELF)) return FALSE;
if ((nApp == 4) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_DWARF)) return FALSE;
if ((nApp == 5) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_GNOME)) return FALSE;
if ((nApp == 6) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_HALFLING)) return FALSE;
if ((nApp == 7) && (GetAppearanceType(OBJECT_SELF) == APPEARANCE_TYPE_HALF_ORC)) return FALSE;

return TRUE;
}