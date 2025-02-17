// event_nex_speech
// wired 01/11/08
// in case there's not enough staff...

#include "ginc_group"

// break up attack waves so they don't thrash the CPU
void AttackWave(location lPortal1, location lPortal2)
{
	GroupSpawnAtLocation("portal1crew","wired_harbinger",lPortal1,1);
	DelayCommand(2.0,GroupSpawnAtLocation("portal1crew","master_honorguard",lPortal1,1));
	DelayCommand(2.0,GroupSpawnAtLocation("portal1crew","master_summoner",lPortal1,1));
	DelayCommand(5.0,GroupSpawnAtLocation("portal1crew","event_nex_skellie",lPortal1,2));
	DelayCommand(5.0,GroupSpawnAtLocation("portal2crew","c_skeletonwarrior",lPortal2,4));	
	
	GroupSpawnAtLocation("portal2crew","wired_harbinger",lPortal2,1);
	DelayCommand(2.0,GroupSpawnAtLocation("portal2crew","master_honorguard",lPortal2,1));
	DelayCommand(2.0,GroupSpawnAtLocation("portal2crew","master_summoner",lPortal2,1));	
	DelayCommand(5.0,GroupSpawnAtLocation("portal2crew","event_nex_skellie",lPortal2,2));
	DelayCommand(5.0,GroupSpawnAtLocation("portal2crew","c_skeletonwarrior",lPortal2,4));
}

// Master's Voice Gives his little speech
void VoiceOfTheMaster()
{
	effect ePortal1 = EffectNWN2SpecialEffectFile("fx_portal_gen_small");
    effect ePortal2 = EffectNWN2SpecialEffectFile("sp_magic_circle");
	effect eTel = EffectNWN2SpecialEffectFile("fx_teleport");
	object oWP = GetNearestObjectByTag("wp_arena_floor");
	object oArea = GetArea(oWP);
	object oGov = GetNearestObjectByTag("event_nex_nathan_verkethed");	
	location lCenter = GetLocation(oWP);
	location lPortal1 = GetLocation(GetObjectByTag("IP_PORTAL1"));
	location lPortal2 = GetLocation(GetObjectByTag("IP_PORTAL2"));	
	
	SendMessageToAllDMs("THE REBUTTAL HAS STARTED");
	
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,ePortal2,lCenter,2.0);
  	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,ePortal1,lCenter,2.0);
	ApplyEffectAtLocation(0,eTel,lCenter);
	
	CreateObject(OBJECT_TYPE_CREATURE,"event_nex_master_voice",lCenter,TRUE,"event_nex_master_voice");
	object oVoice = GetNearestObjectByTag("event_nex_master_voice",oWP);	
	
	
	MusicBackgroundStop(oArea);	
	MusicBattlePlay(oArea);
	GroupActionForceExit("commoners","wp_arena_exit",1);
	GroupActionForceExit("nobles","wp_arena_exit",1);
	
	AssignCommand(oVoice,SetFacing(0.0,TRUE));
	PlayCustomAnimation(oVoice,"Point",0);
	DelayCommand(5.0,AssignCommand(oVoice,SpeakString("*Booming Voice* <i>Hear me, traitors! The time of the false Emperors has ended.  Prepare for the return of your true MASTER!</i>",TALKVOLUME_SHOUT))); 
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePortal2,GetNearestObjectByTag("IP_PORTAL1"));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePortal1,GetNearestObjectByTag("IP_PORTAL1"));
  	ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePortal2,GetNearestObjectByTag("IP_PORTAL2"));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePortal1,GetNearestObjectByTag("IP_PORTAL2"));	
	
	SendMessageToAllDMs("THE ATTACK HAS STARTED");
	
	DelayCommand(6.0,AssignCommand(oGov,SpeakString("Trechery! The enemies of the Empire Strike!",TALKVOLUME_SHOUT)));
	DelayCommand(7.0,AssignCommand(oGov,SpeakString("Hail Marcus, True Emperor of Vara... <i>*Falls Dead*</i>",TALKVOLUME_SHOUT)));
	
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	effect eDeath = EffectDeath(TRUE);
	AssignCommand(oVoice,ActionCastSpellAtObject(SPELL_POWER_WORD_KILL,oGov));	

	DelayCommand(7.0,AssignCommand(oVoice,SpeakString("<i>*In the tongue of Old Varana*</i> In Eternus Muneris ut Eternus Rex rgis, Ex Abyssus Pectus pectoris EGO pungo procul vos!",TALKVOLUME_SHOUT)));
		
	DelayCommand(8.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oGov));
	DelayCommand(8.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oGov));
		
	DelayCommand(9.0,SetPlotFlag(oVoice,FALSE));
	DelayCommand(9.0,ChangeToStandardFaction(oVoice,STANDARD_FACTION_HOSTILE));
	DelayCommand(10.0,AssignCommand(oVoice,ActionAttack(GetNearestPC()))); 
	
	DelayCommand(10.0,AttackWave(lPortal1,lPortal2));
	DelayCommand(30.0,GroupSpawnAtWaypoint("kor","kor_skirmisher","WP_arena_zenia_04",3));
	
	// if they're not dead by now, get rid of 'em
	DelayCommand(75.0,DestroyObjectsInGroup("commoners"));;
	DelayCommand(75.0,DestroyObjectsInGroup("nobles"));

	DelayCommand(85.0,GroupSpawnAtWaypoint("kor","kor_skirmisher","wp_arena_floor",3));	
	DelayCommand(90.0,AttackWave(lPortal1,lPortal2));

	
	DelayCommand(95.0,DestroyObject(GetNearestObjectByTag("IP_PORTAL1")));
	DelayCommand(95.0,DestroyObject(GetNearestObjectByTag("IP_PORTAL2")));
}

void main()
{
	SendMessageToAllDMs("THE SPEECH HAS STARTED");
	object oSpeaker = GetNearestObjectByTag("event_nex_nathan_verkethed");
	object oArea = GetArea(oSpeaker);
	MusicBackgroundStop(oArea);
	MusicBackgroundChangeDay(oArea,TRACK_HOTU_DRACOLICH);
	MusicBackgroundChangeNight(oArea,TRACK_HOTU_DRACOLICH);
	MusicBackgroundPlay(oArea);	

	AssignCommand(oSpeaker,SpeakString("<i>*An expectant hush falls over the crowd as the Governor Verkethed begins to deliver his speech in Cear Arena.*</i>", TALKVOLUME_SHOUT));
	AssignCommand(oSpeaker,DelayCommand(15.0,SpeakString("Citizens of Cear, hear me!", TALKVOLUME_SHOUT)));
	DelayCommand(15.0,GroupPlayAnimation("nobles",ANIMATION_FIREFORGET_SALUTE));
	
	AssignCommand(oSpeaker,DelayCommand(30.0,SpeakString("Fifty one years ago, on this day, the Imperial Province of Dasaria made it's joyous entry into the Empire.", TALKVOLUME_SHOUT)));
	DelayCommand(31.0,GroupPlayAnimation("nobles",ANIMATION_FIREFORGET_VICTORY1));
	
	AssignCommand(oSpeaker,DelayCommand(40.0,SpeakString("Thanks to the martial prowess and galantry of our Imperial Legions, the efforts of the Magnus Order, and um... Navy, these lands embraced our glorious Empire relatively peacefully.",TALKVOLUME_SHOUT)));
	
	AssignCommand(oSpeaker,DelayCommand(50.0,SpeakString("And so today we celebrate the union of Marcus, True Emperor of Varana, and Nelina, his worthy consort, whose union has brought lasting peace to these lands. <i>*Pauses for Applause*</i>", TALKVOLUME_SHOUT)));
	DelayCommand(51.0,GroupPlayAnimation("nobles",ANIMATION_FIREFORGET_VICTORY3));
	
	AssignCommand(oSpeaker,DelayCommand(60.0,SpeakString("Other, less enlightened and more arrogant nations, such as that of the Shai, were crushed beneath the iron boot of the Legions' full fury.", TALKVOLUME_SHOUT)));
		
	AssignCommand(oSpeaker,DelayCommand(70.0,SpeakString("Today we also celebrate the our own bright City of Cear, which was joined to the Empire fify years ago in relative peace, but for the loss of that once-blasphemous library of lies that once blighted our shoreline and rightly lies in ruins today.", TALKVOLUME_SHOUT)));
	DelayCommand(71.0,GroupPlayAnimation("nobles",ANIMATION_FIREFORGET_VICTORY2));
	
	AssignCommand(oSpeaker,DelayCommand(80.0,SpeakString("So once again, it is the glorious holiday of <i>Nex Ut Proditor</i> and we celerate...",TALKVOLUME_SHOUT)));	
	DelayCommand(85.0,VoiceOfTheMaster());
}