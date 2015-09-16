script "preadventure.ash";
import <zlib.ash>
import <ed_util.ash>

void highLogging()
{
	wait(1);
	print("Turn(" + my_turncount() + "): Starting with " + my_adventures() + " left and at Level: " + my_level(), "cyan");
	
	if((item_amount($item[rock band flyers]) == 1) && (get_property("flyeredML").to_int() < 10000))
	{
		print("Still flyering: " + get_property("flyeredML"), "blue");
	}
	
	print("Encounter: " + combat_rate_modifier() + "   Exp Bonus: " + experience_bonus(), "blue");
	print("Meat: " + meat_drop_modifier() + "   Item: " + item_drop_modifier(), "blue");
	print("ML: " + monster_level_adjustment() + " control: " + current_mcd(), "blue");
	
	if(have_effect($effect[Everything looks yellow]) > 0)
	{
		print("Everything Looks Yellow: " + have_effect($effect[everything looks yellow]), "blue");
	}
	
	print("HP: " + my_hp() + "/" + my_maxhp() + "\tMP: " + my_mp() + "/" + my_maxmp(), "violet");
	print("Ka Coins: " + item_amount($item[Ka Coin]), "green");

	if(have_skill($skill[Lash of the Cobra]))
	{
		print("Lashes used: " + get_property("_edLashCount"));
	}
}

void handlePreAdventure()
{
	if(get_property("ed_disableAdventureHandling") == "yes")
	{
		return;
	}
	
	if(get_property("ed_highlogging") == "true")
	{
		highLogging();
	}

//Handle poisons commonly found (that last more than one turn) during an Ed run
	if((have_effect($effect[Really Quite Poisoned]) > 0) || (have_effect($effect[A Little Bit Poisoned]) > 0) || (have_effect($effect[Majorly Poisoned]) > 0))
	{
		buy(1, $item[anti-anti-antidote]);
		use(1, $item[anti-anti-antidote]);
	}

//Handle some additional cheap buffs, kinda worthless at low levels due to the nature of % scaling
	if(monster_level_adjustment() > 70 && my_level() > 6)
	{
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}

//MP and Buff handling
	int buffcounter = 0;
	boolean dobreak = false;
	while(!doBreak)
	{
		// Restore MP
		if(item_amount($item[Magical Mystery Juice]) > 0 && (my_mp() < 20))
		{
			use(1, $item[Magical Mystery Juice]);
		}
		else if(item_amount($item[Phonics Down]) > 0 && (my_mp() < 20))
		{
			use(1, $item[Phonics Down]);
		}
		else if(item_amount($item[Tiny House]) > 0 && (my_mp() < 20))
		{
			use(1, $item[Tiny House]);
		}
		else if(item_amount($item[Grogpagne]) > 0 && (my_mp() < 20) && (my_maxmp() > 55))
		{
			use(1, $item[Grogpagne]);
		}
		else if(item_amount($item[Bottle of Monsieur Bubble]) > 0 && (my_mp() < 20))
		{
			use(1, $item[Bottle of Monsieur Bubble]);
		}
		else if(item_amount($item[Sacramental Wine]) > 0 && (my_mp() < 20) && (my_maxmp() > 174))
		{
			use(1, $item[Sacramental Wine]);
		}
		else if(item_amount($item[Spirit Beer]) > 0 && (my_mp() < 20) && (my_maxmp() > 89))
		{
			use(1, $item[Spirit Beer]);
		}
		else if(item_amount($item[Holy Spring Water]) > 0 && (my_mp() < 20))
		{
			//TODO:  if we have meat, but not organs, favor the Doc's Tonic.
			use(1, $item[Holy Spring Water]);
		}
		else if((my_mp() < 20) && my_meat() > 180 && my_mp() + 11 <= my_maxmp())
		{
			buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
		}


//Handle buffs
		if(my_level() < 13)
		{
			buffMaintain($effect[Prayer of Seshat], 5, 1, 10);
		}
		buffMaintain($effect[Wisdom of Thoth], 5, 1, 5);
		if (4 < my_level() && 1000 < my_meat())
		{
			buffMaintain($effect[Power of Heka], 10, 1, 5);
		}
		if(my_location() == $location[Guano Junction])
		{
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		}
		if(monster_level_adjustment() > 50)
		{
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		}
		if(my_location() != $location[The Secret Government Laboratory] && my_level() > 5)
		{
			buffMaintain($effect[Bounty of Renenutet], 20, 1, 5);
		}
		if (
			600 < my_meat()
		) {
			if((my_servant() == $servant[Priest]) && ($servant[Priest].experience < 196) && ($servant[Priest].experience > 80))
			{
				buffMaintain($effect[Purr of the Feline], 10, 1, 1);
			}
			if(my_servant() == $servant[Cat])
			{
				buffMaintain($effect[Purr of the Feline], 10, 1, 1);
			}
			if(my_servant() == $servant[Scribe])
			{
				buffMaintain($effect[Purr of the Feline], 10, 1, 1);
			}
			if((my_servant() == $servant[Belly-Dancer]) && ($servant[Belly-Dancer].experience < 196) && ($servant[Belly-Dancer].experience > 80))
			{
				buffMaintain($effect[Purr of the Feline], 10, 1, 1);
			}
		}
		if (
			!($locations[
				The Sleazy Back Alley,
				Hippy Camp,
				Lair of the Ninja Snowmen,
				The SMOOCH Army HQ
			] contains my_location())
			&& 400 < my_meat()
		) {
			buffMaintain($effect[Blessing of Serqet], 15, 1, 1);
			//TODO:  when starting out, we don't want the blessing if jump_chance() is low.
			// also. it costs a lot.  trying out some new logic for that.
		}
		while((my_mp() > 120) && (have_effect($effect[wisdom of thoth]) < 50))
		{
			int start = my_mp();
			buffMaintain($effect[Prayer of Seshat], 5, 1, 300);
			buffMaintain($effect[Wisdom of Thoth], 5, 1, 300);
			buffMaintain($effect[Power of Heka], 10, 1, 300);
			buffMaintain($effect[Hide of Sobek], 10, 1, 300);
			buffMaintain($effect[Bounty of Renenutet], 20, 1, 300);
			if(start == my_mp())
			{
				break;
			}
		}
		

//Handle -combat
		if((my_location() == $location[The Penultimate Fantasy Airship] && ("The Penultimate Fantasy Airship".to_location().turns_spent >= 10)) ||
			(my_location() == $location[Twin Peak]) ||
			(my_location() == $location[The Poop Deck]) ||
			(my_location() == $location[The Obligatory Pirate\'s Cove]) ||
			(my_location() == $location[The Haunted Ballroom]) ||
			(my_location() == $location[The Haunted Billiards Room]) ||
			(my_location() == $location[The Haunted Gallery]) ||
			(my_location() == $location[The Haunted Bathroom]) ||
			(my_location() == $location[Inside the Palindome]) ||
			(my_location() == $location[The Dark Neck of the Woods]) ||
			(my_location() == $location[The Dark Heart of the Woods]) ||
			(my_location() == $location[The Dark Elbow of the Woods]) ||
			(my_location() == $location[The Defiled Cranny]
				&& get_property("cyrptCrannyEvilness").to_int() > 26
			) ||
			(my_location() == $location[The Defiled Alcove]) ||
			(my_location() == $location[The Spooky Forest] && ("The Spooky Forest".to_location().turns_spent >= 5)) ||
			(my_location() == $location[Inside the Palindome]) ||
			(my_location() == $location[Barrrney\'s Barrr] && item_amount($item[Cap\'m Caronch\'s Map]) == 0 && item_amount($item[Cap\'m Caronch\'s Nasty Booty]) == 0 && (get_property("ed_pirateoutfit") == "insults")) ||
			(my_location() == $location[Wartime Hippy Camp]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Basement)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Top Floor)]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)]) ||
			(my_location() == $location[The Hidden Park]))
		{
			if((have_effect($effect[Taunt of Horus]) > 0))
			{
				if(!uneffect($effect[Taunt of Horus]))
				{
					abort("We can't seem to loose our tail, check if Taunt of Horus has been removed or not.");
				}
			}
				
			buffMaintain($effect[Shelter of Shed], 15, 1, 0);
		}

//Handle +combat
		if((my_location() == $location[Lair of the Ninja Snowmen] && ("Lair of the Ninja Snowmen".to_location().turns_spent >= 1)) ||
			(my_location() == $location[Sonofa Beach]) ||
			(my_location() == $location[The F'c'le]))
		{
			if((have_effect($effect[Shelter of Shed]) > 0))
			{
				if(!uneffect($effect[Shelter of Shed]))
				{
					abort("We can't seem to find our tail, check if Shelter of Shed has been removed or not.");
				}
			}

			buffMaintain($effect[Taunt of Horus], 0, 1, 1);
			if (item_amount($item[Reodorant]) > 2)
			{
				buffMaintain($effect[Hippy Stench], 0, 1, 1);
			} else if(my_location() == $location[Sonofa Beach])
			{
				buffMaintain($effect[Hippy Stench], 0, 1, 1);
			}
		}
		
//Escape clauses, counting MP for YRs and lashes and standard combat and bosses
		buffcounter += 1;
		if(buffcounter > 29)
		{
			abort("We couldn't restore your MP properly, try autoselling some junk!");
		}
		if(((my_location() == $location[Wartime Hippy Camp (Frat Disguise)]) && (get_property("hippiesDefeated") == 1000)) ||
			(my_location() == $location[The Naughty Sorceress\' Chamber]))
		{
			if((my_mp() < 80) && my_meat() > 180)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			if(my_mp() >= 80)
			{
				doBreak = true;
			}
		} else if(((my_location() == $location[Hippy Camp]) && !get_property("ed_legsbeforebread").to_boolean() && 200 < my_meat()) ||
			(my_location() == $location[The Penultimate Fantasy Airship]  && ((item_amount($item[mohawk wig]) == 0))) ||
			(my_location() == $location[Cobb\'s Knob Harem] && !have_outfit("Knob Goblin Harem Girl Disguise")) ||
			(my_location() == $location[Wartime Frat House (Hippy Disguise)]) && !have_outfit("Frat Warrior Fatigues") &&
			have_skill($skill[Wrath of Ra]) && (have_effect($effect[Everything Looks Yellow]) == 0))
		{
			if((my_mp() < 40) && my_meat() > 180)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			if(my_mp() >= 40)
			{
				doBreak = true;
			}
		} else if (
			$locations[
				The Hidden Bowling Alley,
				The Hidden Hospital,
				The Secret Council Warehouse
			] contains my_location()
		) {
			if ((my_mp() < 36) && my_meat() > 180)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			if (my_mp() > 35)
			{
				doBreak = true;
			}
		} else if((my_location() == $location[The Obligatory Pirate\'s Cove]) ||
			(my_location() == $location[Twin Peak]) ||
			(my_location() == $location[Pirates of the Garbage Barges]) ||
			(my_location() == $location[Barf Mountain]) ||
			(my_location() == $location[The Degrassi Knoll Gym]) ||
			(my_location() == $location[The Goatlet]) ||
			(my_location() == $location[The Castle in the Clouds in the Sky (Ground Floor)]) ||
			(my_location() == $location[The Penultimate Fantasy Airship]) ||
			(my_location() == $location[The Beanbat Chamber]) ||
			(my_location() == $location[The Haunted Library]) ||
			(my_location() == $location[The Defiled Nook]) ||
			(my_location() == $location[Oil Peak]) ||
			(my_location() == $location[The Black Forest]) ||
			(my_location() == $location[The Hidden Apartment Building]) ||
			(my_location() == $location[The Hidden Office Building]) ||
			(my_location() == $location[The Hatching Chamber]) ||
			(my_location() == $location[The Feeding Chamber]) ||
			(my_location() == $location[The Royal Guard Chamber]) ||
			(my_location() == $location[Cobb\'s Knob Harem]) ||
			((my_location() == $location[Wartime Frat House (Hippy Disguise)]) && !have_outfit("Frat Warrior Fatigues")) ||
			((my_location() == $location[The Dark Heart of the Woods]) && (item_amount($item[hot wing]) < 3)) ||
			((my_location() == $location[The Dark Neck of the Woods]) && (item_amount($item[hot wing]) < 3)) ||
			((my_location() == $location[The Dark Elbow of the Woods]) && (item_amount($item[hot wing]) < 3)))
		{
			if((my_mp() < 23) && my_meat() > 180)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			if(my_mp() >= 23)
			{
				doBreak = true;
			}
		} else if (my_maxmp() < 30 && my_mp() > 2 * mp_cost($skill[fist of the mummy])) {
			doBreak = true;
		} else if ($location[The Sleazy Back Alley] == my_location() && my_mp() > 2 * mp_cost($skill[fist of the mummy])) {
			doBreak = true;
		} else if ($location[Hippy Camp] == my_location() && 3 * mp_cost($skill[fist of the mummy]) < my_mp()) {
			break;
		} else if ($location[The SMOOCH Army HQ] == my_location() && $location[The SMOOCH Army HQ].turns_spent < 50 && mp_cost($skill[storm of the scarab]) <= my_mp()) {
			break;
		} else if (my_mp() < 15 && 180 < my_meat()) {
			buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
		} else if(my_mp() > 14)
		{
			doBreak = true;
		}
	}
		
	print("Pre Adventure done, beep.", "orange");
	return;
}

void ed_preadventure()
{
	handlePreAdventure();
}
