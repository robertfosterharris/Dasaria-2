//Sets the dummy model appearance...
// Atharin
void main(int nRace)
{
int nApp;
switch (nRace)
{
case 1: nApp=APPEARANCE_TYPE_HUMAN; break;
case 2: nApp=APPEARANCE_TYPE_HALF_ELF; break;
case 3: nApp=APPEARANCE_TYPE_ELF; break;
case 4: nApp=APPEARANCE_TYPE_DWARF; break;
case 5: nApp=APPEARANCE_TYPE_GNOME; break;
case 6: nApp=APPEARANCE_TYPE_HALFLING; break;
case 7: nApp=APPEARANCE_TYPE_HALF_ORC; break;
} 

SetCreatureAppearanceType(OBJECT_SELF,nApp);
}