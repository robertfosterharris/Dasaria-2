    // wired 02/05/10
    // gc_lang
    //
    // see bottom of this file for valid language strings
    //

    #include "dmfi_inc_langexe"

    int StartingConditional(string sLang)
    {
       object oPC = GetPCSpeaker();
       if (   DMFI_IsLanguageKnown(oPC, sLang) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
       {
          return TRUE;
       }
       return FALSE;
    }


    /*

    // LANGUAGE CONSTANTS
    const string LNG_ANIMAL = "animal";
    const string LNG_ASSASSIN = "assassin";
    const string LNG_ABYSSAL = "abyssal";
    const string LNG_ALZHEDO = "alzhedo";  //was missing
    const string LNG_AQUAN = "aquan";
    const string LNG_AURAN = "auran";
    const string LNG_ALGARONDAN = "algarondan";
    const string LNG_CANT = "cant";
    const string LNG_CELESTIAL = "celestial";
    const string LNG_CHESSENTAN = "chessentan";
    const string LNG_CHONDATHAN = "chondathan";
    const string LNG_CHULTAN = "chultan";
    const string LNG_DWARF = "dwarf";
    const string LNG_DROW = "drow";
    const string LNG_DROWSIGN = "drowsign";
    const string LNG_DRUIDIC = "druidic";
    const string LNG_DRACONIC = "draconic";
    const string LNG_DAMARAN = "damaran";
    const string LNG_DAMBRATHAN = "dambrathan";
    const string LNG_DURPARI = "durpari";
    const string LNG_ELVEN = "elven";
    const string LNG_GNOME = "gnome";
    const string LNG_GOBLIN = "goblin";
    const string LNG_GIANT = "giant";
    const string LNG_GNOLL = "gnoll";
    const string LNG_HALFLING = "halfling";
    const string LNG_IGNAN = "ignan";
    const string LNG_HALARDRIM = "halardrim";
    const string LNG_HALRUAAN = "halruaan";
    const string LNG_ILLUSKAN = "illuskan";
    const string LNG_IMASKAR = "imaskar";
    const string LNG_INFERNAL = "infernal";
    const string LNG_LEETSPEAK = "leetspeak";
    const string LNG_LANTANESE = "lantanese";
    const string LNG_MIDANI = "midani";
    const string LNG_MULHORANDI = "mulhorandi";
    const string LNG_RASHEMI = "rashemi";
    const string LNG_RAUMVIRA = "raumvira";
    const string LNG_SERUSAN = "serusan";
    const string LNG_SHAARAN = "shaaran";
    const string LNG_SHOU = "shou";
    const string LNG_SYLVAN = "sylvan";
    const string LNG_TERRAN = "terran";
    const string LNG_TREANT = "treant";
    const string LNG_TALFIRIC = "talfiric";
    const string LNG_TASHALAN = "tashalan";
    const string LNG_TUIGAN = "tuigan";
    const string LNG_TURMIC = "turmic";
    const string LNG_ORC = "orc";
    const string LNG_NEXALAN = "nexalan";
    const string LNG_OILLUSK = "oillusk";
    const string LNG_UNDERCOMMON = "undercommon";
    const string LNG_ULUIK = "uluik";
    const string LNG_UNTHERIC = "untheric";
    const string LNG_VAASAN = "vaasan";  // was missing
    */