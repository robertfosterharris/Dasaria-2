//makeshift jukebox for lendose bard, by atharin
//nRow = ambientmusic.2da row #
void main(int nRow, int nSpeak, string sSay)
{
object oArea = GetArea(OBJECT_SELF);
int nHour = GetTimeHour();

if ((nHour >= 6) ||//day
(nHour < 18))
{ MusicBackgroundChangeDay(oArea, nRow); }

if ((nHour >= 18) ||
(nHour < 6))
{ MusicBackgroundChangeNight(oArea, nRow); }

MusicBackgroundStop(oArea);
DelayCommand(0.1,MusicBackgroundPlay(oArea));

if (nSpeak > 0)
	{ 
	AssignCommand(OBJECT_SELF,ActionSpeakString(sSay));
 	PlayCustomAnimation(OBJECT_SELF,"playguitar",0);
	}
}