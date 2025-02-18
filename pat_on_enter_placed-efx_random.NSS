// Create an object as an action (returns VOID)
void CreateObjectVoid(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
{
    CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
}

// Lets placed effects circle
// sEffect = a serie of "nAmount" objects' "Tag Root": Tag = eEffect + nAmount
// nAmount = Amount of placed effects
// sTemplate = original effect blueprint's resource name
// fmaxDelay = a max seconds delay reference between each placed effect (final effect will be randomic)
void EffectCircle(string sEffect, int nAmount, string sTemplate, float fmaxDelay=2.0f)
{
    float fLastRND = IntToFloat(Random(nAmount)), f2f3 = (nAmount * 2) / 3.0; // random related floats
    int iCount = 0; // counter
    object oPC = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, Location(GetArea(OBJECT_SELF), Vector(0.1, 0.1, 0.1), 0.0)); // nearest oPC to Location 0x, 0y, 0z 
    if (!(GetIsObjectValid(oPC))) oPC = GetEnteringObject();
    object oEffect = GetObjectByTag(sEffect + IntToString(++iCount)); // first placed effect
    location lEffect = GetLocation(oEffect); // first placed effect location

    // if not yet valid, search first valid "sEffect + (1 to nAmount)" tagged placed effects
    while (!(GetIsObjectValid(oEffect)) && iCount < nAmount)
        oEffect = GetObjectByTag(sEffect + IntToString(++iCount));
    if (!(GetIsObjectValid(oEffect))) // if no valid first placed effect found, exit from script
        return;
    lEffect = GetLocation(oEffect); // first placed effect location
    DelayCommand(fLastRND, DestroyObject(oEffect)); // destroy old first placed effect
    DelayCommand(fLastRND, CreateObjectVoid(OBJECT_TYPE_PLACED_EFFECT, sTemplate, lEffect, TRUE, sEffect + IntToString(iCount))); // regenerate first placed effect

    // manage other placed effects, while uninterruptedly valid
    oEffect = GetObjectByTag(sEffect + IntToString(++iCount));
    while (GetIsObjectValid(oEffect) && iCount < nAmount + 1)
    {
        lEffect = GetLocation(oEffect); // next placed effect location
        fLastRND = IntToFloat(Random(nAmount)); // create random delay
        DelayCommand(fLastRND, DestroyObject(oEffect)); // destroy next placed effect
        DelayCommand(fLastRND, CreateObjectVoid(OBJECT_TYPE_PLACED_EFFECT, sTemplate, lEffect, TRUE, sEffect + IntToString(iCount))); // regenerate next placed effect
        oEffect = GetObjectByTag(sEffect + IntToString(++iCount));
    }

    fLastRND = IntToFloat(Random(nAmount)); // create auto-recall delay prototype
    if (fLastRND < f2f3) fLastRND = f2f3; // create auto-recall delay
    if (!(GetIsObjectValid(oPC)) || GetArea(oPC) != GetArea(OBJECT_SELF)) // if there are no more PCs in the area, exit from script
        return;
    DelayCommand(fLastRND, EffectCircle(sEffect, nAmount, sTemplate, fmaxDelay)); // auto-recall to circle
}

void main()
{
    if (GetLocalInt(GetArea(OBJECT_SELF), "iLavaCircle") == 0)
    {
        SetLocalInt(GetArea(OBJECT_SELF), "iLavaCircle", 1);
        EffectCircle("n2_sp_fireball_conjure", 5, "n2_sp_fireball_conjure");
        EffectCircle("n2_sp_fireball_hit", 5, "n2_sp_fireball_hit");
		EffectCircle("n2_ss_geyser", 3, "n2_ss_geyser");	
    }
}