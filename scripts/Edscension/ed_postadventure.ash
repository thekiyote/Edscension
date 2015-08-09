script "postadventure.ash";

//import <ed_florist.ash>
import <zlib.ash>
import <ed_util.ash>

void handlePostAdventure()
{
	if(get_property("ed_disableAdventureHandling") == "yes")
	{
		return;
	}

//FIX ME	oldPeoplePlantStuff();

	if(last_monster() == $monster[writing desk])
	{
		print("Fought " + get_property("writingDesksDefeated") + " writing desks.", "blue");
	}
	if(last_monster() == $monster[ninja snowman assassin])
	{
		set_property("ed_ninjasnowmanassassin", (get_property("ed_ninjasnowmanassassin").to_int() + 1));
		print("Fought " + get_property("ed_ninjasnowmanassassin") + " ninja snowman assassins.", "blue");
	}
	if((last_monster() == $monster[Gaudy Pirate]))
	{
		set_property("ed_gaudypiratecount", (get_property("ed_gaudypiratecount").to_int() + 1));
		print("Fought " + get_property("ed_gaudypiratecount") + " gaudy pirates.", "blue");
	}
	if((last_monster() == $monster[Drab Bard]) || (last_monster() == $monster[Racecar Bob]) || (last_monster() == $monster[Bob Racecar]))
	{
		set_property("ed_palindomeDudesDefeated", (get_property("ed_palindomeDudesDefeated").to_int() + 1));
		print("Fought " + get_property("ed_palindomeDudesDefeated") + " dudes.", "blue");
	}

	print("Post Adventure done, boop.", "purple");
}

void main(){
	handlePostAdventure();
}