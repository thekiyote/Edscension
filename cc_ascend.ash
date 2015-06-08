script "cc_ascend.ash";
notify Zen00;

import <zlib.ash>
import <cc_combat.ash>
import <cc_util.ash>
import <floristfriar.ash>
import <chateaumantegna.ash>
import <cc_equipment.ash>
import <cc_edTheUndying.ash>
import <cc_eudora.ash>
import <cc_elementalPlanes.ash>

boolean LX_handleSpookyravenNecklace();
boolean LX_handleSpookyravenFirstFloor();
boolean LX_islandAccess();
boolean LX_pirateOutfit();
boolean LX_pirateInsults();
boolean LX_pirateBlueprint();
boolean LX_pirateBeerPong();
boolean LX_fcle();
boolean LX_getDictionary();
boolean LX_dictionary();
boolean LX_dinseylandfillFunbucks();
boolean LX_nastyBooty();
boolean LX_spookyravenSecond();
boolean LX_spookyBedroomCombat();
boolean L1_edIsland();
boolean L1_edIsland(int dickstabOverride);
boolean L1_edIslandFallback();
boolean L2_mosquito();
boolean L2_treeCoin();
boolean L2_spookyMap();
boolean L2_spookyFertilizer();
boolean L2_spookySapling();
boolean L3_tavern();
boolean L4_batCave();
boolean L5_haremOutfit();
boolean L5_goblinKing();
boolean L5_getEncryptionKey();
boolean L6_friarsGetParts();
boolean L6_friarsHotWing();
boolean L8_trapperStart();
boolean L7_crypt();
boolean L8_trapperGround();
boolean L8_trapperYeti();
boolean L9_chasmStart();
boolean L9_chasmBuild();
boolean L9_highLandlord();
boolean L9_aBooPeak();
boolean L9_twinPeak();
boolean L9_oilPeak();
boolean L10_airship();
boolean L10_basement();
boolean L10_ground();
boolean L10_topFloor();
boolean L11_blackMarket();
boolean L11_forgedDocuments();
boolean L11_mcmuffinDiary();
boolean L11_unlockHiddenCity();
boolean L11_hiddenCityZones();
boolean L11_talismanOfNam();
boolean L11_mauriceSpookyraven();
boolean L11_nostrilOfTheSerpent();
boolean L12_flyerFinish();
boolean L12_preOutfit();
boolean L12_getOutfit();
boolean L12_startWar();
boolean L12_filthworms();
boolean L12_sonofaBeach();
boolean L12_sonofaFinish();
boolean L12_gremlins();
boolean L12_gremlinStart();
boolean questOverride();

void initializeSettings()
{
	if(my_ascensions() <= get_property("cc_doneInitialize").to_int())
	{
		return;
	}
	set_property("cc_doneInitialize", my_ascensions());

	set_property("kingLiberatedScript", "kingLiberated.ash");
	set_property("afterAdventureScript", "postadventure.ash");
	set_property("betweenAdventureScript", "preadventure.ash");
	set_property("chasmBridgeProgress", 0);
	set_property("cc_abooclover", "");
	set_property("cc_aboocount", "0");
	set_property("cc_aftercore", "");
	set_property("cc_airship", "");
	set_property("cc_ballroom", "");
	set_property("cc_ballroomflat", "");
	set_property("cc_ballroomopen", "");
	set_property("cc_ballroomsong", "");
	set_property("cc_banishes_day1", "");
	set_property("cc_banishes_day2", "");
	set_property("cc_banishes_day3", "");
	set_property("cc_banishes_day4", "");
	set_property("cc_banishes", "");
	set_property("cc_bat", "");
	set_property("cc_bean", "");
	set_property("cc_getBeehive", false);
	set_property("cc_blackfam", false);
	set_property("cc_blackmap", "");
	set_property("cc_boopeak", "");
	set_property("cc_breakstone", get_property("cc_pvpEnable").to_boolean());
	set_property("cc_castlebasement", "");
	set_property("cc_castleground", "");
	set_property("cc_castletop", "");
	set_property("cc_chasmBusted", true);
	set_property("cc_crypt", "");
	set_property("cc_day1_cobb", "");
	set_property("cc_day1_init", "");
	set_property("cc_day2_init", "");
	set_property("cc_day3_init", "");
	set_property("cc_day4_init", "");
	set_property("cc_disableAdventureHandling", "no");
	set_property("cc_doCombatCopy", "no");
	set_property("cc_fcle", "");
	set_property("cc_friars", "");
	set_property("cc_gaudy", "");
	set_property("cc_gaudypiratecount", "");
	set_property("cc_goblinking", "");
	set_property("cc_gremlins", "");
	set_property("cc_gunpowder", "");
	set_property("cc_haveoven", false);
	set_property("cc_hiddenapartment", "0");
	set_property("cc_hiddenbowling", "");
	set_property("cc_hiddencity", "");
	set_property("cc_hiddenhospital", "");
	set_property("cc_hiddenoffice", "0");
	set_property("cc_hiddenunlock", "");
	set_property("cc_hiddenzones", "");
	set_property("cc_highlandlord", "");
	set_property("cc_highLogging", false);
	set_property("cc_hippyInstead", "false");
	set_property("cc_hugeghuol", "");
	set_property("cc_ignoreFlyer", "false");
	set_property("cc_legsbeforebread", "false");
	set_property("cc_mcmuffin", "");
	set_property("cc_mistypeak", "");
	set_property("cc_modernzmobiecount", "");
	set_property("cc_mosquito", "");
	set_property("cc_nuns", "");
	set_property("cc_nunsTrick", "no");
	set_property("cc_nunsTrickActive", "no");
	set_property("cc_nunsTrickCount", "0");
	set_property("cc_nunsTrickReady", "");
	set_property("cc_oilpeak", "");
	set_property("cc_orchard", "");
	set_property("cc_palindome", "");
	set_property("cc_palindomeDudesDefeated", "");
	set_property("cc_prewar", "");
	set_property("cc_prehippy", "");
	set_property("cc_pirateoutfit", "");
	set_property("cc_priorCharpaneMode", "0");
	set_property("cc_semirare", "");
	set_property("cc_semisub", "");
	set_property("cc_snapshot", "");
	set_property("cc_sniffs", "");
	set_property("cc_spookyfertilizer", "");
	set_property("cc_spookymap", "");
	set_property("cc_spookyravennecklace", "");
	set_property("cc_spookyravensecond", "");
	set_property("cc_spookysapling", "");
	set_property("cc_sonata", "");
	set_property("cc_sorceress", "");
	set_property("cc_swordfish", "");
	set_property("cc_tavern", "");
	set_property("cc_trapper", "");
	set_property("cc_treecoin", "");
	set_property("cc_twinpeak", "");
	set_property("cc_twinpeakprogress", "");
	set_property("cc_war", "");
	set_property("cc_winebomb", "");
	set_property("cc_writingDeskSummon", false);
	set_property("cc_yellowRay_day1", "");
	set_property("cc_yellowRay_day2", "");
	set_property("cc_yellowRay_day3", "");
	set_property("cc_yellowRay_day4", "");
	set_property("cc_yellowRays", "");
	
	elementalPlanes_initializeSettings();
	eudora_initializeSettings();
	florist_initializeSettings();
	chateaumantegna_initializeSettings();
	ed_initializeSettings();
}

boolean ccAdv(int num, location loc, string option)
{
	return ed_ccAdv(num, loc, option);
}

boolean ccAdv(int num, location loc)
{
	return ccAdv(num, loc, "");
}

boolean ccAdvBypass(string url, location loc)
{
	ed_preAdv(1, loc, "");
	print("About to start a combat indirectly at " + loc + "...", "blue");
	string page = visit_url(url);
	if((my_hp() == 0) || (get_property("_edDefeats").to_int() == 1))
	{
		print("Uh oh! Died when starting a combat indirectly.", "red");
		return ed_ccAdv(1, loc, "", true);
	}
	if(contains_text(page, "Combat"))
	{
		return ccAdv(1, loc);
	}
	return false;
}

boolean ccAdvBypass(int snarfblat, location loc)
{
	string page = "adventure.php?snarfblat=" + snarfblat + "&confirm=on";
	return ccAdvBypass(page, loc);
}

boolean ccAdvBypass(int snarfblat)
{
	return ccAdvBypass(snarfblat, $location[Noob Cave]);
}

boolean ccAdvBypass(string url)
{
	return ccAdvBypass(url, $location[Noob Cave]);
}

#This is an override so we can add locations while they are not part of a daily mafia build.
boolean tryAdventure(string loc, int snarfblat)
{
	if(contains_text(visit_url("adventure.php?snarfblat=" + snarfblat), "Combat"))
	{
		print("Overriding unknown location: " + loc + " + at: " + snarfblat, "red");
		return ccAdv(1, $location[Noob Cave]);
	}
	return false;
}
void warOutfit()
{
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		outfit("frat warrior fatigues");
	}
	else
	{
		outfit("war hippy fatigues");
	}
}

void warAdventure()
{
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		handleServant($servant[Scribe]);
		ccAdv(1, $location[The Battlefield (Frat Uniform)]);
	}
	else
	{
		handleServant($servant[Scribe]);
		ccAdv(1, $location[The Battlefield (Hippy Uniform)]);
	}
}

//Return false if you should continue, true if it did something
boolean doThemtharHills(boolean trickMode)
{
	if(get_property("currentNunneryMeat").to_int() >= 100000)
	{
		set_property("cc_nunsTrickReady", "done");
		set_property("cc_nuns", "done");
		set_property("cc_nunsTrick", "finished");
		return false;
	}

	if(get_property("cc_hippyInstead").to_boolean() || (get_property("hippiesDefeated").to_int() >= 192))
	{
		print("Themthar Nuns!", "blue");
		trickMode = false;
	}
	else
	{
		print("Themthar Nuns! Trick Mode Bitches!", "blue");
	}

	int copyAvailable = 0;
	boolean copyPossible = false;
	boolean fightCopy = false;
	if(trickMode && (get_property("cc_nunsTrickReady") == "yes") && (get_property("hippiesDefeated").to_int() < 192))
	{
		if(copyAvailable == 0)
		{
			return false;
#			if(!copyPossible)
#			{
#				set_property("cc_nunsTrickReady", "done");
#				set_property("cc_nunsTrick", "finished");
#			}
		}
		fightCopy = true;
	}

	if((get_property("sidequestArenaCompleted") == "fratboy") && (get_property("concertVisited") == "false") && (have_effect($effect[Winklered]) == 0))
	{
		outfit("frat warrior fatigues");
		cli_execute("concert 2");
#		outfit("war hippy fatigues");
	}





	if(my_class() == $class[Ed])
	{
		visit_url("charsheet.php");
		adjustEdHat("meat");
		handleServant($servant[maid]);
	}
	float meatDropHave = meat_drop_modifier();
	meatDropHave = meatDropHave + edMeatBonus();
	buffMaintain($effect[Purr of the Feline], 10, 1, 1);
	if((meatDropHave > 350.0))
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}



	if((get_property("cc_nunsTrickCount").to_int() > 2) || (meat_drop_modifier() > 600.0))
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	// Target 1000 + 400% = 5000 meat per brigand. Of course we want more, but don\'t bother unless we can get this.
	float meat_need = 400.00;
	if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
	{
		meat_need = meat_need - 200;
	}
	if(trickMode)
	{
		// Trick Mode should probably target more than 7000 meat per brigand.
		meat_need = meat_need + 200.00;
	}
	if(my_class() != $class[Ed])
	{
		meatDropHave = meat_drop_modifier();
	}
	if(meatDropHave < meat_need)
	{
		print("Meat drop (" + meatDropHave+ ") is pretty low, (we want: " + meat_need + ") probably not worth it to try this.", "red");

		float minget = 800.00 * (meatDropHave / 100.0);
		int meatneed = 100000 - get_property("currentNunneryMeat").to_int();
		print("The min we expect is: " + minget + " and we need: " + meatneed, "blue");
		if(trickMode)
		{
			if(!user_confirm("About to cancel nuns trick (click yes to continue, no to abort), still need testing on the parameters here."))
			{
				abort("User aborted nuns trick. We do not turn off the nuns flags. Beep.");
			}
		}

		if(minget < meatneed)
		{
			set_property("cc_nuns", "done");
			set_property("cc_nunsTrick", "no");
			set_property("cc_nunsTrickReady", "done");
			return true;
		}
		else
		{
			print("The min should be enough! Doing it!!", "purple");
		}
	}

	buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	buffMaintain($effect[Big Meat Big Prizes], 0, 1, 1);

	if(fightCopy)
	{
		print("Themthar Nuns Trick attempt to finish: " + copyAvailable, "blue");
		print("Meat drop to start: " + meat_drop_modifier(), "blue");
		if(equipped_item($slot[hat]) == $item[Reinforced Beaded Headband])
		{
			abort("Trying to nuns trick and might be wearing the Hippy Outfit");
		}

		switch(copyAvailable)
		{
		case 1:		//Rainman
			break;
		case 2:		//Rain-doh box
			break;
		case 3:		//4-D Camera
			break;
		default:
			abort("Trying nuns trick but unhandled copy case, meaning you have no copies I can detect. Beep.");
			break;
		}
	}
	else
	{
		if(trickMode)
		{
			outfit("war hippy fatigues");
			if(get_property("cc_nunsTrickCount").to_int() == 0)
			{
				visit_url("bigisland.php?place=nunnery");
			}
		}
		else
		{
			warOutfit();
		}

		int lastMeat = get_property("currentNunneryMeat").to_int();
		print("Meat drop to start: " + meat_drop_modifier(), "blue");
		ccAdv(1, $location[The Themthar Hills]);
		if(last_monster() != $monster[dirty thieving brigand])
		{
			return true;
		}
		int curMeat = get_property("currentNunneryMeat").to_int();

		int advs = get_property("cc_nunsTrickCount").to_int() + 1;
		set_property("cc_nunsTrickCount", advs);

		int diffMeat = curMeat - lastMeat;
		int needMeat = 100000 - curMeat;
		int average = curMeat / advs;
		print("Cur Meat: " + curMeat + " Average: " + average, "blue");

		diffMeat = diffMeat * 1.2;
		average = average * 1.2;
		if(trickMode && ((needMeat < diffMeat) || (needMeat < average)))
		{
			set_property("cc_nunsTrickReady", "yes");
			print("Attempting nuns trick, beep boop!! No more auto-aborting!");
		}
		if((item_amount($item[stone wool]) > 0) && (get_property("cc_nunsTrickCount").to_int() > 2) && !get_property("_templeHiddenPower").to_boolean())
		{
			use(1, $item[stone wool]);
			put_closet(item_amount($item[stone wool]), $item[stone wool]);
			ccAdv(1, $location[The Hidden Temple]);
		}
	}
	return true;
}

if(item_amount($item[Carton of Astral Energy Drinks]) > 0)
{
	use(1, $item[carton of astral energy drinks]);
}
if(item_amount($item[Astral Six-Pack]) > 0)
{
	use(1, $item[Astral Six-Pack]);
}
if(item_amount($item[Astral Hot Dog Dinner]) > 0)
{
	use(1, $item[Astral Hot Dog Dinner]);
}

void handleMCD()
{
	if(knoll_available() && (item_amount($item[detuned radio]) == 0) && (my_meat() > 300))
	{
		buy(1, $item[detuned radio]);
		change_mcd(10);
		visit_url("choice.php?pwd&whichchoice=835&option=2", true);
	} else if(!knoll_available())
	{
		change_mcd(10);
		if(canadia_available())
		{
			change_mcd(11);
		}
	} else
	{
		change_mcd(10);
	}
}

void sellStuff()
{
	autosell(item_amount($item[dense meat stack]), $item[dense meat stack]);
	autosell(item_amount($item[fancy bath salts]), $item[fancy bath salts]);
	autosell(item_amount($item[empty Cloaca-Cola bottle]), $item[empty Cloaca-Cola bottle]);
	autosell(item_amount($item[headhunter necktie]), $item[headhunter necktie]);
	autosell(item_amount($item[keel-haulin' knife]), $item[keel-haulin' knife]);
	autosell(item_amount($item[drab sonata]), $item[drab sonata]);
	autosell(item_amount($item[photoprotoneutron torpedo]), $item[photoprotoneutron torpedo]);
	autosell(item_amount($item[procrastination potion]), $item[procrastination potion]);
	autosell(item_amount($item[awful poetry journal]), $item[awful poetry journal]);
	autosell(item_amount($item[leather chaps]), $item[leather chaps]);
	autosell(item_amount($item[mesh cap]), $item[mesh cap]);
	autosell(item_amount($item[disturbing fanfic]), $item[disturbing fanfic]);
	autosell(item_amount($item[carob chunks]), $item[carob chunks]);
	autosell(item_amount($item[herbs]), $item[herbs]);
	autosell(item_amount($item[imp ale]), $item[imp ale]);
	autosell(item_amount($item[ratgut]), $item[ratgut]);
	autosell(item_amount($item[hemp string]) - 1, $item[hemp string]);
	autosell(item_amount($item[loose teeth]), $item[loose teeth]);
	autosell(item_amount($item[skeleton bone]), $item[skeleton bone]);
	autosell(item_amount($item[cocoa eggshell fragment]), $item[cocoa eggshell fragment]);
	autosell(item_amount($item[lihc eye]), $item[lihc eye]);
	autosell(item_amount($item[batgut]), $item[batgut]);
	autosell(item_amount($item[patchouli incense stick]), $item[patchouli incense stick]);
	autosell(item_amount($item[broken sword]), $item[broken sword]);
	autosell(item_amount($item[dire fudgesicle]), $item[dire fudgesicle]);
	autosell(item_amount($item[frigid ninja stars]), $item[frigid ninja stars]);
	autosell(item_amount($item[tambourine bells]), $item[tambourine bells]);
	autosell(item_amount($item[beach glass bead]), $item[beach glass bead]);
	autosell(item_amount($item[clay peace-sign bead]), $item[clay peace-sign bead]);
	autosell(item_amount($item[hippy bongo]), $item[hippy bongo]);
	autosell(item_amount($item[windchimes]), $item[windchimes]);
	autosell(item_amount($item[phat turquoise bead]), $item[phat turquoise bead]);
	autosell(item_amount($item[filthy pestle]), $item[filthy pestle]);
	autosell(item_amount($item[decorative fountain]), $item[decorative fountain]);
	autosell(item_amount($item[filthy knitted dread sack]) - 1, $item[filthy knitted dread sack]);
	autosell(item_amount($item[filthy corduroys]) - 1, $item[filthy corduroys]);
	autosell(item_amount($item[hot wing]) - 3, $item[hot wing]);
	autosell(item_amount($item[ice-cold Willer]), $item[ice-cold Willer]);
	autosell(item_amount($item[moxie weed]), $item[moxie weed]);
	autosell(item_amount($item[strongness elixir]), $item[strongness elixir]);
	autosell(item_amount($item[leather mask]), $item[leather mask]);
	autosell(item_amount($item[flaming crutch]), $item[flaming crutch]);
	autosell(item_amount($item[Feng Shui for Big Dumb Idiots]), $item[Feng Shui for Big Dumb Idiots]);
	autosell(item_amount($item[enchanted bean]), $item[enchanted bean]);
	autosell(item_amount($item[spooky shrunken head]), $item[spooky shrunken head]);
	autosell(item_amount($item[hot katana blade]), $item[hot katana blade]);
	autosell(item_amount($item[sunken chest]), $item[sunken chest]);
	autosell(item_amount($item[flaregun]), $item[flaregun]);
	autosell(item_amount($item[wussiness potion]), $item[wussiness potion]);
}

void initializeDay(int day)
{
	if(get_property("kingLiberated").to_boolean())
	{
		return;
	}
	
	cli_execute("ccs null");
	chateaumantegna_useDesk();
	ed_initializeDay(day);
	
	if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
	{
		set_property("cc_castleground", "done");
		set_property("cc_semisub", "inhaler");
	}
	if((item_amount($item[cursed microwave]) >= 1) && (get_property("_cursedMicrowaveUsed") == "false"))
	{
		use(1, $item[cursed microwave]);
	}
	if((item_amount($item[cursed pony keg]) >= 1) && (get_property("_cursedKegUsed") == "false"))
	{
		use(1, $item[cursed pony keg]);
	}
}

void doBedtime()
{
	print("Starting bedtime.", "blue");

	if(get_property("lastEncounter") == "Like a Bat Into Hell")
	{
		abort("Our last encounter was UNDYING and we ended up trying to bedtime and failed.");
	}

	process_kmail("cc_deleteMail");

	if(my_adventures() > 4)
	{
		if(my_inebriety() <= inebriety_limit())
		{
			return;
		}
	}
	
	if(my_fullness() < fullness_limit())
	{
		return;
	}
	
	if(my_inebriety() < inebriety_limit())
	{
		return;
	}
	
	int spleenlimit = spleen_limit();
	
	if(my_spleen_use() < spleenlimit)
	{
		return;
	}

	if(get_property("cc_priorCharpaneMode").to_int() == 1)
	{
		print("Resuming Compact Character Mode.");
		set_property("cc_priorCharpaneMode", 0);
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=1&ajax=0", true);
	}

	if(get_property("cc_priorXiblaxianMode").to_int() == 1)
	{
		set_property("cc_priorXiblaxianMode", 0);
		setvar("chit.helpers.xiblaxian", true);
	}

	if(my_class() == $class[Ed])
	{
		if(get_property("hpAutoRecoveryItems") == "linen bandages")
		{
			set_property("hpAutoRecoveryItems", get_property("cc_hpAutoRecoveryItems"));
			set_property("hpAutoRecovery", get_property("cc_hpAutoRecovery"));
			set_property("hpAutoRecoveryTarget", get_property("cc_hpAutoRecoveryTarget"));
			set_property("cc_hpAutoRecoveryItems", "");
			set_property("cc_hpAutoRecovery", 0.0);
			set_property("cc_hpAutoRecoveryTarget", 0.0);
		}
	}

	hermit(10, $item[ten-leaf clover]);

	if((friars_available()) && (!get_property("friarsBlessingReceived").to_boolean()))
	{
		cli_execute("friars familiar");
	}
	if((my_hp() < my_maxhp()) && (get_property("_hotTubSoaks").to_int() < 5))
	{
		cli_execute("hottub");
	}

	//	Also uses "nunsVisits", as long as they were won by the Frat (sidequestNunsCompleted="fratboy").
	equipRollover();
	
	if((get_property("sidequestArenaCompleted") != "none") && (get_property("concertVisited") == "false"))
	{
		cli_execute("concert 2");
	}
	
	if(my_inebriety() <= inebriety_limit())
	{
		print("Goodnight done, please make sure to handle your overdrinking, then you can run me again.", "blue");
		if((item_amount($item[ye olde meade]) > 0) && (my_daycount() == 1))
		{
			print("You can drink a Ye Olde Meade as your nightcap! Yay!", "blue");
		}
		abort("You need to overdrink and then run me again. Beep.");
	}
	else
	{
		print("You are probably done for today, beep.", "blue");
	}
}


boolean questOverride()
{
	// At the start of an ascension, get_campground() displays the wrong info.
	// Visiting the campground doesn\'t work.... grrr...
	//	visit_url("campground.php");

#	if(!get_property("cc_haveoven").to_boolean())
#	{
#		if(get_campground() contains $item[Dramatic&trade; range])
#		{
#			set_property("cc_haveoven", true);
#		}
#	}
	if((get_property("questL02Larva") == "finished") && (get_property("cc_mosquito") != "finished"))
	{
		print("Found completed Mosquito Larva (2)");
		set_property("cc_mosquito", "finished");
	}
	if((get_property("questL03Rat") == "finished") && (get_property("cc_tavern") != "finished"))
	{
		print("Found completed Tavern (3)");
		set_property("cc_tavern", "finished");
	}
	if((get_property("questL04Bat") == "finished") && (get_property("cc_bat") != "finished"))
	{
		print("Found completed Bat Cave (4)");
		set_property("cc_bat", "finished");
	}
	if((get_property("questL05Goblin") == "finished") && (get_property("cc_goblinking") != "finished"))
	{
		print("Found completed Goblin King (5)");
		set_property("cc_day1_cobb", "finished");
		set_property("cc_goblinking", "finished");
	}
	if((get_property("questL06Friar") == "finished") && (get_property("cc_friars") != "finished"))
	{
		print("Found completed Friars (6)");
		set_property("cc_friars", "finished");
	}
	if((get_property("questL07Cyrptic") == "finished") && (get_property("cc_friars") != "finished"))
	{
		print("Found completed Cyrpt (7)");
		set_property("cc_crypt", "finished");
	}
	if((get_property("questL08Trapper") == "step2") && (get_property("cc_trapper") != "yeti"))
	{
		print("Found Trapper partially completed (8: Ores/Cheese)");
		set_property("cc_trapper", "yeti");
	}
	if((get_property("questL08Trapper") == "finished") && (get_property("cc_trapper") != "finished"))
	{
		print("Found completed Trapper (8)");
		set_property("cc_trapper", "finished");
	}
	if((get_property("questL09Topping") == "finished") && (get_property("cc_highlandlord") != "finished"))
	{
		print("Found completed Highland Lord (9)");
		set_property("cc_highlandlord", "finished");
	}
	if((get_property("questM12Pirate") == "finished") && (get_property("cc_pirateoutfit") != "finished"))
	{
		print("Found completed pirates, Arrr! (8)");
		set_property("cc_pirateoutfit", "finished");
	}
	if((get_property("questM16Temple") == "finished") && (get_property("cc_spookymap") != "finished"))
	{
		print("Found completed forest, Spoooky! (3)");
		set_property("cc_spookyfertilizer", "finished");
		set_property("cc_spookymap", "finished");
		set_property("cc_spookysapling", "finished");
		set_property("cc_treecoin", "finished");
	}
	if((get_property("questL10Garbage") == "finished") && (get_property("cc_castletop") != "finished"))
	{
		print("Found completed Castle in the Clouds in the Sky with some Pie (10)");
		set_property("cc_castletop", "finished");
		set_property("cc_castleground", "finished");
		set_property("cc_castlebasement", "finished");
		set_property("cc_airship", "finished");
	}
	if((get_property("questL11Black") == "finished") && (get_property("cc_blackmap") != "finished"))
	{
		print("Found completed Black Market (11)");
		set_property("cc_blackmap", "finished");
	}
	if((get_property("questL11Palindome") == "finished") && (get_property("cc_palindome") != "finished"))
	{
		print("Found completed Palindome (11)");
		set_property("cc_palindome", "finished");
	}
	if((get_property("questL11Business") == "finished") && (get_property("cc_hiddenoffice") != "finished"))
	{
		print("Found completed Hidden Office Building (11)");
		set_property("cc_hiddenoffice", "finished");
	}
	if((get_property("questL11Curses") == "finished") && (get_property("cc_hiddenapartment") != "finished"))
	{
		print("Found completed Hidden Apartment Building (11)");
		set_property("cc_hiddenapartment", "finished");
	}
	if((get_property("questL11Spare") == "finished") && (get_property("cc_hiddenbowling") != "finished"))
	{
		print("Found completed Hidden Bowling Alley (11)");
		set_property("cc_hiddenbowling", "finished");
	}
	if((get_property("questL11Doctor") == "finished") && (get_property("cc_hiddenhospital") != "finished"))
	{
		print("Found completed Hidden Hopickle (11)");
		set_property("cc_hiddenhospital", "finished");
	}
	if((get_property("questL11Worship") == "finished") && (get_property("cc_hiddencity") != "finished"))
	{
		print("Found completed Hidden City (11)");
		set_property("cc_hiddencity", "finished");
	}
	if((get_property("sidequestLighthouseCompleted") != "none") && (get_property("cc_sonata") != "finished"))
	{
		print("Found completed Lighthouse (12)");
		set_property("cc_sonata", "finished");
	}
	if((get_property("sidequestJunkyardCompleted") != "none") && (get_property("cc_gremlins") != "finished"))
	{
		print("Found completed Junkyard (12)");
		set_property("cc_gremlins", "finished");
	}
	if((get_property("sidequestOrchardCompleted") != "none") && (get_property("cc_orchard") != "finished"))
	{
		print("Found completed Orchard (12)");
		set_property("cc_orchard", "finished");
	}
	if((get_property("sidequestNunsCompleted") != "none") && (get_property("cc_nuns") != "done") && (get_property("cc_nuns") != "finished"))
	{
		print("Found completed Nuns (12)");
		set_property("cc_nuns", "finished");
	}
	if((get_property("sideDefeated") != "neither") && (get_property("cc_war") != "finished"))
	{
		print("Found completed Island War (12)");
		set_property("cc_war", "finished");
	}
	
	return false;
}

boolean L11_hiddenCityZones()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("cc_hiddenzones") == "finished")
	{
		return false;
	}

	if(get_property("cc_hiddenzones") == "")
	{
		print("Machete the hidden zones!", "blue");
		set_property("choiceAdventure781", "1");
		set_property("choiceAdventure785", "1");
		set_property("choiceAdventure783", "1");
		set_property("choiceAdventure787", "1");
		set_property("choiceAdventure789", "2");
		set_property("choiceAdventure791", "6");
		set_property("cc_hiddenzones", "0");
		if(possessEquipment($item[Antique Machete]))
		{
			set_property("cc_hiddenzones", "1");
		}
	}

	if(get_property("cc_hiddenzones") == "0")
	{
		if(possessEquipment($item[antique machete]))
		{
			set_property("cc_hiddenzones", "1");
		}
		else
		{
			if(contains_text(get_property("lastEncounter"), "Where Does The Lone Ranger Take His Garbagester"))
			{
				set_property("choiceAdventure789", "6");
			}
			ccAdv(1, $location[The Hidden Park]);
			return true;
		}
	}

	if(get_property("cc_hiddenzones") == "1")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
		if(contains_text(get_property("lastEncounter"), "Earthbound and Down"))
		{
			set_property("cc_hiddenzones", "2");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "2")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
		if(contains_text(get_property("lastEncounter"), "Air Apparent"))
		{
			set_property("cc_hiddenzones", "3");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "3")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
		if(contains_text(get_property("lastEncounter"), "Water You Dune"))
		{
			set_property("cc_hiddenzones", "4");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "4")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
		if(contains_text(get_property("lastEncounter"), "Fire When Ready"))
		{
			set_property("cc_hiddenzones", "5");
		}
		return true;
	}

	if(get_property("cc_hiddenzones") == "5")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[A Massive Ziggurat]);
		if(contains_text(get_property("lastEncounter"), "Temple of the Legend in the Hidden City"))
		{
			set_property("choiceAdventure791", "1");
			set_property("choiceAdventure781", "2");
			set_property("choiceAdventure785", "2");
			set_property("choiceAdventure783", "2");
			set_property("choiceAdventure787", "2");
			set_property("cc_hiddenzones", "finished");
		}
		return true;
	}
	return false;
}

void fortuneCookieEvent()
{
	if((get_property("cc_orchard") == "finished"))
	{
		return;
	}
	if(((get_property("cc_dickstab").to_boolean()) && (get_property("cc_semirare").to_int() == 2)))
	{
		return;
	}
	
	if(get_counters("Fortune Cookie", 0, 0) == "Fortune Cookie")
	{
		print("Semi rare time!", "blue");
		abort("Aborting for the time being because for some reason semi-rare handling is broken.");
		if((get_property("cc_semirare") == "") && (get_property("cc_spookysapling") == "finished"))
		{
			ccAdv(1, $location[The Hidden Temple]);
			if(item_amount($item[stone wool]) > 0)
			{
				set_property("cc_semirare", "1");
				set_property("cc_semisub", "wool");
				print("Wool obtained!", "blue");
			}
		}
		else if((get_property("cc_semirare") == "1") && (get_property("cc_castleground") == "finished") && (get_property("cc_nuns") != "done"))
		{
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
			if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
			{
				set_property("cc_castleground", "done");
				set_property("cc_semisub", "inhaler");
				set_property("cc_semirare", "2");
				print("Inhaler obtained!", "blue");
			}
		}
		else if(get_property("cc_semisub") != "limerick")
		{
//Tests for potions obtained from chateau desk so you don't use the semi if not needed
			if(item_amount($item[cyclops eyedrops]) > 0)
			{
				set_property("cc_semisub", "limerick");
				print("Already got eyedrops, trying something else.", "blue");
			}
			
			ccAdv(1, $location[The Limerick Dungeon]);
			if(item_amount($item[cyclops eyedrops]) > 0)
			{
				set_property("cc_semisub", "limerick");
				print("Eyedrops obtained!", "blue");
			}
		}
		else if(get_property("cc_semisub") != "pantry")
		{
			ccAdv(1, $location[The Haunted Pantry]);
			set_property("cc_semisub", "pantry");
		}
		else
		{
			ccAdv(1, $location[The Sleazy Back Alley]);
			set_property("cc_semisub", "alley");
		}
	}
}

boolean L11_unlockHiddenCity()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(my_adventures() <= 3)
	{
		return false;
	}
	if(get_property("cc_hiddenunlock") != "nose")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}

	print("Searching for the Hidden City", "blue");
	buffMaintain($effect[Stone-Faced], 0, 1, 1);
#	string page = visit_url("adventure.php?snarfblat=280");
#	if(contains_text(page, "Combat"))
#	{
#		print("Wandering monster interrupted our attempt at the Hidden City", "red");
#		ccAdv(1, $location[Noob Cave]);
#		return true;
#	}

	if(ccAdvBypass(280))
	{
		print("Wandering monster interrupted our attempt at the Hidden City", "red");
		return true;
	}
	visit_url("choice.php?whichchoice=582&option=2&pwd");
	visit_url("choice.php?whichchoice=580&option=2&pwd");
	visit_url("choice.php?whichchoice=584&option=4&pwd");
	visit_url("choice.php?whichchoice=580&option=1&pwd");
	visit_url("choice.php?whichchoice=123&option=2&pwd");
	visit_url("choice.php");
	cli_execute("dvorak");
	visit_url("choice.php?whichchoice=125&option=3&pwd");
	print("Hidden Temple Unlocked");
	set_property("cc_hiddenunlock", "finished");
	set_property("choiceAdventure582", "1");
	set_property("choiceAdventure579", "3");
	return true;
}


boolean L11_nostrilOfTheSerpent()
{
	if(get_property("cc_mcmuffin") == "")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(item_amount($item[The Nostril of the Serpent]) != 0)
	{
		return false;
	}
	if(get_property("cc_hiddenunlock") != "")
	{
		return false;
	}

	print("Must get a snake nose.", "blue");
	set_property("choiceAdventure582", "1");
	set_property("choiceAdventure579", "2");

	buffMaintain($effect[Stone-Faced], 0, 1, 1);
	if(have_effect($effect[Stone-Faced]) == 0)
	{
		abort("We are not Stone-Faced. Please get a stone wool and run me again.");
	}

	ccAdv(1, $location[The Hidden Temple]);
	cli_execute("refresh inv");
	if(item_amount($item[The Nostril of the Serpent]) == 1)
	{
		set_property("cc_hiddenunlock", "nose");
		set_property("choiceAdventure579", "3");
	}
	return true;
}

boolean LX_spookyBedroomCombat()
{
	set_property("cc_disableAdventureHandling", "yes");
	ccAdv(1, $location[The Haunted Bedroom]);
	set_property("cc_disableAdventureHandling", "no");
	return false;
}

boolean LX_spookyravenSecond()
{
	if((get_property("cc_spookyravensecond") != "") || (get_property("cc_spookyravennecklace") != "done"))
	{
		return false;
	}

	if((item_amount($item[Lady Spookyraven\'s Powder Puff]) == 1) && (item_amount($item[Lady Spookyraven\'s Dancing Shoes]) == 1) && (item_amount($item[Lady Spookyraven\'s Finest Gown]) == 1))
	{
		print("Finished Spookyraven, just dancing with the lady.", "blue");
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		set_property("cc_ballroomopen", "open");
		ccAdv(1, $location[The Haunted Ballroom]);
		if(contains_text(get_property("lastEncounter"), "Lights Out in the Ballroom"))
		{
			ccAdv(1, $location[The Haunted Ballroom]);
		}
		set_property("choiceAdventure106", "2");
		visit_url("place.php?whichplace=manor3&action=manor3_ladys");
		return true;
	}

	if(item_amount($item[Lord Spookyraven\'s Spectacles]) == 0)
	{
		set_property("choiceAdventure878", "3");
	}
	else if(item_amount($item[Disposable Instant Camera]) == 0)
	{
		set_property("choiceAdventure878", "4");
	}
	else
	{
		set_property("choiceAdventure878", "2");
	}
	set_property("choiceAdventure880", "1");
	set_property("choiceAdventure877", "1");
	set_property("choiceAdventure879", "1");
	set_property("choiceAdventure876", "2");

	if(get_property("cc_ballroomopen") == "open")
	{
		if(item_amount($item[Lord Spookyraven\'s Spectacles]) == 1)
		{
			set_property("cc_spookyravensecond", "finished");
		}
		else
		{
			print("Need Spectacles, damn it.", "blue");
			LX_spookyBedroomCombat();
			print("Finished 1 Spookyraven Bedroom Spectacle Sequence", "blue");
		}
		return true;
	}
	else
	{
		if((item_amount($item[Lady Spookyraven\'s Finest Gown]) == 0) && (get_counters("Fortune Cookie", 0, 10) != "Fortune Cookie"))
		{
			print("Spookyraven: Bedroom", "blue");
			LX_spookyBedroomCombat();
			print("Finished a Spookyraven Bedroom Sequence", "blue");
			return true;
		}
		if(item_amount($item[Lady Spookyraven\'s Dancing Shoes]) == 0)
		{
			set_property("louvreDesiredGoal", "7");
			print("Spookyraven: Gallery", "blue");
			ccAdv(1, $location[The Haunted Gallery]);
			return true;
		}
		if(item_amount($item[Lady Spookyraven\'s Powder Puff]) == 0)
		{
			print("Spookyraven: Bathroom", "blue");
			set_property("choiceAdventure892", "1");
			ccAdv(1, $location[The Haunted Bathroom]);
			return true;
		}
	}
	return false;
}

boolean L11_mauriceSpookyraven()
{
	if(get_property("cc_ballroomflat") == "finished")
	if(get_property("cc_spookyravennecklace") != "done")
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("cc_ballroom") != "")
	{
		return false;
	}
	if(my_level() < 11)
	{
		return false;
	}
	if(item_amount($item[7962]) == 0)
	{
		set_property("cc_ballroom", "finished");
		return true;
	}

	if(get_property("cc_ballroomflat") == "")
	{
		print("Searching for the basement of Spookyraven", "blue");
		set_property("choiceAdventure106", "2");
		set_property("choiceAdventure90", "3");
		
		if(!ccAdv(1, $location[The Haunted Ballroom]))
		{
			visit_url("place.php?whichplace=manor2");
			print("If 'That Area is not available', mafia isn't recognizing it without a visit to manor2, not sure why.", "red");
		}
		if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
		{
			set_property("cc_ballroomflat", "finished");
		}
		return true;
	}
	if(item_amount($item[recipe: mortar-dissolving solution]) == 0)
	{
		equip($slot[acc3], $item[Lord Spookyraven\'s Spectacles]);
		visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		use(1, $item[recipe: mortar-dissolving solution]);

		if(item_amount($item[Numberwang]) > 0)
		{
			equip($slot[acc3], $item[numberwang]);
		}

		#Cellar, laundry room Lights out ignore
		set_property("choiceAdventure901", "2");
		set_property("choiceAdventure891", "1");
	}

	if((item_amount($item[blasting soda]) == 1) && (item_amount($item[bottle of Chateau de Vinegar]) == 1))
	{
		print("Time to cook up something explosive! Science fair unstable fulminate time!", "green");
		craft("cook", 1, $item[bottle of Chateau de Vinegar], $item[blasting soda]);
		set_property("cc_winebomb", "partial");
	}

	if(possessEquipment($item[Unstable Fulminate]))
	{
		set_property("cc_winebomb", "partial");
	}

	if((item_amount($item[bottle of Chateau de Vinegar]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for vinegar", "blue");
		ccAdv(1, $location[The Haunted Wine Cellar]);
		return true;
	}
	if((item_amount($item[blasting soda]) == 0) && (get_property("cc_winebomb") == ""))
	{
		print("Searching for baking soda, I mean, blasting pop.", "blue");
		ccAdv(1, $location[The Haunted Laundry Room]);
		return true;
	}

	if(get_property("cc_winebomb") == "partial")
	{
		if(item_amount($item[unstable fulminate]) > 0)
		{
			if(weapon_hands(equipped_item($slot[weapon])) != 1)
			{
				equip($slot[weapon], $item[none]);
			}
			equip($item[unstable fulminate]);
		}
		print("Now we mix and heat it up.", "blue");
		ccAdv(1, $location[The Haunted Boiler Room]);

		if(item_amount($item[wine bomb]) == 1)
		{
			set_property("cc_winebomb", "finished");
			visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		}
		return true;
	}

	if(get_property("cc_winebomb") == "finished")
	{
		print("Down with the tyrant of Spookyraven!", "blue");
		visit_url("place.php?whichplace=manor4&action=manor4_chamberboss");
		return true;
	}
	return false;
}

boolean LX_dinseylandfillFunbucks()
{
	if(!elementalPlanes_access($element[stench]))
	{
		return false;
	}
	if(!get_property("cc_getDinseyGarbageMoney").to_boolean())
	{
		return false;
	}
	if(get_property("cc_dinseyGarbageMoney").to_int() == my_daycount())
	{
		return false;
	}
	if((my_adventures() == 0) || (my_level() < 5))
	{
		return false;
	}
	if(item_amount($item[Bag of Park Garbage]) > 0)
	{
		return dinseylandfill_garbageMoney();
	}
	if((my_daycount() >= 3) && (my_adventures() > 40))
	{
		# We do this after the item check since we may have an extra bag and we should turn that in.
		return false;
	}
	ccAdv(1, $location[Barf Mountain]);
	return true;
}

boolean L12_sonofaFinish()
{
	if(get_property("cc_sonata") == "finished")
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) < 5)
	{
		return false;
	}
	if(get_property("cc_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 64))
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	set_property("cc_sonata", "finished");
	return true;
}

boolean L12_gremlinStart()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_gremlins") != "")
	{
		return false;
	}
	print("Gremlin prep", "blue");
	set_property("cc_gremlins", "start");
	return true;
}

boolean L12_gremlins()
{
	if(get_property("cc_gremlins") != "start")
	{
		return false;
	}
	if(get_property("sidequestJunkyardCompleted") != "none")
	{
		return false;
	}
	if(get_property("cc_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 192))
	{
		return false;
	}
	if(get_property("warProgress") == "finished")
	{
		return false;
	}

	#Put a different shield in here.
	print("Doing them gremlins", "blue");
	
	if(item_amount($item[molybdenum hammer]) == 0)
	{
		ccAdv(1, $location[Next to that barrel with something burning in it], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum screwdriver]) == 0)
	{
		ccAdv(1, $location[Out by that rusted-out car], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum crescent wrench]) == 0)
	{
		ccAdv(1, $location[over where the old tires are], "ccsJunkyard");
		return true;
	}

	if(item_amount($item[molybdenum pliers]) == 0)
	{
		ccAdv(1, $location[near an abandoned refrigerator], "ccsJunkyard");
		return true;
	}
	warOutfit();
	visit_url("bigisland.php?action=junkman&pwd");
	set_property("cc_gremlins", "finished");
	return true;
}


boolean L12_sonofaBeach()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_sonata") == "finished")
	{
		return false;
	}
	if(!get_property("cc_hippyInstead").to_boolean())
	{
		if(get_property("cc_gremlins") != "finished")
		{
			return false;
		}
	}
	else if(get_property("fratboysDefeated").to_int() < 64)
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) >= 5)
	{
		return false;
	}
	if(get_property("sidequestLighthouseCompleted") != "none")
	{
		set_property("cc_sonata", "finished");
		return true;
	}

	if((my_class() == $class[Ed]) && (item_amount($item[Talisman of Horus]) == 0))
	{
		return false;
	}

	if(!uneffect($effect[Shelter of Shed]))
	{
		print("Can not uneffect Shelter of Shed for the Lobsterfrogman, delaying");
		return false;
	}

	if(equipped_item($slot[hat]) == $item[Xiblaxian stealth cowl])
	{
		equip($item[Beer Helmet]);
	}

	if(item_amount($item[barrel of gunpowder]) < 4)
	{
		set_property("cc_doCombatCopy", "yes");
	}

	ccAdv(1, $location[Sonofa Beach]);
	set_property("cc_doCombatCopy", "no");

	if((my_class() == $class[Ed]) && (my_hp() == 0))
	{
		use(1, $item[Linen Bandages]);
	}
	return true;
}

boolean L12_filthworms()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_orchard") != "start")
	{
		return false;
	}
	print("Doing the orchard.", "blue");

	if(item_amount($item[Filthworm Hatchling Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Hatchling Scent Gland]);
	}
	if(item_amount($item[Filthworm Drone Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Drone Scent Gland]);
	}
	if(item_amount($item[Filthworm Royal Guard Scent Gland]) > 0)
	{
		use(1, $item[Filthworm Royal Guard Scent Gland]);
	}

	if(have_effect($effect[Filthworm Guard Stench]) > 0)
	{
		ccAdv(1, $location[The Filthworm Queen\'s Chamber]);
		if(item_amount($item[Heart of the Filthworm Queen]) > 0)
		{
			set_property("cc_orchard", "done");
		}
		return true;
	}

	if(!have_skill($skill[Lash of the Cobra]))
	{
		buffMaintain($effect[One Very Clear Eye], 0, 1, 1);
	}

	if(have_effect($effect[Filthworm Drone Stench]) > 0)
	{
		ccAdv(1, $location[The Royal Guard Chamber]);
		return true;
	}
	if(have_effect($effect[Filthworm Larva Stench]) > 0)
	{
		ccAdv(1, $location[The Feeding Chamber]);
		return true;
	}
	ccAdv(1, $location[The Hatching Chamber]);
	return true;
}

boolean L12_orchardStart()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("cc_orchard") != "")
	{
		return false;
	}
	if((get_property("hippiesDefeated").to_int() < 64) && !get_property("cc_hippyInstead").to_boolean())
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	set_property("cc_orchard", "start");
	return true;
}

boolean L12_orchardFinalize()
{
	if(get_property("cc_orchard") != "done")
	{
		return false;
	}
	set_property("cc_orchard", "finished");

	warOutfit();
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	return true;
}

boolean L10_topFloor()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castletop") != "")
	{
		return false;
	}

	print("Castle Top Floor", "blue");
	maximize("exp, -combat", 0, 0, false);
	set_property("choiceAdventure675", 3);
	if((item_amount($item[drum 'n' bass 'n' drum 'n' bass record]) > 0))
	{
		set_property("choiceAdventure675", 2);
	}
	set_property("choiceAdventure676", 3);
	set_property("choiceAdventure678", 4);
	if((item_amount($item[Mohawk Wig]) > 0))
	{
		equip($item[mohawk wig]);
		set_property("choiceAdventure676", 4);
		set_property("choiceAdventure678", 1);
	}
	set_property("choiceAdventure677", 1);
	set_property("choiceAdventure679", 2);
	
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);

	if(contains_text(get_property("lastEncounter"), "Keep On Turnin\' the Wheel in the Sky"))
	{
		set_property("cc_castletop", "finished");
		council();
	}
	if(contains_text(get_property("lastEncounter"), "Copper Feel"))
	{
		set_property("cc_castletop", "finished");
		council();
	}
	return true;
}

boolean L10_ground()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castleground") != "")
	{
		return false;
	}
	print("Castle Ground Floor, boring!", "blue");
	set_property("choiceAdventure672", 3);
	set_property("choiceAdventure673", 1);
	set_property("choiceAdventure674", 3);
	set_property("choiceAdventure1026", 3);
	maximize("exp, -combat", 0, 0, false);
	if((item_amount($item[very overdue library book]) > 0))
	{
		maximize("exp", 0, 0, false);
	}
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Ground Floor)]);

	if(contains_text(get_property("lastEncounter"), "Top of the Castle, Ma"))
	{
		set_property("cc_castleground", "finished");
		if((item_amount($item[very overdue library book]) > 0))
		{
			use(1, $item[very overdue library book]);
		}
	}
	
	return true;
}

boolean L10_basement()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(get_property("cc_castlebasement") != "")
	{
		return false;
	}

	print("Basement Search", "blue");
	maximize("exp, -combat", 0, 0, false);
	set_property("choiceAdventure669", "1");
	if(item_amount($item[titanium assault umbrella]) == 1)
	{
		set_property("choiceAdventure669", "4");
	}
	set_property("choiceAdventure670", "5");
	set_property("choiceAdventure671", "4");

	buyUpTo(1, $item[Ben-Gal&trade; Balm]);
	buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	buyUpTo(1, $item[Hair Spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

	ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);

	if((contains_text(get_property("lastEncounter"), "The Fast and the Furry-ous")) && (item_amount($item[titanium assault umbrella]) > 0))
	{
		print("We was fast and furry-ous!", "blue");
		equip($item[titanium assault umbrella]);
		set_property("choiceAdventure669", "1");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		set_property("cc_castlebasement", "finished");
	}
	else if(contains_text(get_property("lastEncounter"), "You Don\'t Mess Around with Gym"))
	{
		print("Just messed with Gym", "blue");
		set_property("choiceAdventure670", "5");
		if(item_amount($item[amulet of extreme plot significance]) == 0)
		{
			if(!possessEquipment($item[Amulet of Extreme Plot Significance]))
			{
				print("Backfarming an Amulet of Extreme Plot Significance, sigh :(", "blue");
				maximize("exp, +combat, item drop", 0, 0, false);
				ccAdv(1, $location[The Penultimate Fantasy Airship]);
				return true;
			}
		}
		equip($slot[acc3], $item[amulet of extreme plot significance]);
		set_property("choiceAdventure670", "4");
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		set_property("cc_castlebasement", "finished");
	}
	
	return true;
}

boolean L10_airship()
{
	if(my_level() < 10)
	{
		return false;
	}
	if(item_amount($item[S.O.C.K.]) == 1)
	{
		set_property("cc_airship", "finished");
	}
	if(get_property("cc_airship") != "")
	{
		return false;
	}

	print("Fantasy Airship Fly Fly time", "blue");

	if(item_amount($item[model airship]) == 0)
	{
		set_property("choiceAdventure182", "4");
	}
	else
	{
		set_property("choiceAdventure182", "1");
	}
	
	visit_url("place.php?whichplace=beanstalk");
	maximize("exp", 0, 0, false);
	if(("The Penultimate Fantasy Airship".to_location().turns_spent >= 10))
	{
		maximize("exp, -combat", 0, 0, false);
	}
	ccAdv(1, $location[The Penultimate Fantasy Airship]);
	return true;
}

boolean L7_crypt()
{
	if((my_level() < 7) || (get_property("cc_crypt") != ""))
	{
		return false;
	}
	if(item_amount($item[chest of the bonerdagon]) == 1)
	{
		set_property("cc_crypt", "finished");
		use(1, $item[chest of the bonerdagon]);
		return false;
	}
	
	oldPeoplePlantStuff();
	buffMaintain($effect[Browbeaten], 0, 1, 1);
	buffMaintain($effect[Rosewater Mark], 0, 1, 1);
	if((get_property("cyrptAlcoveEvilness").to_int() > 0) && have_skill($skill[More Legs]) && ((my_maxhp() > 50) || (elemental_resist($element[spooky]) > 3)))
	{
		print("The Alcove! (" + initiative_modifier() + ") init.", "blue");
		maximize("initiative, 0.25 exp, -combat", 0, 0, false);
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buyUpTo(1, $item[Hair Spray]);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buffMaintain($effect[Well-Swabbed Ear], 0, 1, 1);
		buffMaintain($effect[Sepia Tan], 0, 1, 1);
		ccAdv(1, $location[The Defiled Alcove]);
		return true;
	}

	if(get_property("cyrptNookEvilness").to_int() > 0)
	{
		print("The Nook!", "blue");
		ccAdv(1, $location[The Defiled Nook]);
		if(item_amount($item[evil eye]) > 0)
		{
			use(1, $item[evil eye]);
		}
		return true;
	}

	if(get_property("cyrptNicheEvilness").to_int() > 0)
	{
		print("The Niche!", "blue");
		ccAdv(1, $location[The Defiled Niche]);

		return true;
	}

	if(get_property("cyrptCrannyEvilness").to_int() > 0)
	{
		print("The Cranny!", "blue");
		set_property("choiceAdventure523", "4");
		ccAdv(1, $location[The Defiled Cranny]);
		
		return true;
	}

	if(get_property("cyrptTotalEvilness").to_int() <= 0)
	{
		if(my_primestat() == $stat[Muscle])
		{
			buyUpTo(1, $item[Ben-Gal&trade; Balm]);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		}

		boolean tryBoner = ccAdv(1, $location[Haert of the Cyrpt]);
		if(item_amount($item[chest of the bonerdagon]) == 1)
		{
			set_property("cc_crypt", "finished");
			use(1, $item[chest of the bonerdagon]);
		}
		else if(!tryBoner)
		{
			print("We tried to kill the Bonerdagon because the cyrpt was defiled but couldn't adventure there and the chest of the bonerdagon is gone so we can't check that. Anyway, we are going to assume the cyrpt is done now.", "red");
			set_property("cc_crypt", "finished");
		}
		else
		{
			abort("Failed to kill bonerdagon");
		}
		return true;
	}
	return false;
}

boolean L1_LegDay()
{
	if(!LX_islandAccess() || item_amount($item[Dingy Dinghy]) > 0)
	{
	} else
	{
		abort("You don't have a Dinghy you ding-head!");
	}
	if(!have_skill($skill[Upgraded Legs]))
	{
		set_property("cc_legsbeforebread", "true");
	}
//This should allow us  to pick up the semi-rare in the Outskirts for some low level food/drink
	if(get_counters("Semirare window end", 0, 10) == "Semirare window end")
	{
		if(L5_getEncryptionKey())
		{
			return true;
		}
	}
	
	if(item_amount($item[Ka Coin]) < 10 && !have_skill($skill[Upgraded Legs]) && !L5_getEncryptionKey())
	{
		if(jump_chance($monster[Rushing Bum]) < 70 && my_maxhp() < 30)
		{
			change_mcd(3);
		}
		
		print("Getting extra ka.", "blue");
		ccAdv(1, $location[the sleazy back alley]);
		return true;
	}

	if(have_skill($skill[Upgraded Legs]))
	{
		if(my_basestat($stat[moxie]) < 24)
		{
			print("Doing leg-day.", "blue");
			maximize("exp, -equip filthy knitted dread sack", 0, 0, false);
			if(!have_skill($skill[More Legs]) && !possessEquipment($item[The Crown of Ed the Undying]))
			{
				change_mcd(0);
				buffMaintain($effect[Wisdom of Thoth], 15, 1, 10);
				buffMaintain($effect[Power of Heka], 15, 1, 10);
				buffMaintain($effect[Bounty of Renenutet], 35, 1, 10);
				ccAdv(1, $location[Hippy Camp]);
				return true;
			} else
			{
				change_mcd(10);
				buffMaintain($effect[Wisdom of Thoth], 15, 1, 10);
				buffMaintain($effect[Power of Heka], 15, 1, 10);
				buffMaintain($effect[Bounty of Renenutet], 35, 1, 10);
				buffMaintain($effect[Blessing of Serqet], 25, 1, 10);
				ccAdv(1, $location[Hippy Camp]);
				return true;
			}
		}
	}
	
	return false;
}

boolean L1_edIsland()
{
	return L1_edIsland(0);
}

boolean L1_edDinsey()
{
	if(!elementalPlanes_access($element[stench]))
	{
		return false;
	}
	if(my_level() > 6)
	{
		return false;
	}
	if(!get_property("cc_dickstab").to_boolean())
	{
		return false;
	}
	if(possessEquipment($item[Sewage-Clogged Pistol]) && possessEquipment($item[Perfume-Soaked Bandana]))
	{
		return false;
	}
	ccAdv(1, $location[Pirates of the Garbage Barges]);
	return true;
}

boolean L1_edIsland(int dickstabOverride)
{
	if(!get_property("spookyAirportAlways").to_boolean())
	{
		return false;
	}
	
	skill blocker = $skill[Still Another Extra Spleen];
	if(get_property("cc_dickstab").to_boolean())
	{
		if(turns_played() > 22)
		{
			blocker = $skill[Replacement Liver];
			if((dickstabOverride == 0) || (my_level() >= dickstabOverride))
			{
				return false;
			}
		}
	}

	if((my_level() >= 10) || ((my_level() >= 8) && have_skill(blocker)))
	{
		return false;
	}
	
	if(possessEquipment($item[The Crown of Ed the Undying])) 
	{
		adjustEdHat("ml");
	}

	if((my_level() >= 3) && !get_property("controlPanel9").to_boolean())
	{
		visit_url("place.php?whichplace=airport_spooky_bunker&action=si_controlpanel");
		visit_url("choice.php?pwd=&whichchoice=986&option=9",true);
	}
	
	if((my_level() >= 3) && !get_property("controlPanel9").to_boolean())
	{
		abort("Damn control panel is not set, WTF!!!");
	}

	#If we get some other CI quest, this might keep triggering, should we flag this?
	if((my_hp() > 20) && !possessEquipment($item[Gore Bucket]) && !possessEquipment($item[Encrypted Micro-Cassette Recorder]) && !possessEquipment($item[Military-Grade Fingernail Clippers]))
	{
		elementalPlanes_takeJob($element[spooky]);
		#visit_url("place.php?whichplace=airport_spooky&action=airport2_radio");
		#visit_url("choice.php?pwd&whichchoice=984&option=1", true);
		set_property("choiceAdventure988", 2);
	}

	if(item_amount($item[Gore Bucket]) > 0)
	{
		equip($item[Gore Bucket]);
	}

	if(item_amount($item[Personal Ventilation Unit]) > 0)
	{
		equip($slot[acc2], $item[Personal Ventilation Unit]);
	}
	if(possessEquipment($item[Gore Bucket]) && (get_property("goreCollected").to_int() >= 100))
	{
		visit_url("place.php?whichplace=airport_spooky&action=airport2_radio");
		visit_url("choice.php?pwd&whichchoice=984&option=1", true);
	}

	buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
	ccAdv(1, $location[The Secret Government Laboratory]);
	if(item_amount($item[Bottle-Opener Keycard]) > 0)
	{
		use(1, $item[Bottle-Opener Keycard]);
	}
	set_property("choiceAdventure988", 1);
	return true;
}

boolean L1_edIslandFallback()
{
	if(elementalPlanes_access($element[spooky]))
	{
		return false;
	}
	if((my_level() >= 10) || ((my_level() >= 7) && have_skill($skill[Still Another Extra Spleen])))
	{
		return false;
	}
	if(elementalPlanes_access($element[stench]))
	{
		ccAdv(1, $location[Pirates of the Garbage Barges]);
		return true;
	}
	if(L1_LegDay())
	{
		return true;
	}
	return false;
}

boolean L6_friarsGetParts()
{
	if((my_level() < 6) || (get_property("cc_friars") != ""))

	{
		return false;
	}

	if(item_amount($item[box of birthday candles]) == 0)
	{
		print("Getting Box of Birthday Candles", "blue");
		ccAdv(1, $location[The Dark Heart of the Woods]);
		return true;
	}

	if(item_amount($item[dodecagram]) == 0)
	{
		print("Getting Dodecagram", "blue");
		ccAdv(1, $location[The Dark Neck of the Woods]);
		return true;
	}
	if(item_amount($item[eldritch butterknife]) == 0)
	{
		print("Getting Eldritch Butterknife", "blue");
		ccAdv(1, $location[The Dark Elbow of the Woods]);
		return true;
	}
	print("Finishing friars", "blue");
	visit_url("friars.php?action=ritual&pwd");
	council();
	set_property("cc_friars", "done");
	return true;
}

boolean L6_friarsHotWing()
{
	if(get_property("cc_friars") != "done")
	{
		return false;
	}
	
	if((get_property("cc_pirateoutfit") == "almost") || (get_property("cc_pirateoutfit") == "finished") )
	{
		if(get_property("cc_friars") == "done")
		{
			set_property("cc_friars", "finished");
		}
		return false;
	}

	if(item_amount($item[hot wing]) >= 3)
	{
		set_property("cc_friars", "finished");
		return true;
	}

	print("Need more Hot Wings", "blue");
	ccAdv(1, $location[The Dark Heart of the Woods]);
	return true;
}

boolean L8_trapperGround()
{
	if(get_property("cc_trapper") != "start")
	{
		return false;
	}
	if(item_amount($item[Disassembled Clover]) == 0)
	{
		return false;
	}

	#print("Starting Trapper Collection", "blue");
	item oreGoal = to_item(get_property("trapperOre"));
	if((item_amount(oreGoal) >= 3) && (item_amount($item[goat cheese]) >= 3))
	{
		print("Giving Trapper goat cheese and " + oreGoal, "blue");
		set_property("cc_trapper", "yeti");
		visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
		return true;
	}

	if(item_amount($item[goat cheese]) < 3)
	{
		print("Yay for goat cheese!", "blue");
		ccAdv(1, $location[The Goatlet]);
		return true;
	}
	if(item_amount(oreGoal) < 3)
	{
		use(1, $item[Disassembled Clover]);
		if(ccAdvBypass(270, $location[Itznotyerzitz Mine]))
		{
			print("Wandering monster interrupt at Itznotyerzitz Mine", "red");
			return true;
		}

		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		return true;
	}
	
	return true;
}

boolean L8_trapperStart()
{
	if((my_level() < 8) || (get_property("cc_trapper") != ""))
	{
		return false;
	}
	council();
	print("Let's meet the trapper.", "blue");

	visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
	set_property("cc_trapper", "start");
	return true;
}

boolean L5_goblinKing()
{
	if(get_property("cc_goblinking") == "finished")
	{
		return false;
	}
	if(my_level() < 8)
	{
		return false;
	}
	if(my_adventures() <= 2)
	{
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 3) == "Fortune Cookie")
	{
		return false;
	}
	if(!possessEquipment($item[Knob Goblin Harem Veil]) || !possessEquipment($item[Knob Goblin Harem Pants]))
	{
		return false;
	}

	print("Death to the gobbo!! If you want a specific drop, please reset your MCD now.", "blue");
	wait(15);
	cli_execute("outfit knob goblin harem girl disguise");
	buffMaintain($effect[Knob Goblin Perfume], 0, 1, 1);
	if(my_hp() > 5 && have_effect($effect[Knob Goblin Perfume]) == 0)
	{
		ccAdv(1, $location[Cobb\'s Knob Harem]);
		if(contains_text(get_property("lastEncounter"), "Cobb's Knob lab key"))
		{
			ccAdv(1, $location[Cobb\'s Knob Harem]);
		}
		return true;
	} else if(my_hp() < 6 && have_effect($effect[Knob Goblin Perfume]) == 0)
	{
		if(item_amount($item[linen bandages]) > 0)
		{
			use(1, $item[linen bandages]);
			ccAdv(1, $location[Cobb\'s Knob Harem]);
			if(contains_text(get_property("lastEncounter"), "Cobb's Knob lab key"))
			{
				ccAdv(1, $location[Cobb\'s Knob Harem]);
			}
		} else
		{
			abort("Your HP is too low to get some perfume without being beaten up and you have no restoratives, restore some HP somehow before continuing.");
		}
	}

	buyUpTo(1, $item[Ben-Gal&trade; Balm]);
	buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	buyUpTo(1, $item[Hair Spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);

	if(monster_level_adjustment() > 150)
	{
		equip($slot[acc2], $item[none]);
	}

	ccAdv(1, $location[Throne Room]);
	if((item_amount($item[Crown of the Goblin King]) > 0) || (item_amount($item[Glass Balls of the Goblin King]) > 0) || (item_amount($item[Codpiece of the Goblin King]) > 0))
	{
		set_property("cc_goblinking", "finished");
		council();
	}
	return true;
}

boolean L4_batCave()
{
	if(get_property("cc_bat") == "finished")
	{
		return false;
	}

	print("In the bat hole!", "blue");

	if(item_amount($item[sonar-in-a-biscuit]) > 0)
	{
		use(item_amount($item[sonar-in-a-biscuit]), $item[sonar-in-a-biscuit]);
		return true;
	}
	
	string batHole = visit_url("place.php?whichplace=bathole");

	if(contains_text(batHole, "bathole_bg4"))
	{
		ccAdv(1, $location[The Boss Bat\'s Lair]);
		if(contains_text(get_property("lastEncounter"), "Boss Bat?"))
		{
			council();
			set_property("cc_bat", "finished");
		}
		return true;
	}
	
	if(contains_text(batHole, "bathole_bg3"))
	{
		ccAdv(1, $location[The Beanbat Chamber]);
		return true;
	}
	
	if(contains_text(batHole, "bathole_bg2"))
	{
		ccAdv(1, $location[The Batrat and Ratbat Burrow]);
		return true;
	}

	buffMaintain($effect[Hide of Sobek], 10, 1, 1);

	if((item_amount($item[Disassembled Clover]) > 0))
	{
		use(1, $item[Disassembled Clover]);
		if(ccAdvBypass(31, $location[Guano Junction]))
		{
			print("Wandering monster interrupt at Guano Junction", "red");
			return true;
		}

		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
#		string page = visit_url("adventure.php?snarfblat=31&confirm=on");
#		if(contains_text(page, "Combat"))
#		{
#			print("Wandering monster interrupt at Guano Junction", "red");
#			ccAdv(1, $location[Guano Junction]);
#		}
#		else
#		{
#			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
#		}
		return true;
	}

	ccAdv(1, $location[Guano Junction]);
	return true;
}

boolean LX_islandAccess()
{
	if((item_amount($item[Shore Inc. Ship Trip Scrip]) >= 3) && (item_amount($item[Dingy Dinghy]) == 0) && (my_meat() >= 400))
	{
		cli_execute("make dinghy plans");
		buyUpTo(1, $item[dingy planks]);
		use(1, $item[dinghy plans]);
		return true;
	}
	if(item_amount($item[Dingy Dinghy]) > 0)
	{
		return false;
	}
	if((my_adventures() <= 9) || (my_meat() <= 1900))
	{
		abort("You're a little short on time or cash to do this, come back once you've fixed this?");
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
	{
		//Just check the Fortune Cookie counter not any others.
		return false;
	}

	print("At the shore, la de da!", "blue");
	set_property("choiceAdventure793", "2");
	while((item_amount($item[Shore Inc. Ship Trip Scrip]) < 3) && (my_meat() > 500))
	{
		set_property("cc_disableAdventureHandling", "yes");
		ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
		set_property("cc_disableAdventureHandling", "no");
	}
	if(item_amount($item[Shore Inc. Ship Trip Scrip]) < 3)
	{
		print("Failed to get enough Shore Scrip for some reason, continuing...", "red");
		return false;
	}
	cli_execute("make dinghy plans");
	buyUpTo(1, $item[dingy planks]);
	use(1, $item[dinghy plans]);
	return true;
}

boolean L2_treeCoin()
{
	if(get_property("cc_treecoin") == "finished")
	{
		return false;
	}
	print("Time for a tree-holed coin", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "2");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[tree-holed coin]) == 1)
	{
		set_property("cc_treecoin", "finished");
	}
	return true;
}

boolean L2_spookyMap()
{
	if(get_property("cc_spookymap") == "finished")
	{
		return false;
	}
	print("Need a spooky map now", "blue");
	set_property("choiceAdventure502", "3");
	set_property("choiceAdventure506", "3");
	set_property("choiceAdventure507", "1");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[spooky temple map]) == 1)
	{
		set_property("cc_spookymap", "finished");
	}
	return true;
}

boolean L2_spookyFertilizer()
{
	if(get_property("cc_spookyfertilizer") == "finished")
	{
		return false;
	}
	print("Need a some poop, I mean fertilizer now", "blue");
	set_property("choiceAdventure502", "3");
	set_property("choiceAdventure506", "2");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[Spooky-Gro Fertilizer]) == 1)
	{
		set_property("cc_spookyfertilizer", "finished");
	}
	return true;
}

boolean L2_spookySapling()
{
	if(get_property("cc_spookysapling") == "finished")
	{
		return false;
	}
	if(my_meat() < 100)
	{
		return false;
	}
	print("And a spooky sapling!", "blue");
	set_property("choiceAdventure502", "1");
	set_property("choiceAdventure503", "3");
	set_property("choiceAdventure504", "3");

#	cli_execute("aa none");
	if(contains_text(visit_url("adventure.php?snarfblat=15"), "Combat"))
	{
		ccAdv(1, $location[The Spooky Forest]);
	}
	else
	{
		if(contains_text(get_property("lastEncounter"), "Hoom Hah"))
		{
			return true;
		}
		if(contains_text(get_property("lastEncounter"), "Blaaargh! Blaaargh!"))
		{
			print("Ewww, fake blood semirare. Worst. Day. Ever.", "red");
			return true;
		}
		visit_url("choice.php?whichchoice=502&option=1&pwd");
		visit_url("choice.php?whichchoice=503&option=3&pwd");
		if(item_amount($item[bar skin]) > 0)
		{
			visit_url("choice.php?whichchoice=504&option=2&pwd");
		}
		visit_url("choice.php?whichchoice=504&option=3&pwd");
		visit_url("choice.php?whichchoice=504&option=4&pwd");
		if(item_amount($item[Spooky Sapling]) > 0)
		{
			set_property("cc_spookysapling", "finished");
			use(1, $item[Spooky Temple Map]);
		}
		else
		{
			abort("Supposedly bought a spooky sapling, but failed :(");
		}
	}
	return true;
}

boolean L2_mosquito()
{
	if(get_property("cc_mosquito") == "finished")
	{
		return false;
	}

	print("Trying to find a mosquito.", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "1");
	ccAdv(1, $location[The Spooky Forest]);

	if(item_amount($item[mosquito larva]) > 0)
	{
		council();
		visit_url("tavern.php?place=barkeep");
		set_property("cc_mosquito", "finished");
	}
	return true;
}

boolean LX_handleSpookyravenFirstFloor()
{
	if(get_property("cc_spookyravennecklace") == "done")
	{
		return false;
	}
	if(possessEquipment($item[Ghost of a Necklace]))
	{
		set_property("cc_spookyravennecklace", "done");
		return false;
	}
	if(!have_skill($skill[Even More Elemental Wards]) && get_property("cc_edDelayHauntedKitchen").to_boolean())
	{
		print("Delaying kitchen till you got some more resistance", "blue");
		return false;
	}
	if(get_property("writingDesksDefeated").to_int() >= 5)
	{
		abort("Mafia reports 5 or more writing desks defeated yet we are still looking for them? Give Lady Spookyraven her necklace?");
	}
	if(item_amount($item[Lady Spookyraven\'s Necklace]) > 0)
	{
		abort("Have Lady Spookyraven's Necklace but did not give it to her....");
	}

	if(item_amount($item[Spookyraven Library Key]) == 1)
	{
			print("Well, we need writing desks", "blue");
			print("Going to the liberry!", "blue");
#			cli_execute("olfact writing desk");
			set_property("choiceAdventure888", "4");
			set_property("choiceAdventure889", "4");
			set_property("choiceAdventure163", "4");
			ccAdv(1, $location[The Haunted Library]);
	}
	else if(item_amount($item[Spookyraven Billiards room key]) == 1)
	{
		if((my_inebriety() <= 2))
		{
			print("Not quite boozed up for the billiards room... we'll be back.", "green");
			return false;
		}
		set_property("choiceAdventure875" , "1");
		buffMaintain($effect[Chalky Hand], 0, 1, 1);
		if(item_amount($item[7964]) > 0)
		{
			equip($item[7964]);
		}
		if(item_amount($item[2268]) > 0)
		{
			equip($item[2268]);
		}
		print("It's billiards time!", "blue");
		ccAdv(1, $location[The Haunted Billiards Room]);
	}
	else
	{
		print("Looking for the Billards Room key: Progress " + get_property("manorDrawerCount") + "/24", "blue");
		if(get_property("manorDrawerCount").to_int() >= 24)
		{
			cli_execute("refresh inv");
			if(item_amount($item[Spookyraven Billiards Room Key]) == 0)
			{
				print("We think you've opened enough drawers in the kitchen but you don't have the Billiards Room Key.");
				wait(10);
			}
		}
		buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		ccAdv(1, $location[The Haunted Kitchen]);
	}
	return true;
}

boolean L5_getEncryptionKey()
{
	if(get_property("cc_day1_cobb") == "finished")
	{
		return false;
	}
	if((jump_chance($monster[Knob Goblin Barbecue Team]) < 60 && my_maxhp() < 30))
	{
		change_mcd(3);
	}
	print("Looking for the knob.", "blue");
	ccAdv(1, $location[the outskirts of cobb\'s knob]);

	if(item_amount($item[Knob Goblin Encryption Key]) == 1)
	{
		set_property("cc_day1_cobb", "finished");
		council();
		change_mcd(10);
	}
	return true;
}

boolean LX_handleSpookyravenNecklace()
{
	if((get_property("cc_spookyravennecklace") == "done") || (item_amount($item[Lady Spookyraven\'s Necklace]) == 0))
	{
		return false;
	}
	if(possessEquipment($item[Ghost Of A Necklace]))
	{
		set_property("cc_spookyravennecklace", "done");
		return false;
	}

	print("Starting Spookyraven Second Floor.", "blue");
	visit_url("place.php?whichplace=manor1&action=manor1_ladys");
	visit_url("main.php");
	visit_url("place.php?whichplace=manor2&action=manor2_ladys");

	set_property("choiceAdventure876", "2");
	set_property("choiceAdventure877", "1");
	set_property("choiceAdventure878", "3");
	set_property("choiceAdventure879", "1");
	set_property("choiceAdventure880", "1");

	#handle lights-out, too bad we can't at least start Stephen Spookyraven here.
	set_property("choiceAdventure897", "2");
	set_property("choiceAdventure896", "1");
	set_property("choiceAdventure892", "2");

	if(item_amount($item[ghost of a necklace]) > 0)
	{
		set_property("cc_spookyravennecklace", "done");
	}
	else if((item_amount($item[ghost of a necklace]) == 0) || (item_amount($item[Lady Spookyraven\'s Necklace]) == 1))
	{
		cli_execute("refresh inv");
		set_property("cc_spookyravennecklace", "done");
		#abort("Mafia still doesn't understand the ghost of a necklace, just re-run me.");
	}
	return true;
}

boolean L12_startWar()
{
	if(get_property("cc_prewar") != "")
	{
		return false;
	}
	if(get_property("warProgress") == "finished")
	{
		return false;
	}

	print("Must save the ferret!!", "blue");
	outfit("frat warrior fatigues");

	ccAdv(1, $location[Wartime Hippy Camp]);
	if(contains_text(get_property("lastEncounter"), "Blockin\' Out the Scenery"))
	{
		set_property("cc_prewar", "started");
		visit_url("bigisland.php?action=junkman&pwd");
		if(!get_property("cc_hippyInstead").to_boolean())
		{
			visit_url("bigisland.php?place=concert&pwd");
			visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
			visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
			set_property("cc_gunpowder", "done");
		}
	}
	return true;
}

boolean L12_getOutfit()
{
	if(get_property("cc_prehippy") == "done")
	{
		return false;
	}

	set_property("choiceAdventure143", "3");
	set_property("choiceAdventure144", "3");
	set_property("choiceAdventure145", "1");
	set_property("choiceAdventure146", "1");

	if(possessEquipment($item[beer helmet]) && possessEquipment($item[bejeweled pledge pin]) && possessEquipment($item[distressed denim pants]))
	{
		set_property("choiceAdventure139", "3");
		set_property("choiceAdventure140", "3");
		set_property("cc_prehippy", "done");
		visit_url("clan_viplounge.php?preaction=goswimming&subaction=submarine");
		return true;
	}

	if(get_property("cc_prehippy") == "firstOutfit")
	{
		outfit("filthy hippy disguise");
		if(my_lightning() >= 5)
		{
			ccAdv(1, $location[Wartime Frat House]);
			return true;
		}

		if(in_hardcore())
		{
			ccAdv(1, $location[Wartime Frat House]);
			return true;
		}

		return false;
	}
	else
	{
		if(L12_preOutfit())
		{
			return true;
		}
	}
	return false;
}

boolean L12_preOutfit()
{
	if(item_amount($item[Dingy Dinghy]) == 0)
	{
		return false;
	}
	if(!in_hardcore())
	{
		return false;
	}
	if(my_level() < 9)
	{
		return false;
	}
	if(get_property("cc_prehippy") != "")
	{
		return false;
	}
	if(possessEquipment($item[Filthy Knitted Dread Sack]) && possessEquipment($item[Filthy Corduroys]))
	{
		set_property("cc_prehippy", "firstOutfit");
		return true;
	}
	if((my_class() == $class[Ed]) && have_skill($skill[Wrath of Ra]))
	{
		if(have_effect($effect[Everything Looks Yellow]) != 0)
		{
			return false;
		}
		if(my_mp() < 40)
		{
			return false;
		}
	}
	print("Trying to acquire a filthy hippy outfit", "blue");
	if(my_level() < 12)
	{
		ccAdv(1, $location[Hippy Camp]);
	}
	else
	{
		ccAdv(1, $location[Wartime Hippy Camp]);
	}
	return true;
}

boolean L12_flyerFinish()
{
	if(item_amount($item[rock band flyers]) == 0)
	{
		return false;
	}
	if(get_property("flyeredML").to_int() < 10000)
	{
		return false;
	}
	if(get_property("cc_ignoreFlyer").to_boolean())
	{
		return false;
	}
	print("Done with this Rock Band crap", "blue");
	warOutfit();
	visit_url("bigisland.php?place=concert&pwd");
	cli_execute("refresh inv");
	if(item_amount($item[Rock Band Flyers]) == 0)
	{
		return true;
	}
	print("We thought we had enough flyeredML, but we don't. Big sadness, let's try that again.", "red");
	set_property("flyeredML", 9999);
	return false;
}

boolean L9_highLandlord()
{
	if(my_level() < 9)
	{
		return false;
	}
	if(get_property("chasmBridgeProgress").to_int() < 30)
	{
		return false;
	}
	if(get_property("cc_highlandlord") == "finished")
	{
		return false;
	}
	if((my_class() == $class[Ed]) && !get_property("cc_chasmBusted").to_boolean())
	{
		return false;
	}
	if(get_property("cc_highlandlord") == "")
	{
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		set_property("cc_aboocount", "0");
		set_property("choiceAdventure296", "1");
		set_property("cc_highlandlord", "start");
		return true;
	}
	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire1.gif"))
	{
		set_property("cc_boopeak", "finished");
	}

	if(L9_aBooPeak())
	{
		return true;
	}

	if(L9_oilPeak())
	{
		return true;
	}

	if(L9_twinPeak())
	{
		return true;
	}

	if((get_property("twinPeakProgress").to_int() == 15) && (get_property("cc_oilpeak") == "finished") && (get_property("cc_boopeak") == "finished"))
	{
		print("Highlord Done", "blue");
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		council();
		set_property("cc_highlandlord", "finished");
		return true;
	}

	return false;
}

boolean L9_aBooPeak()
{
	if(get_property("cc_boopeak") == "finished")
	{
		return false;
	}
//Allows you to grab the boo-clues you need before finishing off the peak, so you can get the xp from the ghosts you fight, etc.
	if(get_property("cc_aboocount").to_int() < 5)
	{
		print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
		set_property("cc_aboocount", get_property("cc_aboocount").to_int() + 1);
		ccAdv(1, $location[A-Boo Peak]);
		return true;
	}
	
	if(get_property("cc_war") != "finished")
	{
		return false;
	}

	print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
	if(item_amount($item[a-boo clue]) > 0)
	{
		boolean doThisBoo = false;
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		
		if(item_amount($item[Linen Bandages]) == 0)
		{
			return false;
		}

		if(possessEquipment($item[The Crown of Ed the Undying]))
		{
			maximize("spooky res, cold res, equip The Crown of Ed the Undying", 0, 0, false);
			adjustEdHat("bear");
		} else
		{
			maximize("spooky res, cold res", 0, 0, false);
		}
		int coldResist = elemental_resist($element[cold]);
		int spookyResist = elemental_resist($element[spooky]);

		if(item_amount($item[Spooky Powder]) > 0)
		{
			spookyResist = spookyResist + 1;
		}
		if(item_amount($item[Cold Powder]) > 0)
		{
			coldResist = coldResist + 1;
		}
		if(black_market_available() && (item_amount($item[Can of Black Paint]) == 0) && (have_effect($effect[Red Door Syndrome]) == 0) && (my_meat() >= 1000))
		{
			buyUpTo(1, $item[Can of Black Paint]);
		}
		if(item_amount($item[Can of Black Paint]) > 0)
		{
			spookyResist = spookyResist + 2;
			coldResist = coldResist + 2;
		}
		if(item_amount($item[Oil of Parrrlay]) > 0)
		{
			spookyResist = spookyResist + 1;
			coldResist = coldResist + 1;
		}
		if(item_amount($item[Pec Oil]) > 0)
		{
			spookyResist = spookyResist + 2;
			coldResist = coldResist + 2;
		}
		if(have_skill($skill[hide of sobek]))
		{
			spookyResist = spookyResist + 1;
			coldResist = coldResist + 1;
		}
		
		#Calculate how much boo peak damage does per unit resistance.
		int estimatedCold = (13+25+50+125+250) * ((100.0 - elemental_resist_value(coldResist)) / 100.0);
		int estimatedSpooky = (13+25+50+125+250) * ((100.0 - elemental_resist_value(spookyResist)) / 100.0);
		print("Current HP: " + my_hp() + "/" + my_maxhp(), "blue");
		print("Expected cold damage: " + estimatedCold + " Expected spooky damage: " + estimatedSpooky, "blue");int totalDamage = estimatedCold + estimatedSpooky;
		int mp_need = 40;
		if((my_hp() - totalDamage) > 200)
		{
			mp_need = mp_need - 20;
		}
		if((my_hp() - totalDamage) > 300)
		{
			mp_need = mp_need - 10;
		}
		if(my_turncount() == get_property("cc_lastABooConsider").to_int())
		{
			set_property("cc_lastABooCycleFix", get_property("cc_lastABooCycleFix").to_int() + 1);
			if(get_property("cc_lastABooCycleFix").to_int() > 5)
			{
				abort("We are in an A-Boo Peak cycle and can't find anything else to do. Aborting. If you have actual other quests left, please report this. Otherwise, complete A-Boo peak manually");
			}
		}
		else
		{
			set_property("cc_lastABooConsider", my_turncount());
			set_property("cc_lastABooCycleFix", 0);
		}
		if(get_property("booPeakProgress").to_int() == 0)
		{
			doThisBoo = true;
		}
		if(((my_maxhp() >= 400) && (my_mp() >= mp_need)) || ((my_hp() >= totalDamage) && (my_mp() >= 20)))
		{
			doThisBoo = true;
		}
		if(doThisBoo)
		{
			if(item_amount($item[Lihc Face]) > 0)
			{
				equip($item[Lihc Face]);
			}
			if(item_amount($item[ghost of a necklace]) > 0)
			{
				equip($slot[acc2], $item[ghost of a necklace]);
			}
			buffMaintain($effect[Spookypants], 0, 1, 1);
			buffMaintain($effect[Insulated Trousers], 0, 1, 1);

			if(my_class() == $class[Ed])
			{
				buffMaintain($effect[Red Door Syndrome], 0, 1, 1);
				buffMaintain($effect[Well-Oiled], 0, 1, 1);
			}

			set_property("choiceAdventure611", "1");
			use(1, $item[A-Boo clue]);
			ccAdv(1, $location[A-Boo Peak]);
			if((my_class() == $class[Ed]) && (my_hp() == 0))
			{
				use(1, $item[Linen Bandages]);
			}
			return true;
		}
		else if(my_path() != "Picky")
		{
			#abort("Could not handle HP/MP situation for a-boo peak");
		}
		equipBaseline();
	}
	else if((get_property("cc_abooclover") == "") && (get_property("booPeakProgress").to_int() >= 40))
	{
		if(item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);

			string page = visit_url("adventure.php?snarfblat=296&confirm=on");
			if(contains_text(page, "Combat"))
			{
				print("Wandering monster interrupt at a-boo peak", "red");
				ccAdv(1, $location[A-Boo Peak]);
				use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			}
			else
			{
				set_property("cc_abooclover", "used");
			}
			return true;
		}
	}
	else
	{
		ccAdv(1, $location[A-Boo Peak]);
		if(get_property("lastEncounter") == "Come On Ghosty, Light My Pyre")
		{
			set_property("cc_boopeak", "finished");
		}
		return true;
	}
	return false;
}

boolean L9_twinPeak()
{
	if(get_property("twinPeakProgress").to_int() == 15)
	{
		return false;
	}
	if(get_property("cc_oilpeak") != "finished")
	{
		return false;
	}

	if(get_property("cc_twinpeakprogress") == "")
	{
		print("Twin Peak", "blue");
		set_property("choiceAdventure604", "1");
		set_property("choiceAdventure618", "2");
		ccAdv(1, $location[Twin Peak]);
		if(last_monster() != $monster[gourmet gourami])
		{
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Continue...");
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Everything+goes+black.");
			set_property("cc_twinpeakprogress", "1");
			set_property("choiceAdventure606", "2");
			set_property("choiceAdventure608", "1");
		}
		return true;
	}



	int progress = get_property("twinPeakProgress").to_int();
	boolean needStench = ((progress & 1) == 0);
	boolean needFood = ((progress & 2) == 0);
	boolean needJar = ((progress & 4) == 0);
	boolean needInit = (progress == 7);

	int attemptNum = 0;
	boolean attempt = false;
	if(needInit)
	{
		if(initiative_modifier() < 40.0)
		{
			return false;
		}
		attemptNum = 4;
		attempt = true;
	}

	if(needJar && (item_amount($item[Jar of Oil]) == 1))
	{
		attemptNum = 3;
		attempt = true;
	}

	if(!attempt && needFood)
	{
		if(item_drop_modifier() < 50)
		{
			if((friars_available()) && (!get_property("friarsBlessingReceived").to_boolean()))
			{
				cli_execute("friars food");
			}
		}
		float food_drop = item_drop_modifier();
		if(have_effect($effect[Brother Flying Burrito\'s Blessing]) > 0)
		{
			food_drop = food_drop + 30;
		}
		if(food_drop >= 50.0)
		{
			attemptNum = 2;
			attempt = true;

		}
	}

	if(!attempt && needStench)
	{
		buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Neutered Nostrils], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Oiled-Up], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) < 4)
		{
			buffMaintain($effect[Well-Oiled], 0, 1, 1);
		}
		if(elemental_resist($element[stench]) >= 4)
		{
			attemptNum = 1;
			attempt = true;
		}
	}

	if(!attempt)
	{
		return false;
	}

	set_property("choiceAdventure609", "1");
	if(attemptNum == 1)
	{
		set_property("choiceAdventure606", "1");
		set_property("choiceAdventure607", "1");
	}
	else if(attemptNum == 2)
	{
		set_property("choiceAdventure606", "2");
		set_property("choiceAdventure608", "1");
	}
	else if(attemptNum == 3)
	{
		set_property("choiceAdventure606", "3");
		set_property("choiceAdventure609", "1");
		set_property("choiceAdventure616", "1");
	}
	else if(attemptNum == 4)
	{
		set_property("choiceAdventure606", "4");
		set_property("choiceAdventure610", "1");
		set_property("choiceAdventure1056", "1");
	}

	int trimmers = item_amount($item[Rusty Hedge Trimmers]);
	if(item_amount($item[Rusty Hedge Trimmers]) > 0)
	{
		use(1, $item[rusty hedge trimmers]);
		cli_execute("refresh inv");
		if(item_amount($item[rusty hedge trimmers]) == trimmers)
		{
			abort("Tried using a rusty hedge trimmer but that didn't seem to work");
		}
		string page = visit_url("main.php");
		if((contains_text(page, "choice.php")) && (!contains_text(page, "Really Sticking Her Neck Out")) && (!contains_text(page, "It Came from Beneath the Sewer?")))
		{
			print("Inside of a Rusty Hedge Trimmer sequence.", "blue");
		}
		else
		{
			print("Rusty Hedge Trimmer Sequence completed itself.", "blue");
			return true;
		}
	}
	
	if(ccAdvBypass(297, $location[Twin Peak]))
	{
		return true;
	}
	
	string page = visit_url("main.php");
	if((contains_text(page, "choice.php")))
	{
		if(attemptNum == 1)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=1&choiceform1=Investigate+Room+237");
			visit_url("choice.php?pwd&whichchoice=607&option=1&choiceform1=Carefully+inspect+the+body");
		}
		else if(attemptNum == 2)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=2&choiceform2=Search+the+pantry");
			visit_url("choice.php?pwd&whichchoice=608&option=1&choiceform1=Search+the+shelves");
		}
		else if(attemptNum == 3)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=3&choiceform3=Follow+the+faint+sound+of+music");
			visit_url("choice.php?pwd&whichchoice=609&option=1&choiceform1=Examine+the+painting");
			visit_url("choice.php?pwd&whichchoice=616&option=1&choiceform1=Mingle");
		}
		else if(attemptNum == 4)
		{
			visit_url("choice.php?pwd&whichchoice=606&option=4&choiceform4=Wait+--+who%27s+that%3F");
			visit_url("choice.php?pwd&whichchoice=610&option=1&choiceform1=Pursue+your+double");
			visit_url("choice.php?pwd&whichchoice=1056&option=1&choiceform1=And+then...");
		}
		return true;
	}
	else
	{
		ccAdv(1, $location[Twin Peak]);
	}
	return true;
}

boolean L9_oilPeak()
{
	if(get_property("cc_oilpeak") != "")
	{
		return false;
	}

	print("Oil Peak with ML: " + monster_level_adjustment(), "blue");

	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire3.gif"))
	{
		if(item_amount($item[bubblin\' crude]) >= 12)
		{
			cli_execute("make jar of oil");
			set_property("cc_oilpeak", "finished");
			return true;
		}
		if(item_amount($item[Jar of oil]) > 0)
		{
			set_property("cc_oilpeak", "finished");
			return true;
		}
		print("Oil Peak is finished but we need more crude!", "blue");
	}
	
	maximize("ml", 0, 0, false);
	ccAdv(1, $location[Oil Peak]);
	return true;
}

boolean L9_chasmBuild()
{
	if((my_level() < 9) || (get_property("chasmBridgeProgress").to_int() >= 30))
	{
		return false;
	}
	if(LX_getDictionary() || LX_dictionary())
	{
		return true;
	}
	
	print("Chasm time", "blue");
	if(item_amount($item[bridge]) > 0)
	{
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
	}

	if(!get_property("cc_chasmBusted").to_boolean())
	{
		print("What a nice bridge over here...." , "green");
		string page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		if(contains_text(page, "Combat"))
		{
			ccAdv(1, $location[The Smut Orc Logging Camp]);
		}
		else
		{

			set_property("cc_chasmBusted", true);
			abort("Please find the Hulking Bridge Troll manually");
		}
		set_property("cc_chasmBusted", true);
		set_property("chasmBridgeProgress", 0);
		return true;
	}

	if(in_hardcore())
	{
		int need = (30 - get_property("chasmBridgeProgress").to_int());
		if((my_class() == $class[Ed]) && (need > 3) && (item_amount($item[Disassembled Clover]) > 2))
		{
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=295&confirm=on");
			if(contains_text(visit_url("main.php"), "Combat"))
			{
				ccAdv(1, $location[The Smut Orc Logging Camp]);
				return true;
			}
			visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
			return true;
		}
		ccAdv(1, $location[The Smut Orc Logging Camp]);
		if(item_amount($item[Smut Orc Keepsake Box]) > 0)
		{
			use(1, $item[Smut Orc Keepsake Box]);
		}
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		if(get_property("chasmBridgeProgress").to_int() >= 30)
		{
			visit_url("place.php?whichplace=highlands&action=highlands_dude");
		}
		return true;
	}
	
	int need = 30 - get_property("chasmBridgeProgress").to_int();
	
	if((need <= 3) && (need >= 1) && (item_amount($item[Disassembled Clover]) > 0))
	{
		use(1, $item[disassembled clover]);
		visit_url("adventure.php?snarfblat=295&confirm=on");
		if(contains_text(visit_url("main.php"), "Combat"))
		{
			//run_combat();
			ccAdv(1, $location[The Smut Orc Logging Camp]);
			return true;
		}
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
	}
	else
	{
		ccAdv(1, $location[The Smut Orc Logging Camp]);
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		return true;
		#abort("Umm.... we failed the smut orcs. Sorry bro.");
	}
	if(get_property("chasmBridgeProgress").to_int() < 30)
	{
		abort("Umm.... we failed the smut orcs. Sorry bro.");
		abort("Our chasm bridge situation is borken. Beep boop.");
	}
	visit_url("place.php?whichplace=highlands&action=highlands_dude");
	return true;
}

boolean LX_dictionary()
{
	if(item_amount($item[dictionary]) > 0 || item_amount($item[facsimile dictionary]) > 0)
	{
		return false;
	}
	if(item_amount($item[abridged dictionary]) == 1)
	{
		if(knoll_available() || (get_property("questM01Untinker") == "finished"))
		{
			print("Untinkering dictionary", "blue");
			cli_execute("untinker abridged dictionary");
		}
	}
	return false;
}

boolean L9_chasmStart()
{
	if(my_level() < 9)
	{
		return false;
	}
	if((my_class() == $class[Ed]) && !get_property("cc_chasmBusted").to_boolean())
	{
		print("It's a troll on a bridge!!!!", "blue");
		string page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		page = visit_url("place.php?whichplace=orc_chasm&action=bridge_done");
		if(contains_text(page, "Combat"))
		{
			ccAdv(1, $location[The Smut Orc Logging Camp]);
		}
		else
		{
			set_property("cc_chasmBusted", true);
			print("Looks like we've already been here.", "blue");
		}
		set_property("cc_chasmBusted", true);
		set_property("chasmBridgeProgress", 0);
		return true;
	}
	return false;
}

boolean L11_Palindrome()
{
	if((get_property("cc_mcmuffin") == "start") && (get_property("cc_swordfish") == "finished") && (get_property("cc_palindome") == ""))
	{
		if(get_property("questL11Palindome") == "finished")
		{
			set_property("cc_palindome", "finished");
			return true;
		}
		if(equipped_item($slot[acc3]) != $item[Talisman O\' Namsilat])
		{
			equip($slot[acc3], $item[Talisman O\' Namsilat]);
		}

		int total = 0;
		total = total + item_amount($item[Photograph Of A Red Nugget]);
		total = total + item_amount($item[Photograph Of An Ostrich Egg]);
		total = total + item_amount($item[Photograph Of God]);
		total = total + item_amount($item[Photograph Of A Dog]);
		boolean lovemeDone = (item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0);
		print("In the palindome", "blue");
		if(loveMeDone)
		{
			if(item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0)
			{
				use(1, $item[&quot;I Love Me\, Vol. I&quot;]);
			}
			visit_url("place.php?whichplace=palindome&action=pal_drlabel");
			visit_url("choice.php?pwd&whichchoice=872&option=1&photo1=2259&photo2=7264&photo3=7263&photo4=7265");
			set_property("cc_palindome", "finished");
			return true;
		}
		else
		{
			if(my_meat() < 500)
			{
				abort("We don't have enough meat to buy a photograph!");
			}
			ccAdv(1, $location[Inside the Palindome]);
		}
		return true;
	}
	
	return false;
}

boolean L11_talismanOfNam()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(possessEquipment($item[Talisman O\' Namsilat]))
	{
		set_property("cc_swordfish", "finished");
		set_property("cc_gaudy", "finished");
	}
	if(get_property("cc_swordfish") == "finished")
	{
		if(!possessEquipment($item[Talisman O\' Namsilat]))
		{
			print("We should have a Talisman O' Namsilat but we don't know about it, refreshing inventory", "red");
			cli_execute("create talisman o' namsilat");
			cli_execute("refresh inv");
		}
		return false;
	}
	if(get_property("cc_mcmuffin") != "start")
	{
		return false;
	}
	if(!possessEquipment($item[Pirate Fledges]))
	{
		return false;
	}
	if((get_property("cc_war") == "finished") || (get_property("cc_prewar") == ""))
	{
		equip($slot[acc3], $item[pirate fledges]);
		set_property("choiceAdventure189", "1");
		set_property("oceanAction", "continue");
		set_property("oceanDestination", to_lower_case(my_primestat()));
		if(get_property("cc_gaudy") == "")
		{
			print("It always be swordfish.", "blue");
			ccAdv(1, $location[The Poop Deck]);
			if(contains_text(get_property("lastEncounter"), "It\'s Always Swordfish"))
			{
				set_property("cc_gaudy", "start");
			}
		}
		else
		{
			if((item_amount($item[gaudy key]) < 2) && (item_amount($item[Talisman O\' Namsilat]) < 1))
			{
				print("Well, need to farm gaudy keys I suppose... sigh.", "blue");
				ccAdv(1, $location[Belowdecks]);
				return true;
			}
			set_property("cc_gaudy", "finished");
			set_property("cc_swordfish", "finished");

			use(1, $item[gaudy key]);
			use(1, $item[gaudy key]);
		}
		return true;
	}
	return false;
}

boolean L11_mcmuffinDiary()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(my_adventures() <= 4)
	{
		return false;
	}
	if(my_meat() < 500)
	{
		return false;
	}
	if(item_amount($item[Forged Identification Documents]) == 0)
	{
		return false;
	}

	print("Getting the McMuffin Diary", "blue");
	set_property("choiceAdventure793", "1");
	ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
	use(item_amount($item[Your Father\'s Macguffin Diary]), $item[your father\'s macguffin diary]);
	use(item_amount($item[Copy of a Jerk Adventurer\'s Father\'s Diary]), $item[Copy of a Jerk Adventurer\'s Father\'s Diary]);
	set_property("cc_mcmuffin", "start");
	return true;
}

boolean L11_forgedDocuments()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(!black_market_available())
	{
		return false;
	}
	if(get_property("cc_mcmuffin") != "")
	{
		return false;
	}
	if(get_property("cc_blackmap") == "finished")
	{
		return false;
	}
	if(item_amount($item[Forged Identification Documents]) != 0)
	{
		return false;
	}
	if(my_meat() < 5500)
	{
		abort("You don't have enough meat for some forged documents and vacationing, better start inflating!");
	}

	print("Getting the McMuffin Book", "blue");
	buyUpTo(1, $item[forged identification documents]);
	set_property("cc_blackmap", "finished");
	return true;

}

boolean L11_blackMarket()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("cc_blackmap") != "")
	{
		return false;
	}
	if(black_market_available())
	{
		set_property("cc_blackmap", "document");
		return false;
	}
	if(item_amount($item[black map]) == 0)
	{
		council();
		set_property("cc_blackfam", false);
	}
	
	print("Must find the Black Market: " + get_property("blackForestProgress"), "blue");
	if(!get_property("cc_blackfam").to_boolean() && item_amount($item[reassembled blackbird]) > 0)
	{
		set_property("cc_blackfam", true);
	}
	
	set_property("choiceAdventure923", "1");
	if(!possessEquipment($item[Blackberry Galoshes]) && (item_amount($item[Blackberry]) >= 3))
	{
		set_property("choiceAdventure924", "2");
		set_property("choiceAdventure928", "4");
	}
	else
	{
		set_property("choiceAdventure924", "1");
	}
	
	if(item_amount($item[blackberry galoshes]) == 1 && my_basestat($stat[moxie]) > 59)
	{
		equip($slot[acc3], $item[blackberry galoshes]);
	}
	
	if(possessEquipment($item[Blackberry Galoshes]))
	{
		set_property("choiceAdventure923", "2");
		set_property("choiceAdventure925", "2");
	}
	
	ccAdv(1, $location[The Black Forest]);
	if(black_market_available())
	{
		buyUpTo(2, $item[can of black paint]);
		set_property("cc_blackmap", "document");
		if(my_meat() >= 5000)
		{
			buyUpTo(1, $item[forged identification documents]);
			set_property("cc_blackmap", "finished");
		}
	}
	return true;
}

boolean L5_haremOutfit()
{
	if(my_level() < 5)
	{
		return false;
	}
	if(get_property("questL05Goblin") == "finished")
	{
		return false;
	}
	if(possessEquipment($item[Knob Goblin Harem Veil]) && possessEquipment($item[Knob Goblin Harem Pants]))
	{
		return false;
	}
	if(have_effect($effect[Everything Looks Yellow]) > 0)
	{
		return false;
	}
	if((item_amount($item[knob goblin encryption key]) == 1))
	{
		if(item_amount($item[Cobb\'s Knob Map]) == 0)
		{
			council();
		}
		use(1, $item[Cobb\'s Knob Map]);
		return true;
	}

	ccAdv(1, $location[Cobb\'s Knob Harem]);
	return true;
}

boolean LX_getDictionary()
{
	if(item_amount($item[abridged dictionary]) == 1)
	{
		return false;
	}
	if(item_amount($item[dictionary]) == 1)
	{
		return false;
	}
	if(my_level() < 9)
	{
		return false;
	}
	if(my_meat() < 1000)
	{
		return false;
	}
	buyUpTo(1, $item[abridged dictionary]);
	return true;
}

boolean LX_fcle()
{
	if(get_property("cc_pirateoutfit") != "finished")
	{
		return false;
	}
	LX_getDictionary();
	if(get_property("cc_fcle") != "")
	{
		return false;
	}
	if(possessEquipment($item[pirate fledges]))
	{
		set_property("cc_fcle", "finished");
		visit_url("store.php?whichstore=r");
		print("Updating Pirate Bookstore Item (" + get_property("lastPirateEphemeraReset") + "): " + get_property("lastPirateEphemera"), "blue");
		return true;
	}

	if(get_property("cc_prewar") != "")
	{
		if(get_property("cc_war") != "finished")
		{
			return false;
		}
	}
	switch(my_primestat())
	{
	case $stat[Muscle]:
		set_property("choiceAdventure191", 3);
		break;
	case $stat[Moxie]:
		set_property("choiceAdventure191", 1);
		break;
	case $stat[Mysticality]:
		if((my_class() == $class[Ed]) && (my_hp() < 20))
		{
			set_property("choiceAdventure191", 1);
		}
		else
		{
			set_property("choiceAdventure191", 4);
		}
		break;
	}

	if((item_amount($item[rigging shampoo]) == 1) && (item_amount($item[ball polish]) == 1) && (item_amount($item[mizzenmast mop]) == 1))
	{
		use(1, $item[rigging shampoo]);
		use(1, $item[ball polish]);
		use(1, $item[mizzenmast mop]);
		cli_execute("outfit swashbuckling getup");
		ccAdv(1, $location[The F\'c\'le]);
		return true;
	}
	if((my_class() == $class[Ed]) && (item_amount($item[Talisman of Renenutet]) == 0))
	{
		return false;
	}

	if(my_class() == $class[Ed])
	{
		if((have_effect($effect[Taunt of Horus]) == 0) && (item_amount($item[Talisman of Horus]) == 0) && !get_property("cc_dickstab").to_boolean())
		{
			return false;
		}
	}
	
	if(!uneffect($effect[Shelter Of Shed]))
	{
		print("Could not uneffect Shelter of Shed for F'C'le, delaying");
		return false;
	}
	
	buffMaintain($effect[Taunt of Horus], 0, 1, 1);
	print("Fcle time!", "blue");

	cli_execute("outfit swashbuckling getup");
	ccAdv(1, $location[The F\'c\'le]);
	return true;
}

boolean LX_pirateBeerPong()
{
	if(get_property("cc_pirateoutfit") != "almost")
	{
		return false;
	}
	cli_execute("outfit swashbuckling getup");
	LX_getDictionary();
	string page = tryBeerPong();
	if(contains_text(page, "victory laps"))
	{
		set_property("cc_pirateoutfit", "finished");
	}
	else if(contains_text(page, "Combat"))
	{
		ccAdv(1, $location[barrrney\'s barrr]);
	}
	return true;
}

boolean LX_nastyBooty()
{
	if(item_amount($item[Cap\'m Caronch\'s Map]) == 0)
	{
		return false;
	}
	if(item_amount($item[Cap\'m Caronch\'s Nasty Booty]) != 0)
	{
		return false;
	}

	handleServant($servant[Priest]);
	if(possessEquipment($item[The Crown of Ed the Undying]))
	{
		adjustEdHat("weasel");
	} else {
		if (my_meat() > 100){
			buyUpTo(1, $item[hair spray]);
			buyUpTo(1, $item[ben-gal&trade; balm]);
		}
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	}
	
	set_location($location[The Obligatory Pirate\'s Cove]);
	cli_execute("preadventure.ash");
	set_property("cc_disableAdventureHandling", "yes");
	visit_url("inv_use.php?pwd=&which=3&whichitem=2950");
	ccAdv(1, $location[Noob Cave]);
	set_property("cc_disableAdventureHandling", "no");
	return true;
}

boolean LX_pirateBlueprint()
{
	if(get_property("cc_pirateoutfit") != "blueprint")
	{
		return false;
	}
	print("Trying to blueprint handle", "blue");
	LX_getDictionary();
	if(LX_nastyBooty())
	{
		return true;
	}
	if(item_amount($item[orcish frat house blueprints]) == 0)
	{
		cli_execute("outfit swashbuckling getup");
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	else
	{
		print("Crossdressing (even if you are female) as a sorority girl!", "blue");
		set_property("choiceAdventure188", "3");
		if(knoll_available())
		{
			buyUpTo(1, $item[frilly skirt]);
		}
		else if(!possessEquipment($item[Frilly Skirt]))
		{
			ccAdv(1, $location[The Degrassi Knoll Gym]);
			return true;
		}

		if(item_amount($item[Hot Wing]) < 3)
		{
			return false;
		}
		if(equipped_item($slot[pants]) != $item[Frilly Skirt])
		{
			equip($item[Frilly Skirt]);
		}

		use(1, $item[orcish frat house blueprints]);
		set_property("cc_pirateoutfit", "almost");
		return true;
	}
}

boolean LX_pirateInsults()
{
	if(get_property("cc_pirateoutfit") != "insults")
	{
		return false;
	}
	if(my_maxhp() < 60)
	{
		if((item_amount($item[Cap\'m Caronch\'s Map]) != 0) && (item_amount($item[Cap\'m Caronch\'s Nasty Booty]) == 0))
		{
			return false;
		}
	}
	print("Insult gathering party.", "blue");
	if(LX_nastyBooty())
	{
		return true;
	}
	cli_execute("outfit swashbuckling getup");
	LX_getDictionary();

	if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
	{
		buyUpTo(1, $item[the big book of pirate insults]);
	}
	if(item_amount($item[the big book of pirate insults]) == 0)
	{
		return false;
	}

	buyUpTo(1, $item[hair spray]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
	buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);

	cli_execute("refresh inv");
	if(numPirateInsults() < 7)
	{
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	set_property("cc_pirateoutfit", "blueprint");
	return false;
}

boolean LX_pirateOutfit()
{
	if(get_property("cc_pirateoutfit") != "")
	{
		return false;
	}
	if(item_amount($item[Dingy Dinghy]) == 0)
	{
		return false;
	}

	if((possessEquipment($item[eyepatch])) && (possessEquipment($item[swashbuckling pants])) && (possessEquipment($item[stuffed shoulder parrot])))
	{
		if(item_amount($item[the big book of pirate insults]) == 1)
		{
			set_property("cc_pirateoutfit", "insults");
			return true;
		}
		if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
		{
			set_property("cc_pirateoutfit", "insults");
			buyUpTo(1, $item[the big book of pirate insults]);
			return true;
		}
	}
	else
	{
		if(!possessEquipment($item[stuffed shoulder parrot]))
		{
			if(my_hp() <= 3)
			{
				return false;
			}
		}
		print("Searching for a pirate outfit.", "blue");
		if(possessEquipment($item[eyepatch]))
		{
			set_property("choiceAdventure22", "2");
			if(possessEquipment($item[swashbuckling pants]))
			{
				set_property("choiceAdventure22", "3");
			}
		}
		else
		{
			set_property("choiceAdventure22", "1");
		}

		if(possessEquipment($item[stuffed shoulder parrot]))
		{
			set_property("choiceAdventure23", "2");
			if(possessEquipment($item[swashbuckling pants]))
			{
				set_property("choiceAdventure23", "3");
			}
		}
		else
		{
			set_property("choiceAdventure23", "1");
		}

		if(possessEquipment($item[stuffed shoulder parrot]))
		{
			set_property("choiceAdventure24", "3");
			if(possessEquipment($item[eyepatch]))
			{
				set_property("choiceAdventure24", "2");
			}
		}
		else
		{
			set_property("choiceAdventure24", "1");
		}

		change_mcd(0);
		ccAdv(1, $location[The Obligatory Pirate\'s Cove]);
		return true;
	}
	return false;
}


boolean L8_trapperYeti()
{
	if(get_property("cc_trapper") != "yeti")
	{
		return false;
	}

	if((item_amount($item[Ninja Rope]) > 0) && (item_amount($item[Ninja Carabiner]) > 0) && (item_amount($item[Ninja Crampons]) > 0))
	{
		if(elemental_resist($element[cold]) < 5)
		{
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		}
		if(elemental_resist($element[cold]) >= 5)
		{
			if(get_property("cc_mistypeak") == "")
			{
				set_property("cc_ninjasnowmanassassin", "1");
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
				set_property("cc_mistypeak", "done");
			}

			print("Time to take out Gargle", "blue");
			if((item_amount($item[Groar\'s Fur]) == 0) && (item_amount($item[Winged Yeti Fur]) == 0))
			{
				//If this returns false, we might have finished already, can we check this?
				ccAdv(1, $location[Mist-shrouded Peak]);
			}
			else
			{
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				autosell(5, $item[dense meat stack]);
				set_property("cc_trapper", "finished");
				council();
			}
			return true;
		}
	}
	else
	{
		if(get_property("questL08Trapper") == "step1")
		{
			set_property("questL08Trapper", "step2");
		}
		if(!uneffect($effect[Shelter Of Shed]))
		{
			print("Could not uneffect Shelter of Shed for ninja snowmen, delaying");
			return false;
		}

		if(possessEquipment($item[The Crown of Ed the Undying]))
		{
			adjustEdHat("weasel");
		} else if(jump_chance($monster[ninja snowman assassin]) < 50)
		{
			maximize("-ml", 0, 0, false);
			change_mcd(0);
		}
		ccAdv(1, $location[Lair of the Ninja Snowmen]);
		return true;
	}
	return false;
}

boolean cc_tavern()
{
	if(get_property("cc_tavern") == "finished")
	{
		return false;
	}
	visit_url("cellar.php");
	# Mafia usually fixes tavernLayout when we visit the cellar. However, it sometimes leaves it in a broken state so we can't guarantee this will actually help. However, it will result in no net change in tavernLayout so at least we can abort.
	string tavern = get_property("tavernLayout");
	if(index_of(tavern, "3") != -1)
	{
		set_property("cc_tavern", "finished");
		return true;
	}
	print("In the tavern! Layout: " + tavern, "blue");
	boolean [int] locations = $ints[3, 2, 1, 0, 5, 10, 15, 20, 16, 21];
	foreach loc in locations
	{
		tavern = get_property("tavernLayout");
		if(char_at(tavern, loc) == "0")
		{
			int actual = loc + 1;
			#string newTavern = substring(tavern, 0, loc) + "1" + substring(tavern, loc+1, 25);
			#set_property("tavernLayout", newTavern);
			boolean needReset = false;
			#string page = visit_url("cellar.php?action=explore&whichspot=" + actual);

			if(ccAdvBypass("cellar.php?action=explore&whichspot=" + actual))
			{
				return true;
			}

			string page = visit_url("main.php");
			if(contains_text(page, "You've already explored that spot."))
			{
				needReset = true;
				print("tavernLayout is not reporting places we've been to.", "red");
			}
			if(contains_text(page, "Darkness (5,5)"))
			{
				needReset = true;
				print("tavernLayout is reporting too many places as visited.", "red");
			}
			
			#page = visit_url("main.php");
			#if(contains_text(page, "Combat"))
			#{
			#	ccAdv(1, $location[Noob Cave]);
			#}
			if(contains_text(page, "whichchoice value=") || contains_text(page, "whichchoice="))
			{
				adv1($location[Noob Cave], 1, "");
			}
			if(last_monster() == $monster[Crate])
			{
				if(get_property("cc_newbieOverride").to_boolean())
				{
					set_property("cc_newbieOverride", false);
				}
				else
				{
					abort("We went to the Noob Cave for reals... uh oh");
				}
			}
			if(get_property("lastEncounter") == "Like a Bat Into Hell")
			{
				abort("Got stuck undying while trying to do the tavern. Must handle manualy and then resume.");
			}

			if(needReset)
			{
				print("We attempted a tavern adventure but the tavern layout was not maintained properly.", "red");
				print("Attempting to reset this issue...", "red");
				set_property("tavernLayout", "0000100000000000000000000");
				visit_url("cellar.php");

			}
			return true;
		}
	}
	return true;
}

boolean L3_tavern()
{
	if(get_property("cc_tavern") == "finished")
	{
		return false;
	}
	if(my_adventures() < 5)
	{
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 10) == "Fortune Cookie")
	{
		return false;
	}

	if(my_class() == $class[Ed])
	{
		set_property("choiceAdventure1000", "1");
		set_property("choiceAdventure1001", "2");
		if((my_mp() < 15) && have_skill($skill[Shelter of Shed]))
		{
			return false;
		}
	}
	else if((have_effect($effect[In A Lather]) == 0) || (my_mp() < 30))
	{
		if(my_daycount() <= 2)
		{
			return false;
		}
	}
	print("Doing Tavern", "blue");
	if(have_effect($effect[In A Lather]) > 0)
	{
		set_property("choiceAdventure513", "2");
		set_property("choiceAdventure514", "2");
		set_property("choiceAdventure515", "2");
		set_property("choiceAdventure496", "2");
	}
	else
	{
		set_property("choiceAdventure513", "1");
		set_property("choiceAdventure514", "1");
		set_property("choiceAdventure515", "1");
		set_property("choiceAdventure496", "1");
	}

	change_mcd(10);

	while(cc_tavern())
	{
		if(my_adventures() <= 0)
		{
			abort("Ran out of adventures while doing the tavern.");
		}
		wait(4);
	}
	visit_url("tavern.php?place=barkeep");
	set_property("cc_tavern", "finished");
	council();
	return true;
}

boolean doTasks()
{
	handleMCD();
	sellStuff();

	if(my_level() > get_property("lastCouncilVisit").to_int())
	{
		council();
	}
	
	if(last_monster() == $monster[Crate])
	{
		if(get_property("cc_newbieOverride").to_boolean())
		{
			set_property("cc_newbieOverride", false);
		}
		else
		{
			abort("We went to the Noob Cave for reals... uh oh");
		}
	}
	else
	{
		set_property("cc_newbieOverride", false);
	}

//Using up +stat buffs
	buffMaintain($effect[From Nantucket], 0, 1, 1);
	buffMaintain($effect[Squatting and Thrusting], 0, 1, 1);
	buffMaintain($effect[You Read the Manual], 0, 1, 1);
//Eating before fortune handling, so you can pick up the semirare number
	if(ed_eatStuff())
	{
		return true;
	}
//Fortune cookie handling here instead of as a pre-adventure due to the chance of a semi-rare being off (from wrong fortune cookie numbers)
//and thus combat, plus baabaabaran and such
	fortuneCookieEvent();

	if(LX_dictionary())
	{
		return true;
	}
	
	ed_buySkills();
	
	if((my_level() >= 8) && (chateaumantegna_havePainting()) && (my_daycount() <= 3))
	{
		if((have_effect($effect[Everything Looks Yellow]) == 0) && have_skill($skill[Wrath of Ra]) && (my_mp() >= 40))
		{
			if(!get_property("_chateauMonsterFought").to_boolean())
			{
				set_property("cc_disableAdventureHandling", "yes");
				visit_url("place.php?whichplace=chateau&action=chateau_painting");
				ccAdv(1, $location[Noob Cave]);
				set_property("cc_disableAdventureHandling", "no");
				return true;
			}
		}
	}

	if(L1_edIsland() || l1_edIslandFallback())
	{
		return true;
	}

	if(L5_getEncryptionKey())
	{
		return true;
	}
		
	if(LX_islandAccess())
	{
		return true;
	}
	
	if((my_meat() > 1000))
	{
		buyUpTo(1, $item[Hermit Permit]);
		cli_execute("hermit * clover");
	}
	
	if(ed_doResting())
	{
		return true;
	}

	if(L10_airship() || L10_basement() || L10_ground() || L10_topFloor())
	{
		return true;
	}

	if(L12_preOutfit())
	{
		return true;
	}

	if(get_property("cc_dickstab").to_boolean())
	{
		if(L1_edDinsey())
		{
			return true;
		}
		if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
		{
			return true;
		}
		if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
		{
			return true;
		}
		if(L4_batCave())
		{
			return true;
		}
		if(L5_getEncryptionKey())
		{
			return true;
		}
		if(L5_goblinKing())
		{
			return true;
		}
		if(L9_chasmStart() || L9_chasmBuild())
		{
			return true;
		}
		if(LX_pirateOutfit() || LX_pirateInsults() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
		{
			return true;
		}
		if(LX_dinseylandfillFunbucks())
		{
			return true;
		}
		if(L1_edIsland(10))
		{
			return true;
		}
	}

	if(LX_pirateOutfit() || LX_pirateInsults())
	{
		return true;
	}

	if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
	{
		return true;
	}

	if(L4_batCave())
	{
		return true;
	}

	if(L5_goblinKing())
	{
		return true;
	}

	if(L6_friarsGetParts() || L6_friarsHotWing())
	{
		return true;
	}
	
	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}
	
	if(LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
	{
		return true;
	}

	if(!get_property("cc_dickstab").to_boolean() || (my_daycount() >= 2))
	{
		if(L3_tavern())
		{
			return true;
		}
	}

	if(L9_chasmStart() || L9_chasmBuild())
	{
		return true;
	}

	if(L11_blackMarket() || L11_forgedDocuments() || L11_mcmuffinDiary() || L11_talismanOfNam())
	{
		return true;
	}

	if(LX_dinseylandfillFunbucks())
	{
		return true;
	}
	
	if(L7_crypt())
	{
		return true;
	}
	
	if(L12_flyerFinish())
	{
		return true;
	}

	if((my_level() >= 12) && (item_amount($item[rock band flyers]) == 0) && (get_property("flyeredML").to_int() < 10000) && ((get_property("cc_hiddenapartment") == "0") || (get_property("cc_hiddenapartment") == "finished")))
	{
		if(L12_getOutfit())
		{
			return true;
		}

		if(L12_startWar())
		{
			return true;
		}
	}

	if(LX_handleSpookyravenNecklace())
	{
		return true;
	}

	if(LX_handleSpookyravenFirstFloor())
	{
		return true;
	}

	if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
	{
		return true;
	}

	if(L5_haremOutfit())
	{
		return true;
	}

	if(LX_islandAccess())
	{
		return true;
	}

	if(L4_batCave())
	{
		return true;
	}

	if(L5_goblinKing())
	{
		return true;
	}
	
	if(LX_spookyravenSecond())
	{
		return true;
	}
	
	if(L6_friarsGetParts() || L6_friarsHotWing())
	{
		return true;
	}

	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}

	if(LX_pirateOutfit() || LX_pirateInsults() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
	{
		return true;
	}

	if(L12_preOutfit())
	{
		return true;
	}

	if(L10_airship() || L10_basement() || L10_ground() || L10_topFloor())
	{
		return true;
	}

	if(L9_chasmStart() || L9_chasmBuild())
	{
		return true;
	}

	if(L9_highLandlord())
	{
		return true;
	}

	if(L11_blackMarket() || L11_forgedDocuments() || L11_mcmuffinDiary() || L11_talismanOfNam())
	{
		return true;
	}
	
	if(L11_mauriceSpookyraven())
	{
		return true;
	}
	
	if(L11_Palindrome())
	{
		return true;
	}

	if(L11_nostrilOfTheSerpent())
	{
		return true;
	}

	if(L11_unlockHiddenCity())
	{
		return true;
	}

	if(L11_hiddenCityZones())
	{
		return true;
	}

	if(get_property("cc_hippyInstead").to_boolean() && (get_property("cc_nunsTrick") == "true"))
	{
		set_property("cc_nunsTrick", "false");
		set_property("cc_ignoreFlyer", true);
	}
	
//	Sandboxing this till a working nun-truck is available.
//	if(((my_level() >= 12) || (get_property("cc_palindome") == "finished")) && (get_property("cc_mcmuffin") == "start") && ((get_property("cc_hiddenapartment") == "finished") || (get_property("cc_hiddenapartment") == "0")))
//	{
//		if(possessEquipment($item[reinforced beaded headband]) && possessEquipment($item[bullet-proof corduroys]) && possessEquipment($item[round purple sunglasses]))
//		{
//			if(get_property("cc_nunsTrick") == "true")
//			{
//				print("Had gotten War Hippy Fatigues during the Ferret rescue. Don't need to worry about them now.", "blue");
//				set_property("cc_nunsTrick", "got");
//			}
//		} else
//		{
//			print("Only have some of the War Hippy Fatigues, so I'm going to closet everything relevant to get them in the desert", "blue");
//			put_closet(item_amount($item[beer helmet]), $item[beer helmet]);
//			put_closet(item_amount($item[distressed denim pants]), $item[distressed denim pants]);
//			put_closet(item_amount($item[bejeweled pledge pin]), $item[bejeweled pledge pin]);
//			put_closet(item_amount($item[reinforced beaded headband]), $item[reinforced beaded headband]);
//			put_closet(item_amount($item[bullet-proof corduroys]), $item[bullet-proof corduroys]);
//			put_closet(item_amount($item[round purple sunglasses]), $item[round purple sunglasses]);
//				
//			buyUpTo(1, $item[hair spray]);
//			buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
//			ccAdv(1, $location[The Arid\, Extra-Dry Desert]);
//				
//			if(contains_text(get_property("lastEncounter"), "He Got His Just Desserts"))
//			{
//				take_closet(1, $item[beer helmet]);
//				take_closet(1, $item[distressed denim pants]);
//				take_closet(1, $item[bejeweled pledge pin]);
//				set_property("cc_nunsTrick", "got");
//			}
//
//			return true;
//		} else
//		{
//			print("Skipping desert, Ed has had more than enough sand for an afterlifetime.");
//		}
//	}
	
	if((get_property("cc_nunsTrick") == "got") && (get_property("currentNunneryMeat").to_int() < 100000) && !get_property("cc_100familiar").to_boolean())
	{
		set_property("cc_nunsTrickActive", "yes");
		if((get_property("cc_mcmuffin") == "ed") || (get_property("cc_mcmuffin") == "finished"))
		{
			if(doThemtharHills(true))
			{
				return true;
			}
		}
	}

	if(get_property("cc_nunsTrickActive") == "yes")
	{
		set_property("cc_nunsTrickActive", "no");
	}

	boolean canDoHidden = true;
	if((item_amount($item[Moss-Covered Stone Sphere]) == 0) && (get_property("cc_hiddenapartment") != "finished"))
	{
		if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
		{
			canDoHidden = false;
		}
		if((my_adventures() < (9 - get_property("cc_hiddenapartment").to_int())))
		{
			canDoHidden = false;
		}
	}

	if((get_property("cc_hiddenzones") == "finished") && (get_property("cc_hiddencity") == "") && canDoHidden)
	{
		if(my_class() == $class[Ed])
		{
			if(item_amount($item[7963]) == 0)
			{
				set_property("cc_hiddencity", "finished");
				return true;
			}
		}
		else if(item_amount($item[2180]) == 1)
		{
			set_property("cc_hiddencity", "finished");
			return true;
		}


		if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
		{
			use(1, $item[Book of Matches]);
		}

		if((get_property("cc_hiddenapartment") != "finished"))
		{
			if(item_amount($item[Moss-Covered Stone Sphere]) > 0)
			{
				set_property("cc_hiddenapartment", "finished");
				cli_execute("hottub");
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				return true;
			}
			print("The idden [sic] apartment!", "blue");
			int current = get_property("cc_hiddenapartment").to_int();
			current = current + 1;
			set_property("cc_hiddenapartment", current);
			if(current <= 8)
			{
				print("Hidden Apartment Progress: " + get_property("hiddenApartmentProgress"), "blue");
				ccAdv(1, $location[The Hidden Apartment Building]);
				return true;
			}
			else
			{
				set_property("choiceAdventure780", "1");
				if(have_effect($effect[Thrice-Cursed]) == 0)
				{
					if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() < get_property("hiddenTavernUnlock").to_int()))
					{
						use(1, $item[Book of Matches]);
					}
					while(have_effect($effect[Thrice-Cursed]) == 0)
					{
							set_property("choiceAdventure780", "2");
							break;
					}
				}
				print("Hidden Apartment Progress: " + get_property("hiddenApartmentProgress"), "blue");
				ccAdv(1, $location[The Hidden Apartment Building]);
				return true;
			}
		}
		if((get_property("cc_hiddenoffice") != "finished") && (my_adventures() >= 11))
		{
			if(item_amount($item[Crackling Stone Sphere]) > 0)
			{
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				set_property("cc_hiddenoffice", "finished");
				return true;
			}
			print("The idden [sic] office!", "blue");
			int current = get_property("cc_hiddenoffice").to_int();
			current = current + 1;
			set_property("cc_hiddenoffice", ""+current);
			if(current <= 6)
			{
				set_property("choiceAdventure786", "2");
			}
			else
			{
				set_property("choiceAdventure786", "1");
			}

			print("Hidden Office Progress: " + get_property("hiddenOfficeProgress"), "blue");
			if(get_property("cc_autoCraft") == "")
			{
				set_property("cc_autoCraft", get_property("autoCraft").to_boolean());
			}
			set_property("autoCraft", false);
			ccAdv(1, $location[The Hidden Office Building]);
			if((item_amount($item[Boring Binder Clip]) == 1) && (item_amount($item[McClusky File (Page 5)]) == 1))
			{
				visit_url("inv_use.php?pwd=&which=3&whichitem=6694");
				cli_execute("refresh inv");
			}
			if(get_property("cc_autoCraft") != "")
			{
				set_property("autoCraft", get_property("cc_autoCraft").to_boolean());
				set_property("cc_autoCraft", "");
			}

			if(item_amount($item[McClusky File (Complete)]) == 1)
			{
				print("If we abort saying that a boring binder clip doesn't make anything interesting.", "red");
				print("Just run me again, we are trying to work with that...", "red");
			}

			return true;
		}

		if(get_property("cc_hiddenbowling") != "finished")
		{
			if(item_amount($item[Scorched Stone Sphere]) > 0)
			{
				if(have_effect($effect[On The Trail]) > 0)
				{
					if(item_amount($item[soft green echo eyedrop antidote]) > 0)
					{
						uneffect($effect[On The Trail]);
					}
				}
				set_property("cc_hiddenbowling", "finished");
				return true;
			}

			print("The idden [sic] bowling alley!", "blue");
			if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() < get_property("hiddenTavernUnlock").to_int()))
			{
				use(1, $item[Book of Matches]);
			}
			if(item_amount($item[Bowl Of Scorpions]) == 0)
			{
				buyUpTo(1, $item[Bowl Of Scorpions]);
			}
			set_property("choiceAdventure788", "1");

			if(item_amount($item[Airborne Mutagen]) > 1)
			{
				buffMaintain($effect[Heightened Senses], 0, 1, 1);
			}
			print("Hidden Bowling Alley Progress: " + get_property("hiddenBowlingAlleyProgress"), "blue");
			ccAdv(1, $location[The Hidden Bowling Alley]);

			return true;
		}

		if(get_property("cc_hiddenhospital") != "finished")
		{
			if(item_amount($item[Dripping Stone Sphere]) > 0)
			{
				set_property("cc_hiddenhospital", "finished");
				return true;
			}
			print("The idden osptial!! [sic]", "blue");
			set_property("choiceAdventure784", "1");

			if(item_amount($item[bloodied surgical dungarees]) > 0)
			{
				equip($item[bloodied surgical dungarees]);
			}
			if(item_amount($item[half-size scalpel]) > 0)
			{
				equip($item[half-size scalpel]);
			}
			if(item_amount($item[surgical apron]) > 0)
			{
				equip($item[surgical apron]);
			}
			if(item_amount($item[head mirror]) > 0)
			{
				equip($slot[acc3], $item[head mirror]);
			}
			if(item_amount($item[surgical mask]) > 0)
			{
				equip($slot[acc2], $item[surgical mask]);
			}
			print("Hidden Hospital Progress: " + get_property("hiddenHospitalProgress"), "blue");

			ccAdv(1, $location[The Hidden Hospital]);

			return true;
		}
		if((get_property("cc_hiddenapartment") == "finished") && (get_property("cc_hiddenoffice") == "finished") && (get_property("cc_hiddenbowling") == "finished") && (get_property("cc_hiddenhospital") == "finished"))
		{
			print("Getting the stone triangles", "blue");
			set_property("choiceAdventure791", "1");
			while(item_amount($item[stone triangle]) < 1)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
			}
			while(item_amount($item[stone triangle]) < 2)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
			}
			while(item_amount($item[stone triangle]) < 3)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
			}
			while(item_amount($item[stone triangle]) < 4)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
			}

			print("Fighting the out-of-work spirit", "blue");

			try
			{
				cli_execute("ccs cc_default");
				if(ccAdv(1, $location[A Massive Ziggurat])) {}
				cli_execute("ccs null");
			}
			finally
			{
				cli_execute("ccs null");
				print("If I stopped, just run me again, beep!", "red");
			}

			if(item_amount($item[2180]) == 1)
			{
				set_property("cc_hiddencity", "finished");
			}
			return true;
		}
		abort("Should not have gotten here. Aborting");
	}

	if((my_level() >= 12) && (get_property("cc_gremlins") == ""))
	{
		print("Gremlin prep", "blue");
		set_property("cc_gremlins", "start");
		return true;
	}

	if((item_amount($item[barrel of gunpowder]) >= 5) && ((get_property("cc_hippyInstead") == "no") || (get_property("fratboysDefeated").to_int() >= 64)))
	{
		warOutfit();
		visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
		visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
		set_property("cc_sonata", "finished");
		return true;
	}

	if((get_property("cc_gremlins") == "start") && ((get_property("cc_hippyInstead") == "no") || (get_property("fratboysDefeated").to_int() >= 192)))
	{
		maximize("-ml, 0.5 hp, -muscle", 0, 0, false);
		if(item_amount($item[molybdenum hammer]) == 0)
		{
			ccAdv(1, $location[Next to that barrel with something burning in it], "ccsJunkyard");
			return true;
		}
		if(item_amount($item[molybdenum screwdriver]) == 0)
		{
			ccAdv(1, $location[Out by that rusted-out car], "ccsJunkyard");
			return true;
		}
		if(item_amount($item[molybdenum crescent wrench]) == 0)
		{
			ccAdv(1, $location[over where the old tires are], "ccsJunkyard");
			return true;
		}
		if(item_amount($item[molybdenum pliers]) == 0)
		{
			ccAdv(1, $location[near an abandoned refrigerator], "ccsJunkyard");
			return true;
		}
		warOutfit();
		visit_url("bigisland.php?action=junkman&pwd");
		set_property("cc_gremlins", "finished");
		return true;
	}

	if(L12_gremlins() || L12_gremlinStart())
	{
		return true;
	}

	if(L12_sonofaFinish() || L12_sonofaBeach())
	{
		return true;
	}

	if((get_property("cc_orchard") == "finished") && (get_property("sidequestOrchardCompleted") == "none"))
	{
		abort("The script thinks we completed the orchard but mafia doesn't, return the heart?");
	}

	if(L12_orchardStart())
	{
		return true;
	}

	if(L12_filthworms())
	{
		return true;
	}

	if(L12_orchardFinalize())
	{
		return true;
	}

	if((item_amount($item[rock band flyers]) == 1) && (get_property("flyeredML").to_int() < 10000))
	{
		print("Not enough flyer ML but we are ready for the war... uh oh", "blue");
		print("Should not have so little flyer ML at this point, trying high ML locations.", "red");
		wait(1);
		maximize("ML", 0, 0, false);
		if(get_property("sleazeAirportAlways").to_boolean())
		{
			ccAdv(1, $location[Sloppy Seconds Diner]);
		}
		if(get_property("spookyAirportAlways").to_boolean())
		{
			ccAdv(1, $location[The Deep Dark Jungle]);
		}
		if(get_property("stenchAirportAlways").to_boolean())
		{
			ccAdv(1, $location[Pirates of the Garbage Barges]);
		}
		else
		{
			ccAdv(1, $location[Next to that barrel with something burning in it]);
		}
		
		return true;
	}

	if((my_level() >= 12) && ((get_property("hippiesDefeated").to_int() >= 192) || get_property("cc_hippyInstead").to_boolean()) && (get_property("cc_nuns") == ""))
	{
		if(doThemtharHills(false))
		{
			return true;
		}
	}

	if((get_property("cc_war") != "done") && (get_property("cc_war") != "finished") && ((get_property("hippiesDefeated").to_int() >= 1000) || (get_property("fratboysDefeated").to_int() >= 1000)))
	{
		set_property("cc_nuns", "finished");
		set_property("cc_war", "done");
	}

	if((my_level() >= 12) && (get_property("cc_battleFratplant") == ""))
	{
		warOutfit();
		warAdventure();
		oldPeoplePlantStuff();
		set_property("cc_battleFratplant", "plant");
		return true;
	}

	if((get_property("cc_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 64) && (get_property("fratboysDefeated").to_int() < 64)) && (my_level() >= 12))
	{
		print("First 64 combats. To orchard/lighthouse", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("cc_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 192) && (get_property("fratboysDefeated").to_int() < 192)) && (my_level() >= 12))
	{
		print("Getting to the nunnery/junkyard", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("cc_nuns") == "done") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if(get_property("cc_war") == "done")
	{
		equip($slot[hat], $item[none]);
		if(possessEquipment($item[Reinforced Beaded Headband]) && possessEquipment($item[Bullet-Proof Corduroys]) && possessEquipment($item[Round Purple Sunglasses]))
		{
			print("Getting dimes.", "blue");
			sell($item[padl phone].buyer, item_amount($item[padl phone]), $item[padl phone]);
			sell($item[red class ring].buyer, item_amount($item[red class ring]), $item[red class ring]);
			sell($item[blue class ring].buyer, item_amount($item[blue class ring]), $item[blue class ring]);
			sell($item[white class ring].buyer, item_amount($item[white class ring]), $item[white class ring]);
		}
		
		print("Getting quarters.", "blue");
		sell($item[pink clay bead].buyer, item_amount($item[pink clay bead]), $item[pink clay bead]);
		sell($item[purple clay bead].buyer, item_amount($item[purple clay bead]), $item[purple clay bead]);
		sell($item[green clay bead].buyer, item_amount($item[green clay bead]), $item[green clay bead]);
		sell($item[communications windchimes].buyer, item_amount($item[communications windchimes]), $item[communications windchimes]);

		if(!get_property("cc_hippyInstead").to_boolean())
		{
			while($coinmaster[Dimemaster].available_tokens >= 2)
			{
				cli_execute("make filthy poultice");
			}
		}
		else
		{
			while($coinmaster[Quartersmaster].available_tokens >= 2)
			{
				cli_execute("make gauze garter");
			}
		}
		int have = item_amount($item[filthy poultice]) + item_amount($item[gauze garter]);
		if(have < 10)
		{
			int need = 10 - have;
			if(!get_property("cc_hippyInstead").to_boolean())
			{
				need = min(need, $coinmaster[Quartersmaster].available_tokens / 2);
				cli_execute("make " + need + " gauze garter");
			}
			else
			{
				need = min(need, $coinmaster[Dimemaster].available_tokens / 2);
				cli_execute("make " + need + " filthy poultice");
			}
		}

		while($coinmaster[Dimemaster].available_tokens >= 5)
		{
			cli_execute("make fancy seashell necklace");
		}
		while($coinmaster[Dimemaster].available_tokens >= 2)
		{
			cli_execute("make filthy poultice");
		}
		while($coinmaster[Dimemaster].available_tokens >= 1)
		{
			cli_execute("make water pipe bomb");
		}

		while($coinmaster[Quartersmaster].available_tokens >= 5)
		{
			cli_execute("make commemorative war stein");
		}
		while($coinmaster[Quartersmaster].available_tokens >= 2)
		{
			cli_execute("make gauze garter");
		}
		while($coinmaster[Quartersmaster].available_tokens >= 1)
		{
			cli_execute("make beer bomb");
		}

		warOutfit();
		cli_execute("refresh equip");
		if(my_hp() < my_maxhp())
		{
			print("My hp is: " + my_hp());
			print("My max hp is: " + my_maxhp());
		}
		print("Let's fight the boss!", "blue");
		visit_url("bigisland.php?place=camp&whichcamp=1");
		visit_url("bigisland.php?place=camp&whichcamp=2");
		visit_url("bigisland.php?action=bossfight&pwd");
		ccAdvBypass(1, $location[Noob Cave]);
		council();
		set_property("cc_war", "finished");
		return true;
	}
	
	if(my_level() < 13)
	{
		print("We've done everything possible at this time and have not reached the next level, so power-leveling in the most basic way Ed can, abort if you want to do this on your own.", "blue");
		if((get_property("cc_spookyravennecklace") == "done"))
		{
			maximize("exp, -combat", 0, 0, false);
			if (have_skill($skill[Even More Elemental Wards]))
			{
				handleServant($servant[Scribe]);
			}
			set_property("louvreDesiredGoal", "5");
			ccAdv(1, $location[The Haunted Gallery]);
			return true;
		} else if(my_level() <= 9)
		{
			if (have_skill($skill[Even More Elemental Wards]))
			{
				handleServant($servant[Scribe]);
			}
			maximize("exp, -equip filthy knitted dread sack", 0, 0, false);
			ccAdv(1, $location[Hippy Camp]);
			return true;
		} else if((my_level() > 9) && (get_property("cc_castlebasement") == "finished"))
		{
			maximize("exp, -combat", 0, 0, false);
			set_property("choiceAdventure669", "1");
			set_property("choiceAdventure670", "4");
			set_property("choiceAdventure671", "2");
			buyUpTo(1, $item[Ben-Gal&trade; Balm]);
			buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
			buyUpTo(1, $item[Hair Spray]);
			buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
			ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
			return true;
		} else {
			abort("You need to reach the next level before this script can do any more for you, but you have no leveling options available.");
		}
	}

	if(get_property("cc_sorceress") == "")
	{
		council();
		if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
		{
			set_property("cc_sorceress", "finished");
			council();
			return true;
		}
		
		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_10_sorcfight"))
		{
			print("We found the jerkwad!! Revenge!!!!!", "blue");
			string page = visit_url("place.php?whichplace=nstower&action=ns_10_sorcfight");
			if(contains_text(page, "Combat"))
			{
				ccAdv(1, $location[Noob Cave]);
			}
			if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
			{
				set_property("cc_sorceress", "finished");
				council();
			}
			return true;
		}
		else
		{
			print("Please check your quests, but you might just not be at level 13 yet in order to continue.", "red");
			if((my_level() < 13) && get_property("spookyAirportAlways").to_boolean())
			{
				buffMaintain($effect[Experimental Effect G-9], 0, 1, 1);
				if(my_primestat() == $stat[Mysticality])
				{
					buffMaintain($effect[Perspicacious Pressure], 0, 1, 1);
					buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
					buffMaintain($effect[Erudite], 0, 1, 1);
				}
				
				boolean tryJungle = false;
				
				if(have_effect($effect[Jungle Juiced]) > 0)
				{
					tryJungle = true;
				}

				if(((my_inebriety() + 1) < inebriety_limit()) && (item_amount($item[Coinspiracy]) > 0) && (have_effect($effect[Jungle Juiced]) == 0))
				{
					buy(1, $item[Jungle Juice]);
					drink(1, $item[Jungle Juice]);
					tryJungle = true;
				}

				if(tryJungle)
				{
					ccAdv(1, $location[The Deep Dark Jungle]);
				}
				else
				{
					if(item_amount($item[Personal Ventilation Unit]) > 0)
					{
						equip($slot[acc2], $item[Personal Ventilation Unit]);
					}
					ccAdv(1, $location[The Secret Government Laboratory]);
				}
				return true;
			}
			else
			{
				abort("We must be missing a sidequest. We can't find the jerk adventurer.");
			}
		}
	}

	if((get_property("cc_sorceress") == "finished"))
	{
		if(item_amount($item[7965]) == 0)
		{
			ccAdv(1, $location[The Secret Council Warehouse]);
		}
		else
		{
			//Complete.
			return false;
		}
		while((item_amount($item[Warehouse Map Page]) > 0) && (item_amount($item[Warehouse Inventory Page]) > 0))
		{
			#use(item_amount($item[Warehouse Map Page]), $item[Warehouse Map Page]);
			use(item_amount($item[Warehouse Inventory Page]), $item[Warehouse Inventory Page]);
		}
		if(get_property("lastEncounter") == "You Found It!")
		{
			council();
			print("McMuffin is found!", "blue");
			print("Ed Combats: " + get_property("cc_edCombatCount"), "blue");
			print("Ed Combat Rounds: " + get_property("cc_edCombatRoundCount"), "blue");

			return false;
		}
		return true;
	}

	print("I should not get here more than once because I pretty much just finished all my in-run stuff. Beep", "blue");
	wait(5);
	return false;
}

void cc_begin()
{
	cli_execute("spookyraven off");

	print("Hello " + my_name() + ", time to explode!");
#	print("This is version: " + svn_info("790e8b93-0ac5-4690-9eeb-5e64edcd6dc").last_changed_rev);
	print("This is day " + my_daycount() + ".");
	print("Turns played: " + my_turncount() + " current adventures: " + my_adventures());
	print("Current Ascension: " + my_path());
	
	if ((my_class() != $class[Ed]))
	{
		abort("Hold it pardner, this script is meant for mummies only. Come back after you've dried out a bit!");
	}
	
	initializeSettings();
	initializeDay(my_daycount());
//Fix-me, planning on creating a custom maximizer for each area, but that will take a while so enjoy sub-optimal clothing for now. :P
	equipBaseline();
	string charpane = visit_url("charpane.php");
	
	if(contains_text(charpane, "<hr width=50%>"))
	{
		print("Switching off Compact Character Mode, will resume during bedtime");
		set_property("cc_priorCharpaneMode", 1);
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=0&ajax=0", true);
	}

	if(vars["chit.helpers.xiblaxian"] != "false")
	{
		print("Switching off CHiT Xiblaxian Counter, will resume during bedtime");
		set_property("cc_priorXiblaxianMode", 1);
		setvar("chit.helpers.xiblaxian", false);
	}

	if(get_property("hpAutoRecoveryItems") != "linen bandages")
	{
		set_property("cc_hpAutoRecoveryItems", get_property("hpAutoRecoveryItems"));
		set_property("cc_hpAutoRecovery", get_property("hpAutoRecovery"));
		set_property("cc_hpAutoRecoveryTarget", get_property("hpAutoRecoveryTarget"));
		set_property("hpAutoRecoveryItems", "linen bandages");
		set_property("hpAutoRecovery", 0.0);
		set_property("hpAutoRecoveryTarget", 0.0);
	}

	questOverride();

	while((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()) && (get_property("kingLiberated") == "false") && doTasks())
	{
	}
	
	doBedtime();
	print("Done for today (" + my_daycount() + "), beep boop");
}

void main()
{
	cc_begin();
}