script "ed_combat.ash"
import <ed_util.ash>
import <ed_equipment.ash>
import <ed_edTheUndying.ash>

void handleBanish(monster enemy, skill banisher);
void handleBanish(monster enemy, item banisher);
void handleYellowRay(monster enemy, skill yellowRay);
void handleLashes(monster enemy);
void handleRenenutet(monster enemy);

string whm_stormOrFist() {
	if (!have_skill($skill[storm of the scarab])) return "fist of the mummy";
	return "storm of the scarab";
}
string whm_stormOrFist(monster enemy) {
	if (enemy.raw_hp < 85) return "fist of the mummy";
	return whm_stormOrFist();
}

void handleBanish(monster enemy, skill banisher)
{
	string banishes = get_property("ed_banishes");
	if(banishes != "")
	{
		banishes = banishes + ", ";
	}
	banishes = banishes + "(" + my_daycount() + ":" + enemy + ":" + banisher + ":" + my_turncount() + ")";
	set_property("ed_banishes", banishes);
}

void handleBanish(monster enemy, item banisher)
{
	string banishes = get_property("ed_banishes");
	if(banishes != "")
	{
		banishes = banishes + ", ";
	}
	banishes = banishes + "(" + my_daycount() + ":" + enemy + ":" + banisher + ":" + my_turncount() + ")";
	set_property("ed_banishes", banishes);
}

void handleYellowRay(monster enemy, skill yellowRay)
{
	string yellow = get_property("ed_yellowRays");
	if(yellow != "")
	{
		yellow = yellow + ", ";
	}
	yellow = yellow + "(" + my_daycount() + ":" + enemy + ":" + yellowRay + ":" + my_turncount() + ")";
	set_property("ed_yellowRays", yellow);
}

string findBanisher(string opp)
{
	print("In findBanisher for: " + opp, "green");
	monster enemy = to_monster(opp);

	if(have_skill($skill[Curse of Vacation]) && my_mp() >= 35)
	{
		handleBanish(enemy, $skill[Curse of Vacation]);
		return "skill curse of vacation";
	}

	return "attack with weapon";
}

string ccsJunkyard(int round, string opp, string text)
{
	if(round == 0)
	{
		print("ccsJunkyard: " + round, "brown");
		set_property("ed_gremlinMoly", true);
		set_property("ed_combatJunkyard", "clear");
		set_property("ed_combatHandler", "");
	}
	else
	{
		print("ed_Junkyard: " + round, "brown");
	}
	string combatState = get_property("ed_combatHandler");
	string edCombatState = get_property("ed_edCombatHandler");

	if(contains_text(edCombatState, "gremlinNeedBanish"))
	{
		set_property("ed_gremlinMoly", false);
	}

	if(my_location() == $location[Next To That Barrel With Something Burning In It])
	{
		if(opp == "vegetable gremlin")
		{
			set_property("ed_gremlinMoly", false);
		}
		else if(contains_text(text, "It does a bombing run over your head"))
		{
			set_property("ed_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Out By That Rusted-Out Car])
	{
		if(opp == "erudite gremlin")
		{
			set_property("ed_gremlinMoly", false);
		}
		else if(contains_text(text, "It picks a beet off of itself and beats you with it"))
		{
			set_property("ed_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Over Where The Old Tires Are])
	{
		if(opp == "spider gremlin")
		{
			set_property("ed_gremlinMoly", false);
		}
		else if(contains_text(text, "He uses the random junk around him"))
		{
			set_property("ed_gremlinMoly", false);
		}
	}
	else if(my_location() == $location[Near an Abandoned Refrigerator])
	{
		if(opp == "batwinged gremlin")
		{
			set_property("ed_gremlinMoly", false);
		}
		else if(contains_text(text, "It bites you in the fibula with its mandibles"))
		{
			set_property("ed_gremlinMoly", false);
		}
	}

	if(!contains_text(edCombatState, "gremlinNeedBanish") && !get_property("ed_gremlinMoly").to_boolean())
	{
		set_property("ed_edCombatHandler", "(gremlinNeedBanish)");
	}

	if(contains_text(text, "It whips out a hammer") || contains_text(text, "He whips out a crescent") || contains_text(text, "It whips out a pair") || contains_text(text, "It whips out a screwdriver"))
	{
		return "item molybdenum magnet";
	}
	if((!contains_text(combatState, "marshmallow")) && have_skill($skill[Curse of the Marshmallow]) && (my_mp() > 10))
	{
		set_property("ed_combatHandler", combatState + "(marshmallow)");
		return "skill Curse of the Marshmallow";
	}
	if((!contains_text(combatState, "heredity")) && have_skill($skill[Curse of Heredity]) && (my_mp() > 15))
	{
		set_property("ed_combatHandler", combatState + "(heredity)");
		return "skill Curse of the Heredity";
	}
	if((!contains_text(combatState, "love scarab")) && have_skill($skill[Summon Love Scarabs]))
	{
		set_property("ed_combatHandler", combatState + "(love scarab1)");
		return "skill summon love scarabs";
	}
	if((!contains_text(combatState, "love scarab")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("ed_combatHandler", combatState + "(love scarab2)");
		return "skill summon love scarabs";
	}
	if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
	{
		set_property("ed_combatHandler", combatState + "(love gnats1)");
		return "skill summon love gnats";
	}
	if((!contains_text(combatState, "love gnats")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("ed_combatHandler", combatState + "(love gnats2)");
		return "skill summon love gnats";
	}

	if(!get_property("ed_gremlinMoly").to_boolean())
	{
		if(get_property("ed_edCombatStage").to_int() > 2)
		{
			string banisher = findBanisher(opp);
			if(banisher != "attack with weapon")
			{
				return banisher;
			}
			else if(my_mp() >= 8)
			{
				return "skill " + whm_stormOrFist();
			}
			return banisher;
		}
	}

	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]) && (get_property("ed_edCombatStage").to_int() < 3))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("ed_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}
	if(get_property("ed_edCombatStage").to_int() > 2 && (my_location() != $location[The Battlefield (Frat Uniform)]) && (!contains_text(combatState, "flyers")) && ((expected_damage() * 1.1) <= my_hp()))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("ed_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}

	if(!get_property("ed_gremlinMoly").to_boolean())
	{
		if(get_property("ed_edCombatStage").to_int() >= 2)
		{
			return findBanisher(opp);
		}
		else if(item_amount($item[dictionary]) > 0)
		{
			return "item dictionary";
		}
	}


	if(!get_property("ed_gremlinMoly").to_boolean())
	{
		if(have_skill($skill[Storm of the Scarab]) && (my_mp() >= 8))
		{
			return "skill Storm of the Scarab";
		}
		return "attack with weapon";
	}

	if(item_amount($item[dictionary]) > 0)
	{
		return "item dictionary";
	}
	return "mild curse";
}

void handleSniffs(monster enemy, skill sniffer)
{
	if(my_daycount() <= 5)
	{
		string sniffs = get_property("ed_sniffs");
		if(sniffs != "")
		{
			sniffs = sniffs + ",";
		}
		sniffs = sniffs + "(" + my_daycount() + ":" + enemy + ":" + sniffer + ":" + my_turncount() + ")";
		set_property("ed_sniffs", sniffs);
	}
}

void handleLashes(monster enemy)
{
	if(my_daycount() <= 5)
	{
		string lashes = get_property("ed_lashes");
		if(lashes != "")
		{
			lashes = lashes + ", ";
		}
		if(get_property("_edLashCount").to_int() >= 30)
		{
			lashes = lashes + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + "F)";
		}
		else
		{
			lashes = lashes + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + ")";
		}
		set_property("ed_lashes", lashes);
	}
}

void handleRenenutet(monster enemy)
{
	if(my_daycount() <= 5)
	{
		string renenutet = get_property("ed_renenutet");
		if(renenutet != "")
		{
			renenutet = renenutet + ", ";
		}
		renenutet = renenutet + "(" + my_daycount() + ":" + enemy + ":" + my_turncount() + ")";
		set_property("ed_renenutet", renenutet);
	}
}

string ed_edCombatHandler(int round, string opp, string text)
{
	if(round == 0)
	{
		print("ed_combatHandler: " + round, "brown");
		set_property("ed_combatHandler", "");
		if(get_property("ed_edCombatStage").to_int() < 3 && (item_amount($item[rock band flyers]) == 1))
		{
			set_property("ed_edCombatCount", 1 + get_property("ed_edCombatCount").to_int());
			set_property("ed_edStatus", "UNDYING!");
			print("test1", "red");
		}
		else if(get_property("ed_edCombatStage").to_int() < 3)
		{
			set_property("ed_edCombatCount", 1 + get_property("ed_edCombatCount").to_int());
			set_property("ed_edStatus", "dying");
			print("test4", "red");
		}
	}

	set_property("ed_diag_round", round);

	if(get_property("ed_diag_round").to_int() > 60)
	{
		abort("Somehow got to 60 rounds.... aborting");
	}

	monster enemy = to_monster(opp);
	phylum type = monster_phylum(enemy);
	string combatState = get_property("ed_combatHandler");
	string edCombatState = get_property("ed_edCombatHandler");
	
	if((item_amount($item[ka coin]) > 30) && (!have_skill($skill[Healing Scarabs]) || (my_spleen_use() < spleen_limit())) && (get_property("_edDefeats").to_int() == 0) &&
	(!contains_text(edCombatState, "talismanofrenenutet") || contains_text(edCombatState, "insults") || !contains_text(edCombatState, "curse of fortune")))
	{
		set_property("ed_edStatus", "UNDYING!");
		print("test5", "red");
	}
	
	if((enemy == $monster[Pygmy Shaman] && have_effect($effect[Thrice-Cursed]) == 0) ||
		(enemy == $monster[batwinged gremlin] && item_amount($item[molybdenum hammer]) == 0) ||
		(enemy == $monster[vegetable gremlin] && item_amount($item[molybdenum screwdriver]) == 0) ||
		(enemy == $monster[spider gremlin] && item_amount($item[molybdenum pliers]) == 0) ||
		(enemy == $monster[erudite gremlin] && item_amount($item[molybdenum crescent wrench]) == 0) ||
		(enemy == $monster[tetchy pirate] && (get_property("lastPirateInsult1") == false || get_property("lastPirateInsult2") == false || get_property("lastPirateInsult3") == false || get_property("lastPirateInsult4") == false || get_property("lastPirateInsult5") == false || get_property("lastPirateInsult6") == false || get_property("lastPirateInsult7") == false || get_property("lastPirateInsult8") == false)) ||
		(enemy == $monster[toothy pirate] && (get_property("lastPirateInsult1") == false || get_property("lastPirateInsult2") == false || get_property("lastPirateInsult3") == false || get_property("lastPirateInsult4") == false || get_property("lastPirateInsult5") == false || get_property("lastPirateInsult6") == false || get_property("lastPirateInsult7") == false || get_property("lastPirateInsult8") == false)) ||
		(enemy == $monster[tipsy pirate] && (get_property("lastPirateInsult1") == false || get_property("lastPirateInsult2") == false || get_property("lastPirateInsult3") == false || get_property("lastPirateInsult4") == false || get_property("lastPirateInsult5") == false || get_property("lastPirateInsult6") == false || get_property("lastPirateInsult7") == false || get_property("lastPirateInsult8") == false)))
	{
		set_property("ed_edStatus", "UNDYING!");
		print("test6", "red");
	}
	
	if((get_property("ed_edCombatStage").to_int() >= 2) && ((item_amount($item[rock band flyers]) == 0) || (get_property("flyeredML") >= 10000)))
	{
		set_property("ed_edStatus", "dying");
		print("test2", "red");
	}
	if((get_property("ed_edCombatStage").to_int() < 4) && (item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000) && (item_amount($item[ka coin]) > 2))
	{
		set_property("ed_edStatus", "UNDYING!");
		print("test3", "red");
	}
	
	#Handle different path is monster_level_adjustment() > 150 (immune to staggers?)
	int mcd = monster_level_adjustment();

	if(have_effect($effect[temporary amnesia]) > 0)
	{
		return "attack with weapon";
	}

	if((!contains_text(combatState, "love scarab")) && have_skill($skill[Summon Love Scarabs]))
	{
		set_property("ed_combatHandler", combatState + "(love scarab1)");
		return "skill summon love scarabs";
	}

	if((!contains_text(combatState, "love scarab")) && get_property("lovebugsUnlocked").to_boolean())
	{
		set_property("ed_combatHandler", combatState + "(love scarab2)");
		return "skill summon love scarabs";
	}

	if(get_property("ed_edStatus") == "UNDYING!")
	{
		if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
		{
			set_property("ed_combatHandler", combatState + "(love gnats)");
			return "skill summon love gnats";
		}
		if(((!contains_text(combatState, "love gnats") || (contains_text(combatState, "stun resisted"))) || (contains_text(combatState, "gnats disperse"))) && have_skill($skill[Curse of Indecision]) && my_mp() > 25)
		{
			set_property("ed_combatHandler", combatState + "(love gnats3)");
			return "skill Curse of Indecision";
		}
	}
	else if(get_property("ed_edStatus") == "dying")
	{
		boolean doStunner = true;

		if((mcd > 125) || ((expected_damage() * 1.15) < my_hp()))
		{
			doStunner = false;
		}

		if(doStunner)
		{
			if((!contains_text(combatState, "love gnats")) && have_skill($skill[Summon Love Gnats]))
			{
				set_property("ed_combatHandler", combatState + "(love gnats)");
				return "skill summon love gnats";
			}
			if(((!contains_text(combatState, "love gnats") || (contains_text(combatState, "stun resisted"))) || (contains_text(combatState, "gnats disperse"))) && have_skill($skill[Curse of Indecision]) && my_mp() > 25)
			{
				set_property("ed_combatHandler", combatState + "(love gnats3)");
				return "skill Curse of Indecision";
			}
		}
	}
	else
	{
		print("Ed combat state does not exist, winging it....", "red");
	}

	if((!contains_text(combatState, "sewage pistol")) && have_skill($skill[Fire Sewage Pistol]))
	{
		set_property("ed_combatHandler", combatState + "(sewage pistol)");
		return "skill fire sewage pistol";
	}

	if((!contains_text(combatState, "flyers")))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("ed_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}

	if((enemy == $monster[clingy pirate (female)] || enemy == $monster[clingy pirate (male)]) && (item_amount($item[cocktail napkin]) > 0))
	{
		return "item cocktail napkin";
	}

	if((enemy == $monster[dirty thieving brigand]) && (!contains_text(edCombatState, "curse of fortune")))
	{
		if((item_amount($item[Ka Coin]) > 0) && (have_skill($skill[Curse of Fortune])))
		{
			set_property("ed_edCombatHandler", edCombatState + "(curse of fortune)");
			set_property("ed_edStatus", "dying");
			return "skill curse of fortune";
		}
	}
	
	if(contains_text(edCombatState, "curse of fortune"))
	{
		set_property("ed_edStatus", "dying");
	}

	if((item_amount($item[The Big Book of Pirate Insults]) > 0) && (!contains_text(combatState, "insults")) && (my_location() == $location[barrrney\'s barrr]))
	{
		if(((expected_damage() * 1.1) > my_hp()) && (get_property("ed_edStatus") == "dying"))
		{
			if((monster_level_adjustment() < 51) && !contains_text(combatState, "love gnats3") && have_skill($skill[curse of indecision]))
			{
				set_property("ed_combatHandler", combatState + "(love gnats3)");
				return "skill Curse of Indecision";
			}
			if(contains_text(combatState, "love gnats3"))
			{
				set_property("ed_combatHandler", combatState + "(insults)");
				return "item the big book of pirate insults";
			}
			else
			{
				return whm_stormOrFist();
			}
		}

		set_property("ed_combatHandler", combatState + "(insults)");
		return "item the big book of pirate insults";
	}

	if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("ed_edStatus") == "UNDYING!"))
	{
		if((enemy == $monster[bob racecar]) ||
			(enemy == $monster[pygmy bowler]) ||
			(enemy == $monster[pygmy witch surgeon]) ||
			(enemy == $monster[possessed wine rack]) ||
			(enemy == $monster[cabinet of Dr. Limpieza]) ||
			(enemy == $monster[quiet healer] && item_amount($item[amulet of extreme plot significance]) == 0) ||
			(enemy == $monster[burly sidekick] && item_amount($item[amulet of extreme plot significance]) > 0) ||
			(enemy == $monster[guy with a pitchfork, and his wife]) ||
			(enemy == $monster[claw-foot bathtub]) ||
			(enemy == $monster[racecar bob]) ||
			(enemy == $monster[dirty old lihc]) ||
			(enemy == $monster[dairy goat]) ||
			(enemy == $monster[green ops soldier]) ||
			(enemy == $monster[Government Scientist]) ||
			(enemy == $monster[wolfman]) ||
			(enemy == $monster[monstrous boiler] && monster_level_adjustment() < 81) ||
			(enemy == $monster[bearpig topiary animal] && !contains_text(get_property("stenchCursedMonster"), "topiary")) ||
			(enemy == $monster[elephant (meatcar?) topiary animal] && !contains_text(get_property("stenchCursedMonster"), "topiary")) ||
			(enemy == $monster[spider (duck?) topiary animal] && !contains_text(get_property("stenchCursedMonster"), "topiary")) ||
			(enemy == $monster[renaissance giant]) ||
			(enemy == $monster[black magic woman] && item_amount($item[reassembled blackbird]) > 0) ||
			(enemy == $monster[gaudy pirate]) ||
			(enemy == $monster[Writing Desk]))
		{
			set_property("ed_edCombatHandler", combatState + "(curseofstench)");
			handleSniffs(enemy, $skill[Curse of Stench]);
			return "skill Curse of Stench";
		}
	}

	if(my_location() == $location[The Secret Council Warehouse])
	{
		if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("ed_edStatus") == "UNDYING!"))
		{
			boolean doStench = false;
			#	Rememeber, we are looking to see if we have enough of the opposite item here.
			if(enemy == $monster[Warehouse Guard])
			{
				int progress = get_property("warehouseProgress").to_int();
				progress = progress + (8 * item_amount($item[Warehouse Inventory Page]));
				if(progress >= 40)
				{
					doStench = true;
				}
			}
			if(enemy == $monster[Warehouse Clerk])
			{
				int progress = get_property("warehouseProgress").to_int();
				progress = progress + (8 * item_amount($item[Warehouse Map Page]));
				if(progress >= 40)
				{
					doStench = true;
				}
			}
			if(doStench)
			{
				set_property("ed_edCombatHandler", combatState + "(curseofstench)");
				handleSniffs(enemy, $skill[Curse of Stench]);
				return "skill Curse of Stench";
			}
		}
	}

	if(my_location() == $location[The Smut Orc Logging Camp])
	{
		if(!contains_text(edCombatState, "curseofstench") && (have_skill($skill[Curse of Stench])) && (my_mp() >= 35) && (get_property("stenchCursedMonster") != opp) && (get_property("ed_edStatus") == "UNDYING!"))
		{
			boolean doStench = false;
			string stenched = to_lower_case(get_property("stenchCursedMonster"));

			if((fastenerCount() >= 30) && (stenched != "smut orc pipelayer") && (stenched != "smut orc jacker"))
			{
				#	Sniff 100% lumber
				if((enemy == $monster[Smut Orc Pipelayer]) || (enemy == $monster[Smut Orc Jacker]))
				{
					doStench = true;
				}
			}
			if((lumberCount() >= 30) && (stenched != "smut orc screwer") && (stenched != "smut orc nailer"))
			{
				#	Sniff 100% fastener
				if((enemy == $monster[Smut Orc Screwer]) || (enemy == $monster[Smut Orc Nailer]))
				{
					doStench = true;
				}
			}
			if(doStench)
			{
				set_property("ed_edCombatHandler", combatState + "(curseofstench)");
				handleSniffs(enemy, $skill[Curse of Stench]);
				return "skill Curse of Stench";
			}
		}
	}
	
	if(contains_text(combatState, "insults") && (get_property("ed_edStatus") == "dying"))
	{
		if((enemy == $monster[shady pirate]) && have_skill($skill[Curse of Vacation]) && (my_mp() >= 30))
		{
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
	}

	if((!contains_text(combatState, "yellowray")) && (have_effect($effect[everything looks yellow]) == 0) && (have_skill($skill[Wrath of Ra])) && (my_mp() >= 40))
	{
		boolean doWrath = false;
		if((my_location() == $location[Hippy Camp]) && !possessEquipment($item[Filthy Corduroys]) && !possessEquipment($item[Filthy Knitted Dread Sack]) && !get_property("ed_legsbeforebread").to_boolean())
		{
			doWrath = true;
		}
		if((enemy == $monster[burly sidekick]) && (item_amount($item[mohawk wig]) == 0))
		{
			doWrath = true;
		}
		if(enemy == $monster[knob goblin harem girl] && !possessEquipment($item[knob goblin harem veil]) && !possessEquipment($item[knob goblin harem pants]))
		{
			doWrath = true;
		}
		if(enemy == $monster[knight (Snake)] && !possessEquipment($item[serpentine sword]) && !possessEquipment($item[snake shield]) && (my_daycount() < 3))
		{
			doWrath = true;
		}
		if(enemy == $monster[Mountain Man])
		{
			doWrath = true;
		}
		if((opp == "mountain man") && !doWrath)
		{
			doWrath = true;
			print("Mountain man was not found by $monster (" + enemy + ")and instead only by opp compare", "red");
		}
		if((enemy == $monster[Frat Warrior Drill Sergeant]) || (enemy == $monster[War Pledge]))
		{
			if(!possessEquipment($item[Bullet-Proof Corduroys]) && !possessEquipment($item[Reinforced Beaded Headband]) && !possessEquipment($item[Round Purple Sunglasses]))
			{
				doWrath = true;
			}
		}
		if(doWrath)
		{
			set_property("ed_combatHandler", combatState + "(yellowray)");
			handleYellowRay(enemy, $skill[Wrath of Ra]);
			return "skill wrath of ra";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[fallen archfiend]) && (my_location() == $location[The Dark Heart of the Woods]) && (get_property("ed_pirateoutfit") != "almost") && (get_property("ed_pirateoutfit") != "finished"))
		{
			set_property("ed_combatHandler", combatState + "(curse of vacation)");
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
	}

	if(have_skill($skill[Curse of Vacation]) && (my_mp() >= 35))
	{
		if((enemy == $monster[animated mahogany nightstand]) ||
			(enemy == $monster[steam elemental]) ||
			(enemy == $monster[flock of stab-bats]) ||
			(enemy == $monster[Skeletal sommelier]) ||
			(enemy == $monster[Irritating Series of Random Encounters]) ||
			(enemy == $monster[sabre-toothed goat]) ||
			(enemy == $monster[knob goblin harem guard]) ||
			(enemy == $monster[pygmy headhunter]) ||
			(enemy == $monster[pygmy orderlies]) ||
			(enemy == $monster[slick lihc]) ||
			(enemy == $monster[warehouse janitor]) ||
			(enemy == $monster[plaid ghost]) ||
			(enemy == $monster[mismatched twins]) ||
			(enemy == $monster[banshee librarian]) ||
			(enemy == $monster[grassy pirate]) ||
			(enemy == $monster[crusty pirate]))
		{
			set_property("ed_combatHandler", combatState + "(curse of vacation)");
			handleBanish(enemy, $skill[Curse of Vacation]);
			return "skill curse of vacation";
		}
	}

	if(((enemy == $monster[bob racecar]) || (enemy == $monster[racecar bob])) && item_amount($item[disposable instant camera]) > 0)
	{
		set_property("ed_combatHandler", combatState + "(disposable instant camera)");
		return "item disposable instant camera";
	}

	if((my_location() == $location[Oil Peak]) && (item_amount($item[duskwalker syringe]) > 0) && (get_property("ed_edStatus") == "UNDYING!"))
	{
		return "item duskwalker syringe";
	}

	if(!contains_text(edCombatState, "lashofthecobra") && have_skill($skill[Lash of the Cobra]) && (my_mp() > 19) && (get_property("_edLashCount").to_int() < 30))
	{
		set_property("ed_edCombatHandler", edCombatState + "(lashofthecobra)");
		boolean doLash = false;
		if((enemy == $monster[Swarthy Pirate]) && !possessEquipment($item[Stuffed Shoulder Parrot]))
		{
			doLash = true;
		}
		if((enemy == $monster[Big Wheelin\' Twins]) && !possessEquipment($item[Badge Of Authority]))
		{
			doLash = true;
		}
		if((enemy == $monster[Fishy Pirate]) && !possessEquipment($item[Perfume-Soaked Bandana]))
		{
			doLash = true;
		}
		if((enemy == $monster[Funky Pirate]) && !possessEquipment($item[Sewage-Clogged Pistol]))
		{
			doLash = true;
		}
		if((enemy == $monster[Garbage Tourist]) && (item_amount($item[Bag of Park Garbage]) == 0))
		{
			doLash = true;
		}
		if((enemy == $monster[Sassy Pirate]) && !possessEquipment($item[Swashbuckling Pants]))
		{
			doLash = true;
		}
		if((enemy == $monster[Smarmy Pirate]) && !possessEquipment($item[Eyepatch]))
		{
			doLash = true;
		}
		if((enemy == $monster[One-eyed Gnoll]) && !possessEquipment($item[Eyepatch]))
		{
			doLash = true;
		}
		if((enemy == $monster[Dairy Goat]) && (item_amount($item[Goat Cheese]) < 3))
		{
			doLash = true;
		}
		if((enemy == $monster[Renaissance Giant]) && (item_amount($item[Ye Olde Meade]) < 1) && (my_daycount() == 1))
		{
			doLash = true;
		}
		if((enemy == $monster[Protagonist]) && !possessEquipment($item[Ocarina of Space]) && !possessEquipment($item[Sewage-Clogged Pistol]) && !possessEquipment($item[serpentine sword])  && !possessEquipment($item[curmudgel]))
		{
			doLash = true;
		}
		if(enemy == $monster[Bearpig Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Elephant (Meatcar?) Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Spider (Duck?) Topiary Animal])
		{
			doLash = true;
		}
		if(enemy == $monster[Beanbat])
		{
			doLash = true;
		}
		if(enemy == $monster[Bookbat])
		{
			doLash = true;
		}
		if(((enemy == $monster[Toothy Sklelton]) || (enemy == $monster[Spiny Skelelton])) && (get_property("cyrptNookEvilness").to_int() > 26))
		{
			doLash = true;
		}
		if((enemy == $monster[Oil Cartel]) && (item_amount($item[Bubblin\' Crude]) < 12) && (item_amount($item[Jar of Oil]) == 0))
		{
			doLash = true;
		}
		if((enemy == $monster[Blackberry Bush]) && (item_amount($item[Blackberry]) < 3) && !possessEquipment($item[Blackberry Galoshes]))
		{
			doLash = true;
		}
		if((enemy == $monster[Pygmy Bowler]) && (get_property("_edLashCount").to_int() < 10) && (item_drop_modifier().to_int() < 100))
		{
			doLash = true;
		}
		if((enemy == $monster[Pygmy Witch Lawyer]) && (get_property("_edLashCount").to_int() < 26))
		{
			doLash = true;
		}
		if(enemy == $monster[Larval Filthworm] && (item_amount($item[filthworm hatchling scent gland]) == 0))
		{
			doLash = true;
		}
		if(enemy == $monster[Filthworm Drone] && (item_amount($item[filthworm drone scent gland]) == 0))
		{
			doLash = true;
		}
		if(enemy == $monster[Filthworm Royal Guard] && (item_amount($item[filthworm royal guard scent gland]) == 0))
		{
			doLash = true;
		}
		if(enemy == $monster[Knob Goblin Madam] && item_amount($item[Knob Goblin Perfume]) == 0)
		{
			doLash = true;
		}
		if(enemy == $monster[Knob Goblin Harem Girl] && (!possessEquipment($item[Knob Goblin Harem Veil]) || !possessEquipment($item[Knob Goblin Harem Pants])))
		{
			doLash = true;
		}
		if(my_location() == $location[Wartime Frat House (Hippy Disguise)])
		{
			if(!possessEquipment($item[Beer Helmet]) || !possessEquipment($item[Bejeweled Pledge Pin]) || !possessEquipment($item[Distressed Denim Pants]))
			{
				doLash = true;
			}
		}
		if((enemy == $monster[Burly Sidekick]) && !possessEquipment($item[Mohawk Wig]))
		{
			doLash = true;
		}
		if((enemy == $monster[Quiet Healer]) && !possessEquipment($item[Amulet of Extreme Plot Significance]))
		{
			doLash = true;
		}
		if((enemy == $monster[P Imp]) || (enemy == $monster[G Imp]))
		{
			if((get_property("ed_pirateoutfit") != "finished") && (get_property("ed_pirateoutfit") != "almost") && (item_amount($item[Hot Wing]) < 3))
			{
				doLash = true;
			}
		}
		if(enemy == $monster[Warehouse Clerk])
		{
			int progress = get_property("warehouseProgress").to_int();
			progress = progress + (8 * item_amount($item[Warehouse Inventory Page]));
			if(progress < 40)
			{
				doLash = true;
			}
		}
		if(enemy == $monster[Warehouse Guard])
		{
			int progress = get_property("warehouseProgress").to_int();
			progress = progress + (8 * item_amount($item[Warehouse Map Page]));
			if(progress < 40)
			{
				doLash = true;
			}
		}
		if(doLash)
		{
			handleLashes(enemy);
			return "skill lash of the cobra";
		}
	}

	if((item_amount($item[Tattered Scrap of Paper]) > 0) && (!contains_text(combatState, "tatters")))
	{
		if((enemy == $monster[Demoninja]) ||
			(enemy == $monster[Drunken Rat]) ||
			(enemy == $monster[Bunch of Drunken Rats]) ||
			(enemy == $monster[Knob Goblin Elite Guard]) ||
			(enemy == $monster[Drunk Goat]) ||
			(enemy == $monster[Sabre-Toothed Goat]) ||
			(enemy == $monster[Bubblemint Twins]) ||
			(enemy == $monster[Creepy Ginger Twin]) ||
			(enemy == $monster[Mismatched Twins]) ||
			(enemy == $monster[Coaltergeist]) ||
			(enemy == $monster[L imp]) ||
			(enemy == $monster[W imp]) ||
			(enemy == $monster[Hellion]) ||
			(enemy == $monster[Fallen Archfiend]))
		{
			set_property("ed_combatHandler", combatState + "(tatters)");
			return "item tattered scrap of paper";
		}
	}

	if((!contains_text(edCombatState, "talismanofrenenutet")) && (item_amount($item[Talisman of Renenutet]) > 0))
	{
		boolean doRenenutet = false;
		if((enemy == $monster[Cleanly Pirate]) && (item_amount($item[Rigging Shampoo]) == 0))
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Creamy Pirate]) && (item_amount($item[Ball Polish]) == 0))
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Curmudgeonly Pirate]) && (item_amount($item[Mizzenmast Mop]) == 0))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Possessed Wine Rack])
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Cabinet of Dr. Limpieza])
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Quiet Healer]) && !possessEquipment($item[Amulet of Extreme Plot Significance]))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Mountain Man])
		{
			doRenenutet = true;
		}
		if((enemy == $monster[Pygmy Janitor]) && (item_amount($item[Book of Matches]) == 0))
		{
			doRenenutet = true;
		}
		if(enemy == $monster[Blackberry Bush])
		{
			if(!possessEquipment($item[Blackberry Galoshes]) && (item_amount($item[Blackberry]) < 3))
			{
				doRenenutet = true;
			}
		}
		if(my_location() == $location[Wartime Frat House])
		{
			if(!possessEquipment($item[Beer Helmet]) || !possessEquipment($item[Bejeweled Pledge Pin]) || !possessEquipment($item[Distressed Denim Pants]))
			{
				doRenenutet = true;
			}
		}
		if((enemy == $monster[Warehouse Clerk]) || (enemy == $monster[Warehouse Guard]))
		{
			doRenenutet = true;
		}
		if(doRenenutet)
		{
			set_property("ed_edCombatHandler", edCombatState + "(talismanofrenenutet)");
			handleRenenutet(enemy);
			set_property("ed_edStatus", "dying");
			return "item Talisman of Renenutet";
		}
	}

	if(((enemy == $monster[Pygmy Headhunter]) || (enemy == $monster[Pygmy witch nurse])) && (item_amount($item[Short Writ of Habeas Corpus]) > 0))
	{
		return "item short writ of habeas corpus";
	}

	if(!needShop(ed_buildShoppingList()) && (my_level() >= 10) && (item_amount($item[Rock Band Flyers]) == 0) && (my_location() != $location[The Hidden Apartment Building]) && (type != to_phylum("Undead")) && (my_mp() > 20) && (my_location() != $location[Barrrney\'s Barrr]))
	{
		set_property("ed_edStatus", "dying");
	}

	if(get_property("ed_edStatus") == "UNDYING!")
	{
		if(my_location() == $location[The Secret Government Laboratory])
		{
			if(item_amount($item[Rock Band Flyers]) == 0)
			{
				if((!contains_text(combatState, "love stinkbug")) && have_skill($skill[Summon Love Stinkbug]))
				{
					set_property("ed_combatHandler", combatState + "(love stinkbug1)");
					return "skill summon love stinkbug";
				}
				if((!contains_text(combatState, "love stinkbug")) && get_property("lovebugsUnlocked").to_boolean())
				{
					set_property("ed_combatHandler", combatState + "(love stinkbug2)");
					return "skill summon love stinkbug";
				}
			}
		}

		if((!contains_text(combatState, "love scarabs")) && have_skill($skill[Summon Love Scarabs]))
		{
			set_property("ed_combatHandler", combatState + "(love scarabs)");
			return "skill summon love scarabs";
		}
		if((!contains_text(combatState, "love scarabs")) && get_property("lovebugsUnlocked").to_boolean())
		{
			set_property("ed_combatHandler", combatState + "(love scarabs)");
			return "skill summon love scarabs";
		}
		if((item_amount($item[holy spring water]) > 0) && (my_mp() < 5))
		{
			return "item holy spring water";
		}
		
		if(item_amount($item[Dictionary]) > 0)
		{
			return "item dictionary";
		}
		
		return "skill Mild Curse";
	}

	if((my_mp() >= 15) && (my_location() == $location[The Secret Government Laboratory]) && have_skill($skill[Roar of the Lion]))
	{
		if(have_skill($skill[Storm of the Scarab]) && (my_buffedstat($stat[Mysticality]) >= 60))
		{
			return "skill Storm of the Scarab";
		}
		return "skill Roar of the Lion";
	}

	int fightStat = my_buffedstat(weapon_type(equipped_item($slot[weapon]))) - 20;
	if (weapon_type(equipped_item($slot[weapon])).to_string() == "Mysticality")
	{
		fightStat = fightStat - 50;
	}
	
	if((fightStat > monster_defense()) && (round < 20) && ((expected_damage() * 1.1) < my_hp()))
	{
		return "attack with weapon";
	}

	if((item_amount($item[ice-cold Cloaca Zero]) > 0) && (my_mp() < 15) && (my_maxmp() > 200))
	{
		return "item ice-cold Cloaca Zero";
	}

	//TODO:  I'm not convinced that casting Storm just because we can is a good idea.  Tweaking the monster_hp threshold!
	//if((my_mp() >= 8) && have_skill($skill[Storm of the Scarab]) && monster_hp(enemy) > 80)
	if((my_mp() >= 8) && have_skill($skill[Storm of the Scarab]) && monster_hp(enemy) > 200)
	{
		return "skill Storm of the Scarab";
	}

	if((enemy.physical_resistance >= 100) || (round >= 25))
	{
		return "skill " + whm_stormOrFist(enemy);
	}
	int combatStage = get_property("ed_edCombatStage").to_int();
 	if (expected_damage() * 1.25 >= my_hp() && (my_maxhp() < 2*my_hp() || 2 < combatStage ))
	{
		return "skill " + whm_stormOrFist(enemy);
	}
	
	if(last_monster().id == 1185)
	{
		return "skill " + whm_stormOrFist(enemy);
	}

	if(round >= 29)
	{
		print("About to UNDYING too much but have no other combat resolution. Please report this.", "red");
	}

	return "skill fist of the mummy";
}
