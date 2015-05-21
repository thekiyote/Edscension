script "postadventure.ash";

import <floristfriar.ash>
import <zlib.ash>
import <cc_util.ash>

void handlePostAdventure()
{
	if(get_property("cc_disableAdventureHandling") == "yes")
	{
		return;
	}

	oldPeoplePlantStuff();
	
	#Should we create a separate function to track these? How many are we going to track?
	if(last_monster() == $monster[writing desk])
	{
		print("Fought " + get_property("writingDesksDefeated") + " writing desks.", "blue");
	}
	if((last_monster() == $monster[Gaudy Pirate]))
	{
		set_property("cc_gaudypiratecount", "" + (get_property("cc_gaudypiratecount").to_int() + 1));
		print("Fought " + get_property("cc_gaudypiratecount") + " gaudy pirates.", "blue");
	}
	if((last_monster() == $monster[Drab Bard]) || (last_monster() == $monster[Racecar Bob]) || (last_monster() == $monster[Bob Racecar]))
	{
		set_property("cc_palindomeDudesDefeated", "" + (get_property("cc_palindomeDudesDefeated").to_int() + 1));
		print("Fought " + get_property("cc_palindomeDudesDefeated") + " dudes.", "blue");
	}

	print("Post Adventure done, boop.", "purple");
}

void main(){
	handlePostAdventure();
}