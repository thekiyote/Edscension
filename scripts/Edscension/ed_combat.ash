script "ed_combat.ash"
import <ed_util.ash>
import <ed_equipment.ash>
import <ed_edTheUndying.ash>

void handleBanish(monster enemy, skill banisher);
void handleBanish(monster enemy, item banisher);
void handleYellowRay(monster enemy, skill yellowRay);
void handleLashes(monster enemy);
void handleRenenutet(monster enemy);

int ed_fistDamage() {  // (ignores physical resistance, 5 MP)
	// (see http://kol.coldfront.net/thekolwiki/index.php/Calculating_Spell_Damage)
	float baseDamage = min(my_buffedstat($stat[mysticality]), 50);
	float multiplier = 1.0; //FIXME
	float spellDamagePercent = numeric_modifier("Spell Damage Percent");
	return ceil(baseDamage * multiplier * (1+spellDamagePercent/100.0));
}

int ed_howlDamage() {  // (spooky damage, 10 MP)
	// (see http://kol.coldfront.net/thekolwiki/index.php/Calculating_Spell_Damage)
	float baseDamage = min(my_buffedstat($stat[mysticality]), 96);
	float multiplier = 1.0; //FIXME
	float spellDamagePercent = numeric_modifier("Spell Damage Percent");
	return ceil(baseDamage * multiplier * (1+spellDamagePercent/100.0));
}

// roar:  hot damage, 15 MP

int ed_stormDamage() {  // (prismatic damage, 8 MP)
	// (see http://kol.coldfront.net/thekolwiki/index.php/Calculating_Spell_Damage)
	float baseDamage = min(my_buffedstat($stat[mysticality])*1.7, 330);  //FIXME
	if (my_buffedstat($stat[mysticality]) < 50) baseDamage /= 4;   // this is a kludge to try to get more realistic estimates when first fighting hippies.
	if (last_monster().defense_element != $element[none]) baseDamage *= 1.2;
	float multiplier = 1.0; //FIXME
	float spellDamagePercent = numeric_modifier("Spell Damage Percent");
	return ceil(baseDamage * multiplier * (1+spellDamagePercent/100.0));
}

int ed_assassinDamage() {
	int ml = numeric_modifier("Monster Level");
	int baseDamage = max(0, 150 + ml - my_buffedstat($stat[Moxie]));
	baseDamage += 120;  // (Wiki gives a range of 100-120, here)
	baseDamage = max(1, baseDamage - numeric_modifier("Damage Reduction"));
	float da = numeric_modifier("Damage Absorption");
	float damageAbsorptionFraction = max((da*10)**(0.5) - 10.0, 0.0) / 100.0;
	float reducedDamage = ceil(baseDamage * (1-damageAbsorptionFraction));
	int effectiveColdResistance = max(0, numeric_modifier("Cold Resistance")-5);
	float coldResistanceFraction
		= effectiveColdResistance <= 3
			? 0.1 * effectiveColdResistance
			: 0.9 - 0.5 * (5.0/6.0)**(effectiveColdResistance-4);
	reducedDamage = max(1, ceil(reducedDamage * (1-coldResistanceFraction)));
	return reducedDamage;
}

string ed_stormIfPossible() {
	// When we get here, we would use storm if we had it.  Using fist instead.
	if (!have_skill($skill[storm of the scarab])) return "fist of the mummy";
	if (my_mp() < mp_cost($skill[storm of the scarab])) return "fist of the mummy";
	if (ed_stormDamage() < ed_fistDamage()) return "fist of the mummy";  //FIXME:  this isn't the right place for this check.
	return "storm of the scarab";
}
string ed_stormOrFist() {
	if (monster_hp() < ed_fistDamage()) return "fist of the mummy";
	return ed_stormIfPossible();
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

	if (0 < item_amount($item[Harold's Bell])) {  //WHM:  added this.
		handleBanish(enemy, $item[Harold's Bell]);
		return "item Harold's Bell";
	}
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
	if(opp == "A.M.C. gremlin")
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
			//TODO:  should that be appended to the state??
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

	if((!contains_text(combatState, "flyers")) && (my_location() != $location[The Battlefield (Frat Uniform)]) && (get_property("_edDefeats").to_int() < 3))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("ed_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}
	if(get_property("_edDefeats").to_int() > 2 && (my_location() != $location[The Battlefield (Frat Uniform)]) && (!contains_text(combatState, "flyers")) && ((expected_damage() * 1.1) <= my_hp()))
	{
		if((item_amount($item[rock band flyers]) > 0) && (get_property("flyeredML").to_int() < 10000))
		{
			set_property("ed_combatHandler", combatState + "(flyers)");
			return "item rock band flyers";
		}
	}

	if(!get_property("ed_gremlinMoly").to_boolean())
	{
		//WHM:  doesn't this mean that there's no chance of getting the Moly item?  Just kill the thing!
			string banisher = findBanisher(opp);
			if (banisher == "attack with weapon" && my_mp() >= 8) {
				return "skill " + ed_stormIfPossible();
			}
			return banisher;
/*
		if(get_property("_edDefeats").to_int() > 2)
		{
			string banisher = findBanisher(opp);
			if (banisher == "attack with weapon" && my_mp() >= 8) {
				return "skill " + ed_stormIfPossible();
			}
			return banisher;
		}
		else if(get_property("_edDefeats").to_int() == 2)
		{
			return findBanisher(opp);
		}
		else if(item_amount($item[dictionary]) > 0)
		{
			return "item dictionary";
		}
*/
	}


	if(!get_property("ed_gremlinMoly").to_boolean())
	{
		if(have_skill($skill[Storm of the Scarab]) && (my_mp() >= 8))
		{
			return "skill Storm of the Scarab";
		}
		return "attack with weapon";  //TODO:  not Fist?
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

int ed_fcleItemsNeeded() {
	return 0 < available_amount($item[pirate fledges]) ? 0
		: 3 - item_amount($item[ball polish])
			- item_amount($item[mizzenmast mop])
			- item_amount($item[rigging shampoo]);
}

boolean ed_opponentHasDesiredItem(monster o) {
	static boolean[item] desiredItemsStatic = $items[
		Stuffed Shoulder Parrot,
		Badge Of Authority,
		Perfume-Soaked Bandana,
		Sewage-Clogged Pistol,
		Bag of Park Garbage,
		Swashbuckling Pants,
		Eyepatch,
		goat cheese,
		rusty hedge trimmers,
		enchanted bean,
		tattered scrap of paper,
		filthworm hatchling scent gland,
		filthworm drone scent gland,
		filthworm royal guard scent gland,
		Knob Goblin Perfume,
		Knob Goblin Harem Veil,
		Knob Goblin Harem Pants,
		Beer Helmet,
		Bejeweled Pledge Pin,
		Distressed Denim Pants,
		Mohawk Wig,
		Amulet of Extreme Plot Significance,
		serpentine sword,
		snake shield,
		A-Boo clue
	];
	boolean[item] desiredItems;
	foreach i in desiredItemsStatic desiredItems[i] = true;
	if (my_daycount() < 3) desiredItems[$item[Ye Olde Meade]] = true;
		//TODO:  if we start supporting 2-day runs, we probably will change that condition.
	foreach i, r in item_drops_array(o) {
		if ((desiredItems contains r.drop) && !possessEquipment(r.drop)) {
			return true;
		}
	}
	return false;
}
boolean ed_opponentHasDesiredItem() { return ed_opponentHasDesiredItem(last_monster()); }


boolean ed_shouldLash(monster enemy) {
	boolean result = ed_opponentHasDesiredItem(enemy);
	if((enemy == $monster[Dairy Goat]) && (item_amount($item[Goat Cheese]) < 3))
	{
		return true;
	}
	if((enemy == $monster[Protagonist]) && !possessEquipment($item[Ocarina of Space]) && !possessEquipment($item[Sewage-Clogged Pistol]) && !possessEquipment($item[serpentine sword])  && !possessEquipment($item[curmudgel]))
	{
		return true;
	}
	if(enemy == $monster[Bearpig Topiary Animal])
	{
		return true;
	}
	if(enemy == $monster[Elephant (Meatcar?) Topiary Animal])
	{
		return true;
	}
	if(enemy == $monster[Spider (Duck?) Topiary Animal])
	{
		return true;
	}
	if(enemy == $monster[Beanbat])
	{
		return true;
	}
	if(enemy == $monster[Bookbat])
	{
		return true;
	}
	if(((enemy == $monster[Toothy Sklelton]) || (enemy == $monster[Spiny Skelelton])) && (get_property("cyrptNookEvilness").to_int() > 26))
	{
		return true;
	}
	if((enemy == $monster[Oil Cartel]) && (item_amount($item[Bubblin\' Crude]) < 12) && (item_amount($item[Jar of Oil]) == 0))
	{
		return true;
	}
	if((enemy == $monster[Blackberry Bush]) && (item_amount($item[Blackberry]) < 3) && !possessEquipment($item[Blackberry Galoshes]))
	{
		return true;
	}
	if((enemy == $monster[Pygmy Bowler]) && (get_property("_edLashCount").to_int() < 10) && (item_drop_modifier().to_int() < 100))
	{
		return true;
	}
	if((enemy == $monster[Pygmy Witch Lawyer]) && (get_property("_edLashCount").to_int() < 26))
	{
		return true;
	}
	if((enemy == $monster[P Imp]) || (enemy == $monster[G Imp]))
	{
		if((get_property("ed_pirateoutfit") != "finished") && (get_property("ed_pirateoutfit") != "almost") && (item_amount($item[Hot Wing]) < 3))
		{
			return true;
		}
	}
	if(enemy == $monster[Warehouse Clerk])
	{
		int progress = get_property("warehouseProgress").to_int();
		progress = progress + (8 * item_amount($item[Warehouse Inventory Page]));
		if (progress < 40) return true;
	}
	if(enemy == $monster[Warehouse Guard])
	{
		int progress = get_property("warehouseProgress").to_int();
		progress = progress + (8 * item_amount($item[Warehouse Map Page]));
		if (progress < 40) return true;
	}
	return result;
}

string ed_edCombatHandler(int round, string opp, string text)
{
	int combatStage = get_property("_edDefeats").to_int();
	boolean flyering
		= 0 < item_amount($item[rock band flyers]) && get_property("flyeredML").to_int() < 10000;
	if(round == 0)
	{
		print("ed_combatHandler: " + round, "brown");
		set_property("ed_combatHandler", "");
		if (combatStage < 3 && flyering)
		{
			set_property("ed_edCombatCount", 1 + get_property("ed_edCombatCount").to_int());
			set_property("ed_edStatus", "UNDYING!");
			print("test1", "red");
		} else if (combatStage < 3) {
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

	monster enemy = last_monster();
	phylum type = monster_phylum();
	string combatState = get_property("ed_combatHandler");
	string edCombatState = get_property("ed_edCombatHandler");

	float damagePerRound = expected_damage();
	if ($monster[Your winged yeti] == last_monster()) damagePerRound *= 3;  // (Mafia appears to be inaccurate?  Also, he appears to have some damage reduction applied to my Fist spells....)
	if ($monster[big swarm of ghuol whelps] == last_monster()) damagePerRound *= 3;  // Mafia appears to be inaccurate here, as well?
	if (damagePerRound < 1.0) damagePerRound = my_hp()/2 + 1;  // A kludge, to ensure that we treat unknown enemies with respect!  And, avoid dividing by zero!!
	int roundsLeftThisStage = 1 + floor(my_hp() / damagePerRound);
	int roundsPerStage = (jump_chance() < 100 ? 0 : 1) + floor(my_maxhp() / damagePerRound);
	int roundsBeforeKa = roundsLeftThisStage + roundsPerStage * (2 - combatStage);

	print("combat stage " + combatStage + ", round " + round + ":  " + roundsLeftThisStage + " more 'til underworld, " + roundsBeforeKa + " more 'til we need to spend Ka.", "blue");
	print("opponent has about " + monster_hp() + " HP.  Ed has " + my_hp() + ".  Fist does " + ed_fistDamage() + ", Storm does (?) " + ed_stormDamage() + ", opponent does " + damagePerRound, "blue");

	if (
		(item_amount($item[ka coin]) > 30)
		&& (!have_skill($skill[Healing Scarabs]) || (my_spleen_use() < spleen_limit()))
		&& 0 == combatStage
		&& (!contains_text(edCombatState, "talismanofrenenutet") && !contains_text(edCombatState, "curse of fortune") || contains_text(edCombatState, "insults"))
	) {
		//TODO:  why?  is this to go shopping?  I think I've handled that elsewhere.
		set_property("ed_edStatus", "UNDYING!");
		print("test5", "red");
	}

	int insultCount() {
		return
			to_int(to_boolean(get_property("lastPirateInsult1")))
			+ to_int(to_boolean(get_property("lastPirateInsult2")))
			+ to_int(to_boolean(get_property("lastPirateInsult3")))
			+ to_int(to_boolean(get_property("lastPirateInsult4")))
			+ to_int(to_boolean(get_property("lastPirateInsult5")))
			+ to_int(to_boolean(get_property("lastPirateInsult6")))
			+ to_int(to_boolean(get_property("lastPirateInsult7")))
			+ to_int(to_boolean(get_property("lastPirateInsult8")));
	}
	if((enemy == $monster[Pygmy Shaman] && have_effect($effect[Thrice-Cursed]) == 0) ||
		(enemy == $monster[batwinged gremlin] && item_amount($item[molybdenum hammer]) == 0) ||
		(enemy == $monster[vegetable gremlin] && item_amount($item[molybdenum screwdriver]) == 0) ||
		(enemy == $monster[spider gremlin] && item_amount($item[molybdenum pliers]) == 0) ||
		(enemy == $monster[erudite gremlin] && item_amount($item[molybdenum crescent wrench]) == 0) ||
		(enemy == $monster[tetchy pirate] && insultCount() < 8) ||
		(enemy == $monster[toothy pirate] && insultCount() < 8) ||
		(enemy == $monster[tipsy pirate] && insultCount() < 8))
	{
		set_property("ed_edStatus", "UNDYING!");
		print("test6", "red");
	}
	
	if ((combatStage >= 2) && !flyering)
	{
		set_property("ed_edStatus", "dying");
		print("test2", "red");
	}
	if (
		(combatStage < 4)
		&& flyering
		&& (item_amount($item[ka coin]) > 2)
		&& !contains_text(edCombatState, "talismanofrenenutet")
	)
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
		if (flyering && combatStage < 4)  //TODO:  Ka budget.
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
				return ed_stormIfPossible();
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
			doWrath = true;  //TODO:  I think this is to keep it from interfering with other Wrath use to get the war outfit?
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

	if(((enemy == $monster[bob racecar]) || (enemy == $monster[racecar bob])) && item_amount($item[disposable instant camera]) > 0 && 0 == item_amount($item[photograph of a dog]))
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
		if (ed_shouldLash(enemy)) {
			handleLashes(enemy);
			return "skill lash of the cobra";
		}
	}

	if((item_amount($item[Tattered Scrap of Paper]) > 0) && (!contains_text(combatState, "tatters")))
	{
		if((enemy == $monster[Demoninja]) ||
			(enemy == $monster[banshee librarian]) ||
			(enemy == $monster[Drunken Rat]) ||
			(enemy == $monster[Bunch of Drunken Rats]) ||
			(enemy == $monster[Knob Goblin Elite Guard]) ||
			(enemy == $monster[Drunk Goat]) ||
			(enemy == $monster[Sabre-Toothed Goat]) ||
			(enemy == $monster[Bubblemint Twins]) ||  // 2 Ka
			(enemy == $monster[Creepy Ginger Twin]) ||  // 2 Ka
			(enemy == $monster[Mismatched Twins]) ||  // 2 Ka
			(enemy == $monster[Coaltergeist]) ||
			(enemy == $monster[L imp]) ||
			(enemy == $monster[W imp]) ||
			(enemy == $monster[Hellion]) ||
			(enemy == $monster[Fallen Archfiend]))
		{
			//TODO:  note than some of those give Ka.  If we have reason to worry about getting Ka, we might want to fight them.
			set_property("ed_combatHandler", combatState + "(tatters)");
			return "item tattered scrap of paper";
		}
	}

	boolean forceStasis = false;
	if (
		roundsPerStage < 20
		&& roundsLeftThisStage*3/2 < roundsPerStage
		&& combatStage < 2
		&& monster_hp() < roundsPerStage * ed_stormDamage()
		// && (my_hp() * 1.1 < my_maxhp() || roundsLeftThisStage < 10)
			//TODO: note that if Ed has 33/35 HP, and
			// opponent does 34 damage, then we have one round in the first combat, and 5 total.
			// If the damage estimate is accurate (although, it isn't) then we really can gain
			// a advantage by recovering those 2HP.  And in a short combat, that could be important.
	) {
		print("Ed will defer until another combat, in order to heal & buy time.", "blue");
		forceStasis = true;
	}
	if (needShop(ed_buildShoppingList()) && monster_hp() / ed_fistDamage() < roundsPerStage) forceStasis = true;
	if (contains_text(edCombatState, "talismanofrenenutet") && forceStasis) {
		forceStasis = false;
	}

	if((!contains_text(edCombatState, "talismanofrenenutet")) && (item_amount($item[Talisman of Renenutet]) > 0))
	{
		boolean doRenenutet = false;
		if (ed_opponentHasDesiredItem()) {
			// when we get here, we may have tried lash, but we still don't have our target item.
			// so, we may use a renenutet.
			// (note that, currently, we only use a renenutet to acquire the first one of any given item)
			//print("TODO:  ed_opponentHasDesiredItem() reports that we should use renenutet!  Verify that this is appropriate!", "red");
			doRenenutet = true;
		}
		if (
			enemy == $monster[knob goblin harem girl]
			&& !(possessEquipment($item[knob goblin harem veil]) && possessEquipment($item[knob goblin harem pants]))
		) {
			doRenenutet = true;
		}
		int renenutetsAvailable = item_amount($item[Talisman of Renenutet]) + 7 - to_int(get_property("ed_renenutetsBought"));
		if (enemy == $monster[Larval Filthworm] && renenutetsAvailable < 8)
		{
			print("TODO:  skipping renenutet, in order to save it for later filthworm stages!  Make sure this is working as expected!", "red");
			doRenenutet = false;
		}
		if(enemy == $monster[Filthworm Drone] && renenutetsAvailable < 3)
		{
			print("TODO:  skipping renenutet, in order to save it for a royal guard!  Make sure this is working as expected!", "red");
			doRenenutet = false;
		}
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
		if (
			(enemy == $monster[Warehouse Clerk] || enemy == $monster[Warehouse Guard])
			&& !have_skill($skill[Lash of the Cobra])
		) {
			//TODO:  we could still use it if we have lash, if we know that it did not drop from lash....
			doRenenutet = true;
		}

		if (
			doRenenutet
			&& $location[The F'c'le] != my_location()
			&& item_amount($item[talisman of Renenutet]) <= ed_fcleItemsNeeded()
		) {
			doRenenutet = false;
		}
		if (doRenenutet && forceStasis) {
			print("Waiting until next combat before we use a talisman of Renenutet.", "blue");
			doRenenutet = false;
		}
		if (
			doRenenutet
			&& flyering
			&& combatStage < 2  //TODO:  Will we sometimes spend some Ka on flyering?
				// && contains_text(combatState, "flyers")
				// Will that work for all combat stages where we flyer?
		) {
			print("Waiting until we are done using flyers before we use a talisman of Renenutet.", "blue");
			doRenenutet = false;
		}
		if (doRenenutet && roundsPerStage < 2) {
			print("FIXME:  adventuring logic led us to a place where we would like to use a Renenutet, but we don't expect to get a chance to do so!", "red");
			// we could only ever use it successfully against this opponent
			// if we were to get lucky.
			// (if this happens, we probably want to add some checks in the adventuring logic
			// that led us here, in order to avoid it.)
			doRenenutet = false;
		}
		//TODO:  there may still be 2-round fights where Ed ought to soften up the opponent
		//       in this fight, so that he is guaranteed to finish the next fight with Renenutet
		//       active.  We need the stasis logic
		//       to support that. first, before we can really do anything about it here.  For
		//       now, I'll avoid using renenutets:
		if (
			doRenenutet
			&& 2 == roundsLeftThisStage
			&& (ed_stormDamage() < monster_hp()
				|| !have_skill($skill[Storm of the Scarab]) && ed_fistDamage() < monster_hp()
			)
		) {
			print("Using a talisman of Renenutet right now would be risky!", "blue");
			doRenenutet = false;
		}
		if (doRenenutet && roundsLeftThisStage < 2) {
			print("Using a talisman of Renenutet right now would be very risky!", "blue");
			doRenenutet = false;
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

	if(!needShop(ed_buildShoppingList()) && (my_level() >= 10) && (item_amount($item[Rock Band Flyers]) == 0) && (my_location() != $location[The Hidden Apartment Building]) && (type != to_phylum("Undead")) && (my_mp() > 20) && (my_location() != $location[Barrrney\'s Barrr]) && !forceStasis)
	{
		set_property("ed_edStatus", "dying");
	}

	if(get_property("ed_edStatus") == "UNDYING!" || forceStasis)
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
		if((item_amount($item[holy spring water]) > 0) && (my_mp() < mp_cost($skill[fist of the mummy])))
		{
			return "item holy spring water";
		}

		//TODO:  if opponent has high current hp, we might want to soften it up a bit.
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
	//TODO:  other mp restores??

	if (my_mp() < mp_cost($skill[fist of the mummy]))
	{
		print("We aren't able to restore enough MP to cast a real spell!  Attacking might be better than Mild Curse", "red");
		return "attack with weapon";
	}

	if(round >= 25)
	{
		print("This combat is taking too long.  Trying to finish it.", "red");
		return "skill " + ed_stormIfPossible();
	}

	if (roundsBeforeKa * ed_fistDamage() < monster_hp()) {
		print("This combat would eventually cost Ka if we only use fist.  Trying to expedite it.", "blue");
		return "skill " + ed_stormIfPossible();
	}

	if (monster_hp() > 300)
	{
		print("This opponent is pretty big.  Trying to cut it down to size.", "blue");
		return "skill " + ed_stormIfPossible();
	}

 	if (
		expected_damage() * 1.25 >= my_hp() && (
			1 < combatStage
			|| contains_text(edCombatState, "talismanofrenenutet")
			//TODO:  are there other reasons not to die?
		)
	) {
		print("This opponent could kill me this round, and I'd rather not visit the underworld right now.", "blue");
		return "skill " + ed_stormIfPossible();
	}

	if(last_monster().id == 1185)  // (why does this need special logic?)
	{
		print("This opponent is a ninja snowman assassin.", "blue");
		return "skill " + ed_stormOrFist();
	}

	if ((1 + floor(monster_hp() / ed_fistDamage())) * mp_cost($skill[fist of the mummy])
		> (1 + floor(monster_hp() / ed_stormDamage())) * mp_cost($skill[storm of the scarab]))
	{
		return "skill " + ed_stormIfPossible();
	}

	if(round >= 29)
	{
		print("About to UNDYING too much but have no other combat resolution. Please report this.", "red");
	}

	return "skill fist of the mummy";
}
