//onspawn for carcerum gas chamber listener
//frac
void main() 
{
 effect eInvis = ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
 effect eGhost = EffectCutsceneGhost();

 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

 
 //capitalization doesnt matter so no worries
 SetListening(OBJECT_SELF, TRUE);
 SetListenPattern(OBJECT_SELF, "**Abelis**", 72001);
 SetListenPattern(OBJECT_SELF, "**Abelis.**", 72002);
 SetListenPattern(OBJECT_SELF, "**Abelis!**", 72003);
 
 
 SetListenPattern(OBJECT_SELF, "**lochwar**", 72010);
 SetListenPattern(OBJECT_SELF, "**druaga**", 72011);
 SetListenPattern(OBJECT_SELF, "**lochwar.**", 72012);
 SetListenPattern(OBJECT_SELF, "**druaga.**", 72013);
 SetListenPattern(OBJECT_SELF, "**druaga!**", 72014);
 SetListenPattern(OBJECT_SELF, "**lochwar!**", 72015);
 
 SetListenPattern(OBJECT_SELF, "**lochtra**", 72016);
 SetListenPattern(OBJECT_SELF, "**lochtra.**", 72017);
 SetListenPattern(OBJECT_SELF, "**lochtra!**", 72018);
}