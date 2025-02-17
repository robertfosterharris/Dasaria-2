//	USER DEFINED SCRIPT		DEFINES THE RANDOM NPCS BEHAVIOR, INCLUDING SPEAK STRINGS.
//
//	DASHES ARE NOT RETURNED BY GETTAG, SO CEAR-NORTH = CEARNORTH.
//
//	12/25/2011		ROBERT HARRIS		ROBERTHARRIS@ROBERTHARRIS.COM
//	01/30/2013		ROBERT HARRIS		MAKE SPEAK STRING PC LEVEL BASED
//
//
//	FUNCTION PROTOTYPES
//
void event_attacked();
void event_dialogue();
void buildCommentList(string sComment, int nLevel, int nMinLevel, int nMaxLevel);
//
//	MAIN
//
void main()
{
    int iEvent = GetUserDefinedEventNumber();

    switch (iEvent)
	{
		case EVENT_HEARTBEAT:
			break;	

		case EVENT_PERCEIVE:
			break;	

		case EVENT_END_COMBAT_ROUND:
			break;	

		case EVENT_DIALOGUE:
			event_dialogue();
			break;	

		case EVENT_ATTACKED:
			event_attacked();
			break;	

		case EVENT_DAMAGED:
			break;
	
		case EVENT_DISTURBED:
			break;	

		case EVENT_SPELL_CAST_AT:
			break;	
	}

}
//
//	ATTACKED EVENT
//
void event_attacked()
{
    object oAttacker;
	
	oAttacker = GetLastAttacker();
    if (GetIsObjectValid(oAttacker))
    {
        ClearAllActions();
        SetLocalObject(OBJECT_SELF,"NW_L_GENERICCommonerFleeFrom", oAttacker);
		SpeakString("Help! Help!");
		ActionMoveAwayFromObject(oAttacker, TRUE);
        DelayCommand(3.0f,SignalEvent(OBJECT_SELF, EventUserDefined(0)));
    }

}
//
//	DIALOG EVENT
//
void event_dialogue()
{
	int nComment;
	int nLevel;
	string sArea;
	string sString;
	
	nLevel = GetHitDice(GetLastSpeaker());
				
	if (nLevel != GetLocalInt(OBJECT_SELF, "nLastLevel"))
	{
//
//		INITIALIZE VARIABLES
//
		SetLocalInt(OBJECT_SELF, "nComments", 0);
		SetLocalInt(OBJECT_SELF, "nLastLevel", nLevel);
//
//		BUILD COMMENT LIST BY AREA
//
		sArea = GetTag(GetArea(OBJECT_SELF));
		
		if (sArea == "2bridges")
		{
			buildCommentList("I'm looking for Dead Man's Posies.  Bettina needs them to cure the sick upstairs at the inn.", nLevel, 10, 15);
			buildCommentList("Peralia bless Brother Uriah.  We'd be overrun by lizardmen if not for him and his mercenaries.", nLevel, 10, 15);
			buildCommentList("Have you seen Melinda?  Jal is looking for her.  She's late for her shift at the inn.", nLevel, 10, 15);
			buildCommentList("Death comes equally to us all, and makes us all equal when it comes...poor Lady Verkthed.", nLevel, 10, 15);
			buildCommentList("There's something odd about that woman, Nihtegesa.  She came to town not long ago, asking questions.  She's at the inn now, just staring at people.", nLevel, 12, 15);
			
			buildCommentList("Sister Admatha calls it the Blessed Gift.  I call it nonsense.  Life is the gift, friend.  Life!", nLevel, 1, 20);
			buildCommentList("Go to the Two Bridges Inn if you want a soft bed.  Go to the Redleafe Tavern if you want a hard drink!", nLevel, 1, 20);
			buildCommentList("The crown claims Nergahamman's defeat here a victory.  Look around.  Does this look like a victory to you?", nLevel, 1, 20);
		}
		
		if (sArea == "ceardocks")
		{
			buildCommentList("If one more orphan begs me for a copper, I'm taking up the crook myself!", nLevel, 1, 4);
			buildCommentList("Hide your kids, hide your spouse and hide yourself 'cause those Cuhanans snatchin' everybody out here!", nLevel, 1, 4);
			buildCommentList("Ophelia can't build that orphanage fast enough!", nLevel, 1, 5);
			buildCommentList("I overheard Tracker Blackwater say he's looking for a bunch of deserters.", nLevel, 1, 7);
			buildCommentList("Most of the Sneed family's been taken by the illness.  Perallia keep 'em.", nLevel, 1, 7);
			buildCommentList("I told Horswick to hide his kid.  Those Cuhanans are snatchin' everybody out here!", nLevel, 14, 20);
			
			buildCommentList("Cap'n Earl will be making for Morell today.  Rhauth bless 'em.", nLevel, 1, 20);
			buildCommentList("The Vissen Inn is a dive.  They have cheap rooms, cheap drinks and cheap women.", nLevel, 1, 20);
		}

		if (sArea == "cearnorth")
		{
			buildCommentList("If this is your first time in Cear, you should speak with Ambassador Jylea.", nLevel, 1, 1);
			buildCommentList("You'll never believe who I just ran into at the Mistyvale Inn.  Twenty seven time grand illusion championship winner, Marek the Magnificient!", nLevel, 1, 2);
			buildCommentList("Mistress Maerysa over at the Mistyvale is scared to death of spiders.  It's actually pretty funny.", nLevel, 1, 2);
			buildCommentList("Captain Waldren is inside the Mistyvale handing out writs left and right.", nLevel, 1, 3);
			buildCommentList("Laul is one unlucky sod.  How many times has his wagon wheel busted just outside the gates?", nLevel, 1, 3);
			buildCommentList("Steer clear of Guardsman Hylatt.  His relief is late and he is furious!", nLevel, 1, 4);
			buildCommentList("Poor Lord Dellison spends his days drowning his sorrows at the Mistyvale Inn.", nLevel, 1, 5);
			buildCommentList("Have ya heard?  Tracker Danalus says there's a murderer on the loose!", nLevel, 1, 5);
			buildCommentList("Times are tough.  I might take up trapping for Thyver.", nLevel, 1, 5);
			buildCommentList("Jachim Yvethed would sell his mother for a crown, that unscrupulous bastard!.", nLevel, 2, 5);
			buildCommentList("Captain Farrel will get to the bottom of these animal attacks.", nLevel, 3, 5);
			buildCommentList("Look at Cobb sulkin' about, that hopeless sod.", nLevel, 3, 8);
			buildCommentList("That old coot Wayne says giant bugs are eating his crops.  What a rube.", nLevel, 5, 8);
			buildCommentList("If you see Thyver's daughter, Rosemary, tell her Thyver is looking for her.", nLevel, 6, 9); 
			buildCommentList("I overheard Captain Farell say there's a tribe of bugbears in a cave just outside the city!", nLevel, 5, 10);
			buildCommentList("Dana's brother has gone missing.  The poor girl is worried to death.", nLevel, 5, 10);
			buildCommentList("Wild animals, bugbears and now worg riding goblins, Captain Farell has his hands full!", nLevel, 7, 10);
			buildCommentList("Rest assured, Captain Fennal will find those renegade orcs and put them to the sword!", nLevel, 8, 14);
			buildCommentList("What in the world is Mae brewing in there?  It smells like a wet dog fart!", nLevel, 9, 16);

			buildCommentList("Trust me.  Ealden has the best deals in Cear.", nLevel, 1, 20);
			buildCommentList("Mae has a potion for whatever ails ya.", nLevel, 1, 20);
			buildCommentList("The bowyer A'alson has been reduced to selling torches.", nLevel, 1, 20);
			buildCommentList("I'm going to see Ysgryhm about a pony for my daughter's birthday.", nLevel, 1, 20);
		}
		if (sArea == "ceartc")
		{
			buildCommentList("Merridale swears the Two Tales theater is haunted.  It's his plays that are scaring the customers off!", nLevel, 1, 3);
			buildCommentList("Our soldiers need Tharon's blessing, not this Telkhmarian charm mumbo jumbo!", nLevel, 1, 4);
			buildCommentList("Wright Ironback paid me 100 crowns for making simple deliveries.", nLevel, 1, 3);
			buildCommentList("Does Dorothea have a permit for all those cats?", nLevel, 2, 4);
			buildCommentList("Nienna's Tannin' Salon offers the finest leather goods in Cear.  And she pays well for raw materials too.", nLevel, 1, 5);
			buildCommentList("Turnbull fancies himself an engineer.  I wish the government would pay me to stand around all day.", nLevel, 1, 5);
			buildCommentList("Did you hear that explosion coming from Andus Falier's place the other night?", nLevel, 2, 6);
			buildCommentList("What's going on at the library?  I heard there was an attack or something.", nLevel, 4, 6);
			buildCommentList("Where are Timmy's parents?  That kid is going to drown playing in that fountain.", nLevel, 4, 6);
			buildCommentList("Aldios, of Cearfai and Epicurean Delights, was conned by the so called 'Piper of Landon'.", nLevel, 4, 8);
			buildCommentList("Caoilainn better watch her tongue or she's gonna lose more than her cat.  If you know what I mean.", nLevel, 5, 9);
			buildCommentList("I guess Aegis Ironback is something of a history buff.", nLevel, 5, 10);
			buildCommentList("It wouldn't surprise me if Investigator Darius was on the Kalem Brotherhood payroll!", nLevel, 5, 10);
			buildCommentList("The Monkey Chased the Easel was broken into last night.  Janose had one of her paintings stolen.", nLevel, 5, 10);
			buildCommentList("Teshalia has shunned Taorus Hyrim.  I'd visit him at the Buck Inn but I fear his misfortune is contagious.", nLevel, 5, 10);
			buildCommentList("I never figured Guardsman Tyree for a deserter.", nLevel, 6, 13);
			buildCommentList("I thought monks were solitary.  What's with all the people coming and going from the monastery in the middle of the night?", nLevel, 6, 13);
			buildCommentList("There was a tiefling casing the Imperial Bank.  By the time I found a guard she had disappeared.", nLevel, 5, 15);
			buildCommentList("I heard it was a secret temple of Culnul that burnt down.", nLevel, 7, 13);
			buildCommentList("Is there anything worse than losing a child?  I can only imagine what the Tallifars must be going through.", nLevel, 8, 15);
			buildCommentList("I'm telling you, there are Culnulites hiding in the cellars of alleyways of our fair city.", nLevel, 8, 15);
			buildCommentList("A Singing Seamstress?  Oh please, Evlya ain't noting but a no good home wrecker!", nLevel, 1, 20);
			buildCommentList("I should visit Robert's father.  He spends all day at the Buck Inn, keeping warm by the fire.  Maybe I can cheer him up.", nLevel, 1, 20);
			buildCommentList("Farallis bless Sister Marie for all she does for the people of Cear!", nLevel, 1, 20);
			buildCommentList("Trinda Firestein makes a tasty brew, but it ain't no Hunar's that's for sure.", nLevel, 1, 20);
			buildCommentList("I thought it was just a dusty old rock, but Wright Ironback told me it was a valuable chunk of ore!", nLevel, 1, 20);
			buildCommentList("Fancy yourself a warrior?  You can earn good coin testing yourself against men and beasts in the arena.", nLevel, 5, 20);
			buildCommentList("Sorry, I can't talk.  The gladiator, Barabus, fights for his freedom today, and I don't want to miss it.", nLevel, 5, 20);
			buildCommentList("I'm telling you it was Zephic the Second and a Claw Warlord!  They are at the Ministry of Trade and Commerce right now!", nLevel, 1, 20);
			
			buildCommentList("Do you like my outfit?  Jenna Ironback did the alterations.", nLevel, 1, 20);
			buildCommentList("I kept my crowns in an old cookie jar before the Imperial Bank of Varana opened up.", nLevel, 1, 20);
			buildCommentList("I really should ask the Recorder of Deeds at the bank about refinancing my home.", nLevel, 1, 20);
			buildCommentList("They say a priestess of Nuarari can help you forget the past.", nLevel, 1, 20);
			
		}

		if (sArea == "lendose")
		{
			buildCommentList("If you run into Athorius, let him know his father, Elias, is waiting for him at the Burning Troll Inn.", nLevel, 10, 15);
			buildCommentList("Rumor has it that followers of Tyrak are meeting secretly somewhere in the village.", nLevel, 12, 17);
			buildCommentList("Shouldn't you be at the gates helping Captain Madigan root out those Kor infiltrators?", nLevel, 12, 17);
			buildCommentList("They call me crazy, but I heard that tree crying!  I was so scared I dropped my bucket and ran for home!", nLevel, 12, 17);
			buildCommentList("When did that toystore close?  I was hoping to pick up an Argentum Vigilo action figure for my boy's birthday.", nLevel, 12, 17);
			buildCommentList("Have you heard?  Geoff was locked up for heresy.  The high orator says he will be hanged if he cannot prove his innocence.", nLevel, 12, 17);
			buildCommentList("I can't even look at Calasthere with a straight face anymore!", nLevel, 12, 20);
			buildCommentList("You seem capable.  Why aren't you out on the front, fighting?", nLevel, 15, 20);
			
			buildCommentList("Have you seen Yves Zymurthan? They say he once throttled a hill giant with his bare hands! I wouldn't want to cross him.", nLevel, 1, 20);
			buildCommentList("There were some missionaries from the Church of Lochwar here the other day. Rumor has it that they were heading to the Forest of Daris for some reason.", nLevel, 1, 20);
			buildCommentList("I feel safe knowing that the prince's own army is here.", nLevel, 1, 20);
			buildCommentList("I don't know how we are ever going to rebuild our homes. When will this war end?", nLevel, 1, 20);
			buildCommentList("I hear Emperor Marcus IV has fallen under the spell of Canas!", nLevel, 1, 20);
			buildCommentList("The temples are in pretty bad shape. Iaosia's and Etoth's are the only ones that are still open to the public.", nLevel, 1, 20);
			buildCommentList("Lord Avgral? He lords over Lendose, and whatever remains of the villages nearby. He doesn't have much power so long as the Prince is about, though.", nLevel, 1, 20);
			buildCommentList("I don't know how we're going to make it through the winter.", nLevel, 1, 20);
			buildCommentList("Sure, they keep the Canite invasion at bay... but why aren't they pushing it back?", nLevel, 1, 20);
			buildCommentList("I heard that the terrible Zumen was a five-headed dragon! I'm so glad he's gone now, they say the knights of the Argentum Vigilo slew him.", nLevel, 1, 20);
			buildCommentList("Are you one of the mercenaries they called for?", nLevel, 1, 20);
		}

		if (sArea == "lendose_ol_canas_phazzan")
		{
			buildCommentList("Shhh...someone might hear us speak.", nLevel, 1, 20);
			buildCommentList("Our dark masters has promised their most loyal subjects life eternal!", nLevel, 1, 20);
			buildCommentList("At least here we are protected..", nLevel, 1, 20);
			buildCommentList("This town is the Canite frontier, a bastion of might against the cursed Dasarians. I wish they would just surrender like the rest of us. There is no point resisting the supremacy that is the Canite horde.", nLevel, 1, 20);
			buildCommentList("Rest assured. The true Emperor will be here shortly and then all of Dasaria will fall.", nLevel, 1, 20);
			buildCommentList("I am glad I will be here once the onslaught on Dasaria begins. This will be the safest place.", nLevel, 1, 20);
			buildCommentList("Some say a Dread Lich lives on top of this mountain. At night I hear screams from up there. Might be the wind of course *chuckles nervously*.", nLevel, 1, 20);
			buildCommentList("Don't look the orcs directly in the eyes, those they take to their caves never return.", nLevel, 1, 20);
			buildCommentList("The temple here is the only Dasarian temple spreading the truth about the gods and Canas, praise his name *makes a triangle with his finger in the air*.", nLevel, 1, 20);
		}

		if (sArea == "morell")
		{
			buildCommentList("Stay away from the King's Man pub, stranger.  You'll find nothing but trouble there.", nLevel, 8, 12);
			buildCommentList("Have you seen any poppies around here?  Katherin at the temple of Teshalia needs some.", nLevel, 8, 12);
			buildCommentList("What do you suppose Professor Allgood is hoping to find out there in the old ruins?", nLevel, 10, 15);
			buildCommentList("The Vokk are bad enough.  Now Officer K'tan is says the hobgoblins have returned.", nLevel, 10, 15);
			
			buildCommentList("Fair deals are rare in this town, but you could try Guifford's Produce.", nLevel, 1, 20);
			buildCommentList("Only adventurers like you come to Morell cross-country.  We locals take the ferries out of Sheppard's Landing to the south or the Ravensmouth to the north.", nLevel, 1, 20);
		}
		
		if (sArea == "morelllanding")
		{
			buildCommentList("Excuse me, I need to pack these mink pelts for Miss Graccus.", nLevel, 8, 12);
			buildCommentList("Did Rogers say what happened to the lighthouse?  Rhauth help anyone trying to make port at night.", nLevel, 8, 12);
			buildCommentList("Rogers will need help getting these goods to Morell.  Are you looking for work?", nLevel, 8, 12);
			
			buildCommentList("Captain Earl and I will return to Cear as soon as the ship is unloaded.", nLevel, 1, 20);
			buildCommentList("Morell is just north of here, but watch out for highwaymen.", nLevel, 1, 20);
		}
		
		if (sArea == "rvnwtch")
		{
			buildCommentList("Fancy yourself a mage?  You can earn good coin dueling others at the Collegium Arcanum.", nLevel, 10, 20);
			buildCommentList("Hemma, the herbalist, is always brewing up some god-aweful concoction.", nLevel, 14, 20);
			buildCommentList("Is it true you can enchant a weapon with faerie dust?  Fitria, the blacksmith, says you can.", nLevel, 14, 20);
			buildCommentList("That old drunk, Randolph, is going on about demons and treasure again.", nLevel, 14, 20);
			buildCommentList("I would have fled if I weren't paralyzed with nausae.  What unholy power did those Talon deliver to the Cathedral of Tharon?", nLevel, 14, 20);
			buildCommentList("What kind of madness drove those men to burn down the Magnus Order Honor Society and kill all the students inside?", nLevel, 15, 20);
			buildCommentList("What has come over Phinea?  She used to be such a sweet little girl.", nLevel, 15, 20);
			
			buildCommentList("Do you like my outfit?  Mistress Saraiyvah at the Knitting Factory made the alterations.", nLevel, 1, 20);
			buildCommentList("I kept my crowns in an old cookie jar before the Imperial Bank of Varana opened a branch here in Ravenswatch.", nLevel, 1, 20);
			buildCommentList("I really should ask Mr. Hardesty at the bank about refinancing my home.", nLevel, 1, 20);
			buildCommentList("I'm going to see Raeka about a pony for my daughter's birthday.", nLevel, 1, 20);

		}
	}
//
//	SAY COMMENT
//
	nComment = GetLocalInt(OBJECT_SELF, "nLastComment") + 1;
	if (nComment > GetLocalInt(OBJECT_SELF, "nComments")) nComment = 1;
	
	ActionSpeakString(GetLocalString(OBJECT_SELF, "sComment" + IntToString(nComment)));

	SetLocalInt(OBJECT_SELF, "nLastComment", nComment);

}
//
//	BUILD LIST OF LEVEL DEPENDANT SPEAK STRINGS
//
void buildCommentList(string sComment, int nLevel, int nMinLevel, int nMaxLevel)
{
	int nComments;
	
	if (nLevel >= nMinLevel && nLevel <= nMaxLevel)
	{
		SetLocalInt(OBJECT_SELF, "nComments", GetLocalInt(OBJECT_SELF, "nComments") +1);
		SetLocalString(OBJECT_SELF, "sComment" + IntToString(GetLocalInt(OBJECT_SELF, "nComments")), sComment);
	}
}