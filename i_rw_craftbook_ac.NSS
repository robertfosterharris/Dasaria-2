string skillrequired(int iBook_SkillChecked)
{
	string sSkillRequired;

	if(iBook_SkillChecked == 22) sSkillRequired ="Trap Crafting";
	if(iBook_SkillChecked == 25) sSkillRequired ="Armoury";
	if(iBook_SkillChecked == 26) sSkillRequired ="Weapon Crafting";
	if(iBook_SkillChecked == 27) sSkillRequired ="Alchemy";
	if(iBook_SkillChecked == 1092 ||  iBook_SkillChecked == 1093) sSkillRequired ="Encantment";
	
	return sSkillRequired; 
}





string sMakeBigString(string sResRefOfBook)
/* This allows for extending the number crafting text books and means
that its not necessary to store the text for the book meesages as tlk, 2das
or string vars on each book - though ftr a tlk would be easier :)
To update simply add the resref of the new book as a new if statement
(Dont forget to add the ints iBookDC & iBook_SkillChecked to be blueprint ;)
*/
{

//there are size restraints on the size of a string, so they need to be broken in to chunks
// \n = line feed btw 

//assign error message to string vars in the event that an item calls the script in error

	string sString1 ="<i>The book of the Unknown</i>";
	string sString2 ="\n\nThe book you have opened doesn't exisit \n\n";
	string sString3 ="Please post a message on the Dasaria forums and quote: \n";
	string sString4 =" Resref = "+sResRefOfBook;
	string sString5 ="\n\nCheers - The Dasaria Build Team.";
	string sBigString;

	if(sResRefOfBook == "rw_craftbook1")
	{
		sString1 = "Excerpt from Kirkos’ <i>A Comparison of Varanite Metallurgy with that of the Low-folk of the Barbarous Eastern Nations</i>";
		sString2 = "\n\n...to keep the melting point is as low as possible and to ensure that all the constituents crystallize simultaneously, it is necessary to create a eutectic reaction of the ore with the reagents. The proportions of raw ore and Ceraunia knappings must be exact, as I have described  on the previous page, and the forge heated to a white austenitic phase and maintained there for at least 3 days.";
		sString3 = " Only then will the necessary reactions have occurred to allow the final blade to project the argikeraunos.\n\nObviously the quality of the Ceraunia plays a significant part in the amount of energy the blade can transmit, I will in later pages enumerate the physiognomy of the reagent paying especial attention to the characteristrics of a superior sample.\n\nBelow ";
		sString4 = "I have sketched a typical forge constructed by the Torvinhork low-folk who have a long history of working with Darksteel. As you can see in direct contrast to standard designs in the empire the tuyere is...";
		sString5 = "\n\n*a highly technical diagram of a forge is reproduced*";
	}

	if(sResRefOfBook == "rw_craftbook2")
	{
		sString1 = "Excerpt from <i>Adventures among the savage Telkhmar by a Varanite man of Quality<i/>\n\n";
		sString2 = "Then Motega called upon the magic of the spirits of winter to imbue the heads of our warrior’s arrows with spiritual power. Twice he passed them through a pungent haze of smoking herbs, pausing each time to bury the heads in the snow lying about us on the ground.\n";
		sString3 ="This ritual completed all the natives appeared much emboldened and Pallaton announced that they were now prepared to move against the spirit of the tower.\n";
		sString4 ="When faithful Balatro offered his own shafts to Motega  the old faker shook his head and by mime and gesture gave us to understand that the spirits could not overcome the blessings that holy Lochwar had laid upon our good varanite steel.\n";
		sString5 ="In truth I was happy to have the superstitious foolishness out of the way reeking of heresy as it did. Still I judged it good that our allies were now filled with a little fire, though little it helped in the end as you dear reader will soon see...";
	}

	if(sResRefOfBook == "rw_craftbook3")
	{
		sString1 = "Excerpt from <i>Principles of Enchantment for the Beginner. Amaze your acquaintances with the mysteries of the ancients in 5 short weeks! Part 1</i>\n\n";
		sString2 = "…it is essential that your focus for the enchantment be of the highest quality you can afford! Do not be tempted by cheap low-folk burbles or gewgaws, truly only the best will do. ";
		sString3 ="Fortunately Obierp’s (1) stocks a wide range of focus stones of the finest quality as well as a range of candles, incense sticks and crystals.\n*An image of geometric solids fills a large part of the page *\n";
		sString4 ="Only with a suitably prepared and purified focus can you hope to channel (2) the power of your enchantment successfully and transmute the reagents to…\n";
		sString5 ="(1)See back page for an Obierp’s local to your district\n(2) See next week’s issue – channeling the power cosmic";
	}

	if(sResRefOfBook == "rw_craftbook4")
	{
		sString1 = "Excerpt from <i> On the Working and Forging of Theurgical Ores </i>\n\n";
		sString2 = "…The virtues of Mithral are well known in common folklore. Ask any urchin on the street and they will tell you that it is lighter than the best Exodonian steel yet holds its edge twice as long. Equally well known is its ability to allow the flow of Aeytheric energies, in marked contrast to the other heavier elements that are used in theurgical forging.\n";
		sString3 ="Yet, despite this abundance of knowledge, few men have ever seen the metal in its unprocessed form. Even today the secret of its mining and processing are guarded jealously by the low-folk\n";
		sString4 ="\nContrast this with Darksteel. Found in abundance in the Thresian mines of southern Rell, since the reunification of Rell with the Empire in 364 this wondrous metal has again returned to the foundries of the eternal city.";
		sString5 ="With its propensity to absorb argikeraunos (Rhauth’s  fire or lightening in the vulgar) the greatest care must be taken to work the raw ore only with tools of wood or stone. Yet, ask the layman in the taverna what the properties of a blade of Dark Steel are, and, as often as naught, you will receive a look of incomprehension, thus does familiarity bred contempt…";
	}

	if(sResRefOfBook == "rw_craftbook5")
	{
		sString1 = "Excerpt from <i>A history of the whirling serpents</i>\n\n";
		sString2 = "Gloved leather snake\nWelds caustic arcane blade -\nHis foes fall like leaves\n";
		sString3 ="";
		sString4 ="";
		sString5 ="";
	}
//add new bits of flavour text here

//anything else will get the error message

	sBigString = sString1 + sString2 + sString3 + sString4 + sString5;
	return sBigString;
}
//--------------------

//Get the PC's skill rank or feat level
/*
	Skill and Feat Constants  
	SKILL_CRAFT_ALCHEMY = 27
	SKILL_CRAFT_ARMOR = 25
	SKILL_CRAFT_TRAP = 22
	SKILL_CRAFT_WEAPON = 26
	FEAT_CRAFT_WONDROUS_ITEMS = 1093
	FEAT_CRAFT_MAGIC_ARMS_AND_ARMOR = 1092
*/

int GetPCSkillRank(object oPC, int iBook_SkillChecked, string sResRefOfBook)
{
//If the book allows a skill check get the rank the character has (bonuses included)
// GetSkillRank returns -1 for no skill and 0 for untrained
	int iPC_CraftSkill; 	

	if(iBook_SkillChecked==22 || iBook_SkillChecked==25 || iBook_SkillChecked==26 || iBook_SkillChecked ==27)
	{
	//get the PC's skill in the required skill
		iPC_CraftSkill = GetSkillRank( iBook_SkillChecked ,oPC,TRUE);//check for untrained PC
			if(iPC_CraftSkill >0)
			{
				iPC_CraftSkill = GetSkillRank( iBook_SkillChecked ,oPC);
			}
	}
	//or if a feat is required check that they have it
	else if(iBook_SkillChecked==1092 || iBook_SkillChecked== 1093)//add other crafting contstants here if you want to use them
	{
		if(GetHasFeat(iBook_SkillChecked,oPC,TRUE)==TRUE)
		iPC_CraftSkill = 100; 
		else{iPC_CraftSkill = -1;//return the same value as missing a skill
		}
	}
	else
	{
	SendMessageToPC(oPC,"Please post a message that on the Dasaria forums: "+sResRefOfBook+" appears to be trying to check an incorrect skill or feat");
	}

return 	iPC_CraftSkill;
}	
//--------------------

// Function to do a private version of a skill check, no result 
// is told to the PC - oringinally from the nwn1 lexicon
int GetIsSkillSuccessfulPrivate(object oTarget, int iPC_CraftSkill, int nDifficulty)
{
	if (iPC_CraftSkill==100)//ie they have a required feat    
	{
	return TRUE;
	}
	else{
	// Do the roll for the skill
	    if(iPC_CraftSkill + d20() >= nDifficulty)
	    {
	        // They passed the DC
	        return TRUE;
	    }
	    else{// Failed the check
	    return FALSE;
		}
	}
}


//================ i_rw_craftbook_ac====================================
 

#include "std_persist_i0"

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
	object oJournal = std_journal_get(oPC);
	
		
    location lTarget = GetItemActivatedTargetLocation();
	
 	int iPC_CraftSkill;
	int iPC_SkillStored;
	int iBookDC;
	int iBook_SkillChecked;
	int iSkillCheck;
	
	string sPCName;
	string sResRefOfBook;//use this instead of the tag so the same script will work of all books tagged "rw_craftbook" :)
	string sSkillRequired;
	string sBigText;
		
	effect eLore;//vfx of success/failure reading the book
	
	//Get the DC of the particular book - stored as an int, iBookDC, on the book
	iBookDC = GetLocalInt(oItem, "iBookDC");

	//Get the skill the PC will check - stored as an int, iBook_SkillChecked, on the book
	iBook_SkillChecked = GetLocalInt(oItem, "iBook_SkillChecked");
	
	//these next to variables allow us to track if the player has used the book unsuccessfuly before...
	//(stored on the characters journal as an int names after the resref of the book being checked)
	sPCName = GetName(oPC);
	sResRefOfBook = GetResRef(oItem);
	iPC_SkillStored = GetLocalInt(oJournal,sResRefOfBook);//a value of 1000 indicates the PC has previously make this test successfully

	//Get the PCs skill rank or whether they have the required feat
	iPC_CraftSkill = GetPCSkillRank(oPC,iBook_SkillChecked,sResRefOfBook);
	
	//string to fill in text	
	sSkillRequired = skillrequired(iBook_SkillChecked);
	
	if(iPC_SkillStored == 1000)
	{
	//auto success the PC has made this check before

		sBigText = sMakeBigString(sResRefOfBook);
		AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_READ,1.0));
		SendMessageToPC(oPC,"You reexamine the text looking for further hints about advanced principals of "+sSkillRequired+".");

		DisplayMessageBox( oPC, 0, sBigText, "", "", FALSE, "SCREEN_MESSAGEBOX_DEFAULT", 0, "Close the book" );
		}
	else{
		if(iPC_CraftSkill <= -1 )//PC effectively has no skill & therefore no chance of understanding the book
		{
			SendMessageToPC(oPC,"You flip through the book, but it makes for dull reading and you soon find yourself losing interest.");
			//failure fx :(
			eLore = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLore,oPC,1.0);	
		}
		else if(iPC_CraftSkill == 0) //untrained - also no chance of understanding clues in the book
		{
			SendMessageToPC(oPC,"You flip through the book. Intuitively you sense something important about the text but infuriatingly, try as you might, you can't figure out what it is...");
			//failure fx :(
			eLore = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLore,oPC,1.0);
		}
		else //okay the PC has a change of understanding the book
		{
			if( iPC_CraftSkill <= iPC_SkillStored)
				{
				//If you couldn't understand it before, why would you be able to understand it now?
				SendMessageToPC(oPC,"The secret of the book, if it truely has one, continues to defy your understanding...");
				//failure fx :(
				eLore = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLore,oPC,1.0);
				}
			else// either the PC has not made this test before, or their skill has increased
			{
				if (GetIsSkillSuccessfulPrivate(oPC, iPC_CraftSkill, iBookDC))
   					{
					//Success!!! yay for you
					SetLocalInt(oJournal,sResRefOfBook,1000); //use nice safe int value to use as a read successfully marker
					sBigText = sMakeBigString(sResRefOfBook);
					//success message
					SendMessageToPC(oPC,"You are sure that the text contains hints about advanced principals relating to "+sSkillRequired+"!");
					//success fx
					eLore = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLore,oPC,1.0);
					//pop the clue messagebox up
					DisplayMessageBox( oPC, 0, sBigText, "", "", FALSE, "SCREEN_MESSAGEBOX_DEFAULT", 0, "Close the book" );
		
					}
    			else
    				{
        			SendMessageToPC(oPC,"Tantalizingly you feel this text touches upon concepts relating to "+sSkillRequired+", but the complexities are beyond you at this time.");
					//failure fx :(
					eLore = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLore,oPC,1.0);
					//Remember the skill they had when they failed >:)
					SetLocalInt(oJournal,sResRefOfBook,iPC_CraftSkill);
					}
			}		
		}
	}	
	
	



	
}