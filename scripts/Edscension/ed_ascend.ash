/********************************************

				Edscension
By: chown (a.k.a. wmarkham), who forked it from one:
By: Zen00, a fork of the Cheeseascend
script by Cheesecookie
( http://sourceforge.net/p/cheeseascend/svn/HEAD/tree/ )

Written to more fully define and explore the Actually Ed
the Undying functionalities of said script, and as a skill
stretching project for Zen00 before attempting an independent
ascension script for a future Kingdom of Loathing ascension path.

Changes by chown are focused on fixing bugs, improving support for
low-skill ascensions, and adding a few other assorted features.

see http://github.com/wmarkham/Edscension for changelogs, etc.

********************************************/


import <ed_combat.ash>
import <ed_util.ash>
import <ed_equipment.ash>
import <ed_edTheUndying.ash>
import <ed_eudora.ash>
import <ed_elementalPlanes.ash>
//import <zlib.ash>

boolean LX_chateauDailyPainting();
boolean LX_handleSpookyravenFirstFloor();
boolean ed_LX_islandAccess();
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
boolean L1_edDinsey();
boolean L1_edVacation(int dickstabOverride);
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
boolean L7_crypt();
boolean L8_trapperStart();
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
boolean L12_hippyOutfit();
boolean L12_getOutfit();
boolean L12_startWar();
boolean L12_filthworms();
boolean L12_sonofaBeach();
boolean L12_sonofaFinish();
boolean L12_gremlins();
boolean L12_gremlinStart();
boolean questOverride();

void ed_replacePublicSettings() {
	if (!to_boolean(get_property("ed_settingsReplaced"))) {
		set_property("ed_oldAfterAdventureScript", get_property("afterAdventureScript"));
		set_property("ed_oldCounterScript", get_property("counterScript"));
		set_property("ed_settingsReplaced", "true");
	} else {
		if (
			get_property("afterAdventureScript") != "ed_postadventure.ash"
			|| get_property("counterScript") != ""
		) {
			print("Inconsistent automation script settings for running ed_ascend.ash.  afterAdventureScript and counterScript will be overwritten.", "red");
		}
	}
	set_property("afterAdventureScript", "ed_postadventure.ash");
		//TODO:  does it do anything useful?  Can I just remove it?
	set_property("counterScript", "");
}

void ed_restorePublicSettings() {
	if (to_boolean(get_property("ed_settingsReplaced"))) {
		set_property("afterAdventureScript", get_property("ed_oldAfterAdventureScript"));
		set_property("counterScript", get_property("ed_oldCounterScript"));
		set_property("ed_settingsReplaced", "false");
	}
}

void initializeSettings()
{
	ed_replacePublicSettings();
	if(my_ascensions() <= get_property("ed_doneInitialize").to_int())
	{
		return;
	}
	set_property("ed_delayToDayFour", FALSE);
	set_property("ed_doNunsRegardless", FALSE);
	set_property("ed_abooclover", "");
	set_property("ed_aftercore", "");
	set_property("ed_airship", "");
	set_property("ed_ballroomflat", "");
	set_property("ed_ballroomopen", "");
	set_property("ed_ballroomsong", "");
	set_property("ed_banishes_day1", "");
	set_property("ed_banishes_day2", "");
	set_property("ed_banishes_day3", "");
	set_property("ed_banishes_day4", "");
	set_property("ed_banishes", "");
	set_property("ed_bat", "");
	set_property("ed_bean", "");
	set_property("ed_blackfam", false);
	set_property("ed_blackmap", "");
	set_property("ed_boopeak", "");
	set_property("ed_breakstone", get_property("ed_pvpEnable").to_boolean());
	set_property("ed_castlebasement", "");
	set_property("ed_castleground", "");
	set_property("ed_castletop", "");
	set_property("ed_chasmBusted", true);
	set_property("ed_crypt", "");
	set_property("ed_day1_cobb", "");
	set_property("ed_day1_init", "");
	set_property("ed_day2_init", "");
	set_property("ed_day3_init", "");
	set_property("ed_day4_init", "");
	set_property("ed_disableAdventureHandling", "no");
	set_property("ed_doCombatCopy", "no");
	set_property("ed_fcle", "");
	set_property("ed_fratWarOutfit", "");
	set_property("ed_friars", "");
	set_property("ed_galleryFarm", FALSE);
	set_property("ed_gaudy", "");
	set_property("ed_gaudypiratecount", "");
	set_property("ed_goblinking", "");
	set_property("ed_gremlins", "");
	set_property("ed_gunpowder", "");
	set_property("ed_haveoven", false);
	set_property("ed_hiddenapartment", "0");
	set_property("ed_hiddenbowling", "");
	set_property("ed_hiddencity", "");
	set_property("ed_hiddenhospital", "");
	set_property("ed_hiddenoffice", "0");
	set_property("ed_hiddenunlock", "");
	set_property("ed_hiddenzones", "");
	set_property("ed_highlandlord", "");
	set_property("ed_highLogging", false);
	set_property("ed_hippyInstead", "false");
	set_property("ed_hugeghuol", "");
	set_property("ed_ignoreFlyer", "false");
	set_property("ed_legsbeforebread", "false");
	set_property("ed_maurice", "");
	set_property("ed_mcmuffin", "");
	set_property("ed_mistypeak", "");
	set_property("ed_modernzmobiecount", "");
	set_property("ed_mosquito", "");
	set_property("ed_ninjasnowmanassassin", "0");
	set_property("ed_nuns", "");
	set_property("ed_nunsTrick", "no");
	set_property("ed_nunsTrickActive", "no");
	set_property("ed_nunsTrickCount", "0");
	set_property("ed_nunsTrickReady", "");
	set_property("ed_oilpeak", "");
	set_property("ed_orchard", "");
	set_property("ed_palindome", "");
	set_property("ed_palindomeDudesDefeated", "");
	set_property("ed_prewar", "");
	set_property("ed_hippyOutfit", "");
	set_property("ed_pirateoutfit", "");
	set_property("ed_priorCharpaneMode", "0");
	set_property("ed_semirare", "");
	set_property("ed_semisub", "");
	set_property("ed_snapshot", "");
	set_property("ed_sniffs", "");
	set_property("ed_spookyfertilizer", "");
	set_property("ed_spookymap", "");
	set_property("ed_spookyravennecklace", "");
	set_property("ed_spookyravensecond", "");
	set_property("ed_spookysapling", "");
	set_property("ed_sonata", "");
	set_property("ed_sorceress", "");
	set_property("ed_swordfish", "");
	set_property("ed_tavern", "");
	set_property("ed_trapper", "");
	set_property("ed_treecoin", "");
	set_property("ed_twinpeak", "");
	set_property("ed_twinpeakprogress", "");
	set_property("ed_war", "");
	set_property("ed_winebomb", "");
	set_property("ed_yellowRay_day1", "");
	set_property("ed_yellowRay_day2", "");
	set_property("ed_yellowRay_day3", "");
	set_property("ed_yellowRay_day4", "");
	set_property("ed_yellowRays", "");
	set_property("ed_dayOfSmoochAdventureCount", "");
	set_property("ed_smoochAdventureCount", "");
	
	elementalPlanes_initializeSettings();
	eudora_initializeSettings();
	ed_initializeSettings();
	set_property("ed_doneInitialize", my_ascensions());
}

void ed_resumeCombat() {
	int defeatQuota = 2;  //TODO:  allow more for gremlins, sonofa, bosses
	defeatQuota -= to_int(get_property("_edDefeats"));
	defeatQuota = max(0, defeatQuota);
	ed_ccAdv(1 + defeatQuota, my_location(), "", true);
}

boolean ed_ccAdv(int num, location loc, string option)
{
	return ed_ccAdv(num, loc, option, false);
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
	ed_preAdv(1, loc);
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
	return ccAdvBypass(snarfblat, to_location(snarfblat));
}

boolean ccAdvBypass(string loc)
{
	return ccAdvBypass(loc, $location[noob cave]);
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

boolean ed_buy(int quantity, item which) {
	if (which.seller != $coinmaster[none]) return buy(which.seller, quantity, which);
	return buy(quantity, which);
}

boolean ed_acquire(int quantity, item which) {
	int quantityToBuy = quantity - item_amount(which);
	return ed_buy(quantityToBuy, which);
}

void warOutfit()
{
	if(!get_property("ed_hippyInstead").to_boolean())
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
	//FIXME?:  appears to not honor ed_hippyInstead setting.
	ed_use_servant($servant[Scribe]);
	maximize("exp, outfit frat warrior fatigues", 1, 0, false);
	ccAdv(1, $location[The Battlefield (Frat Uniform)]);
}

//Return false if you should continue, true if it did something
boolean doThemtharHills(boolean trickMode)
{
	if(get_property("currentNunneryMeat").to_int() >= 100000)
	{
		set_property("ed_nunsTrickReady", "done");
		set_property("ed_nuns", "done");
		set_property("ed_nunsTrick", "finished");
		return false;
	}

	if(get_property("ed_hippyInstead").to_boolean() || (get_property("hippiesDefeated").to_int() >= 192))
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
	if(trickMode && (get_property("ed_nunsTrickReady") == "yes") && (get_property("hippiesDefeated").to_int() < 192))
	{
		if(copyAvailable == 0)
		{
			return false;
#			if(!copyPossible)
#			{
#				set_property("ed_nunsTrickReady", "done");
#				set_property("ed_nunsTrick", "finished");
#			}
		}
		fightCopy = true;
	}

	visit_url("charsheet.php");
	ed_use_servant($servant[maid]);
	float meatDropHave = meat_drop_modifier();
	if (
		(get_property("sidequestArenaCompleted") == "fratboy")
		&& (get_property("concertVisited") == "false")
		&& (have_effect($effect[Winklered]) == 0)
	) {
		meatDropHave += 40.0;
	}
	meatDropHave = meatDropHave + edMeatBonus();
	buffMaintain($effect[Purr of the Feline], 10, 1, 1);
	if((meatDropHave > 350.0))
	{
		set_property("ed_doNunsRegardless", TRUE);
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}

	if((get_property("ed_nunsTrickCount").to_int() > 2) || (meat_drop_modifier() > 600.0))
	{
		buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	}
	// Target 1000 + 400% = 5000 meat per brigand. Of course we want more, but don't bother unless we can get this.
	//TODO:  that target might be slightly high; I believe that in the normal flow of things (i.o., no nuns trick)
	//  5 subquests versus 4 subquests nets more than 20 turns in savings....
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
	if(!get_property("ed_doNunsRegardless").to_boolean())
	{
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
				set_property("ed_nuns", "done");
				set_property("ed_nunsTrick", "no");
				set_property("ed_nunsTrickReady", "done");
				return true;
			}
			else
			{
				print("The min should be enough! Doing it!!", "purple");
			}
		}
	}

	if (
		(get_property("sidequestArenaCompleted") == "fratboy")
		&& (get_property("concertVisited") == "false")
		&& (have_effect($effect[Winklered]) == 0)
	) {
		outfit("frat warrior fatigues");
		cli_execute("concert 2");
#		outfit("war hippy fatigues");
	}
	buffMaintain($effect[Sinuses For Miles], 0, 1, 1);
	buffMaintain($effect[Big Meat Big Prizes], 0, 1, 1);
	//TODO:  Dances with Tweedles
	maximize("meat drop, exp, -hat, -pants, -acc3", 1, 0, false);

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
			if(get_property("ed_nunsTrickCount").to_int() == 0)
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

		int advs = get_property("ed_nunsTrickCount").to_int() + 1;
		set_property("ed_nunsTrickCount", advs);

		int diffMeat = curMeat - lastMeat;
		int needMeat = 100000 - curMeat;
		int average = curMeat / advs;
		print("Cur Meat: " + curMeat + " Average: " + average, "blue");

		diffMeat = diffMeat * 1.2;
		average = average * 1.2;
		if(trickMode && ((needMeat < diffMeat) || (needMeat < average)))
		{
			set_property("ed_nunsTrickReady", "yes");
			print("Attempting nuns trick, beep boop!! No more auto-aborting!");
		}
		if((item_amount($item[stone wool]) > 0) && (get_property("ed_nunsTrickCount").to_int() > 2) && !get_property("_templeHiddenPower").to_boolean())
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
		ed_acquire(1, $item[detuned radio]);
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
	if (10000 < my_meat()) return;
	foreach i in $items[
		dense meat stack,
		fancy bath salts,
		empty Cloaca-Cola bottle,
		headhunter necktie,
		keel-haulin' knife,
		drab sonata,
		photoprotoneutron torpedo,
		procrastination potion,
		awful poetry journal,
		leather chaps,
		mesh cap,
		disturbing fanfic,
		carob chunks,
		herbs,
		imp ale,
		ratgut,
		loose teeth,
		skeleton bone,
		cocoa eggshell fragment,
		lihc eye,
		batgut,
		patchouli incense stick,
		broken sword,
		dire fudgesicle,
		frigid ninja stars,
		tambourine bells,
		beach glass bead,
		clay peace-sign bead,
		hippy bongo,
		windchimes,
		phat turquoise bead,
		filthy pestle,
		decorative fountain,
		ice-cold Willer,
		moxie weed,
		strongness elixir,
		leather mask,
		flaming crutch,
		Feng Shui for Big Dumb Idiots,
		enchanted bean,
		spooky shrunken head,
		hot katana blade,
		sunken chest,
		flaregun,
		wussiness potion,
		knob goblin scimitar,
		knob goblin tongs,
		bowl of cottage cheese,
		heat-resistant sheet metal,
		anticheese
	] {
		autosell(item_amount(i), i);
	}

	autosell(item_amount($item[hemp string]) - 1, $item[hemp string]);
	autosell(item_amount($item[filthy knitted dread sack]) - 1, $item[filthy knitted dread sack]);
	autosell(item_amount($item[filthy corduroys]) - 1, $item[filthy corduroys]);
	autosell(item_amount($item[hot wing]) - 3, $item[hot wing]);
	autosell(item_amount($item[Mad Train wine]) - 1, $item[Mad Train wine]);
}

void initializeDay(int day)
{
	if (get_property("chateauAvailable").to_boolean() && !get_property("_chateauDeskHarvested").to_boolean())
	{
		visit_url("place.php?whichplace=chateau&action=chateau_desk");
	}
	ed_initializeDay(day);
}

boolean ed_hermitClovers() {
	if((my_meat() > 1500))
	{
		buyUpTo(1, $item[Hermit Permit]);
		cli_execute("hermit * clover");
	}
	return false;
}

void doBedtime()
{
	print("Starting bedtime.", "blue");

	ed_restorePublicSettings();

	if(get_property("lastEncounter") == "Like a Bat Into Hell")
	{
		abort("Our last encounter was UNDYING and we ended up trying to bedtime and failed.");
	}

	process_kmail("ed_deleteMail");

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

	if(get_property("ed_priorCharpaneMode").to_int() == 1)
	{
		print("Resuming Compact Character Mode.");
		visit_url("account.php?am=1&pwd=&action=flag_compactchar&value=1&ajax=0", true);
	}

	if(get_property("ed_priorXiblaxianMode").to_int() == 1)
	{
		set_property("ed_priorXiblaxianMode", 0);
		setvar("chit.helpers.xiblaxian", true);
	}

	ed_hermitClovers();

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
	maximize("adv", 0, 0, false, false);
	
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
	if(!get_property("ed_haveoven").to_boolean())
	{
		if(my_meat() > 5000)
		{
			buyUpTo(1, $item[Dramatic&trade; range]);
			use(1, $item[Dramatic&trade; range]);
			set_property("ed_haveoven", true);
		}
	}
	if((get_property("questL02Larva") == "finished") && (get_property("ed_mosquito") != "finished"))
	{
		print("Found completed Mosquito Larva (2)");
		set_property("ed_mosquito", "finished");
	}
	if((get_property("questL03Rat") == "finished") && (get_property("ed_tavern") != "finished"))
	{
		print("Found completed Tavern (3)");
		set_property("ed_tavern", "finished");
	}
	if((get_property("questL04Bat") == "finished") && (get_property("ed_bat") != "finished"))
	{
		print("Found completed Bat Cave (4)");
		set_property("ed_bat", "finished");
	}
	if((get_property("questL05Goblin") == "finished") && (get_property("ed_goblinking") != "finished"))
	{
		print("Found completed Goblin King (5)");
		set_property("ed_day1_cobb", "finished");
		set_property("ed_goblinking", "finished");
	}
	if((get_property("questL06Friar") == "finished") && (get_property("ed_friars") != "finished"))
	{
		print("Found completed Friars (6)");
		set_property("ed_friars", "finished");
	}
	if(((item_amount($item[Skull of the Bonerdagon]) > 0) || possessEquipment($item[Badass Belt])) && (get_property("ed_crypt") != "finished"))
	{
		print("Found completed Cyrpt (7)");
		set_property("ed_crypt", "finished");
	}
	if((get_property("questL08Trapper") == "step2") && (get_property("ed_trapper") != "yeti"))
	{
		print("Found Trapper partially completed (8: Ores/Cheese)");
		set_property("ed_trapper", "yeti");
	}
	if((get_property("questL08Trapper") == "finished") && (get_property("ed_trapper") != "finished"))
	{
		print("Found completed Trapper (8)");
		set_property("ed_trapper", "finished");
	}
	if((get_property("questL09Topping") == "finished") && (get_property("ed_highlandlord") != "finished"))
	{
		print("Found completed Highland Lord (9)");
		set_property("ed_highlandlord", "finished");
	}
	if(possessEquipment($item[Pirate Fledges]) && (get_property("ed_pirateoutfit") != "finished"))
	{
		print("Found completed pirates, Arrr! (8)");
		set_property("ed_pirateoutfit", "finished");
	}
	if((get_property("questM16Temple") == "finished") && (get_property("ed_spookymap") != "finished"))
	{
		print("Found completed forest, Spoooky! (3)");
		set_property("ed_spookyfertilizer", "finished");
		set_property("ed_spookymap", "finished");
		set_property("ed_spookysapling", "finished");
		set_property("ed_treecoin", "finished");
	}
	if((get_property("questL10Garbage") == "finished") && (get_property("ed_castletop") != "finished"))
	{
		print("Found completed Castle in the Clouds in the Sky with some Pie (10)");
		set_property("ed_castletop", "finished");
		set_property("ed_castleground", "finished");
		set_property("ed_castlebasement", "finished");
		set_property("ed_airship", "finished");
	}
	if((get_property("questL11Black") == "finished") && (get_property("ed_blackmap") != "finished"))
	{
		print("Found completed Black Market (11)");
		set_property("ed_blackmap", "finished");
	}
	if((get_property("questL11Palindome") == "finished") && (get_property("ed_palindome") != "finished"))
	{
		print("Found completed Palindome (11)");
		set_property("ed_palindome", "finished");
	}
	if((get_property("questL11Business") == "finished") && (get_property("ed_hiddenoffice") != "finished"))
	{
		print("Found completed Hidden Office Building (11)");
		set_property("ed_hiddenoffice", "finished");
	}
	if((get_property("questL11Curses") == "finished") && (get_property("ed_hiddenapartment") != "finished"))
	{
		print("Found completed Hidden Apartment Building (11)");
		set_property("ed_hiddenapartment", "finished");
	}
	if((get_property("questL11Spare") == "finished") && (get_property("ed_hiddenbowling") != "finished"))
	{
		print("Found completed Hidden Bowling Alley (11)");
		set_property("ed_hiddenbowling", "finished");
	}
	if((get_property("questL11Doctor") == "finished") && (get_property("ed_hiddenhospital") != "finished"))
	{
		print("Found completed Hidden Hopickle (11)");
		set_property("ed_hiddenhospital", "finished");
	}
	if((get_property("questL11Worship") == "finished") && (get_property("ed_hiddencity") != "finished"))
	{
		print("Found completed Hidden City (11)");
		set_property("ed_hiddencity", "finished");
	}
	if((get_property("sidequestLighthouseCompleted") != "none") && (get_property("ed_sonata") != "finished"))
	{
		print("Found completed Lighthouse (12)");
		set_property("ed_sonata", "finished");
	}
	if((get_property("sidequestJunkyardCompleted") != "none") && (get_property("ed_gremlins") != "finished"))
	{
		print("Found completed Junkyard (12)");
		set_property("ed_gremlins", "finished");
	}
	if((get_property("sidequestOrchardCompleted") != "none") && (get_property("ed_orchard") != "finished"))
	{
		print("Found completed Orchard (12)");
		set_property("ed_orchard", "finished");
	}
	if((get_property("sidequestNunsCompleted") != "none") && (get_property("ed_nuns") != "done") && (get_property("ed_nuns") != "finished"))
	{
		print("Found completed Nuns (12)");
		set_property("ed_nuns", "finished");
	}
	if((get_property("sideDefeated") != "neither") && (get_property("ed_war") != "finished"))
	{
		print("Found completed Island War (12)");
		set_property("ed_war", "finished");
	}
	
	return false;
}

boolean LX_chateauDailyPainting()
{
	if(!get_property("chateauAvailable").to_boolean())
	{
		return false;
	}
	if(get_property("_chateauMonsterFought").to_boolean())
	{
		return false;
	}

	if(my_level() > 7)
	{
		if(get_property("chateauMonster") == "Mountain Man")
		{
			int oreHave = 0;
			string oreNeeded = get_property("trapperOre");
			if(oreNeeded == "asbestos ore")
			{
				oreHave = item_amount($item[asbestos ore]);
			}
			if(oreNeeded == "linoleum ore")
			{
				oreHave = item_amount($item[linoleum ore]);
			}
			if(oreNeeded == "chrome ore")
			{
				oreHave = item_amount($item[chrome ore]);
			}
			maximize("exp", 0, 0, false);
			if((have_effect($effect[Everything Looks Yellow]) == 0) && have_skill($skill[Wrath of Ra]) && (my_mp() >= 40) &&
			(oreHave < 3) && (get_property("ed_trapper") == "start"))
			{
				ed_use_servant($servant[scribe]);
				ed_use_servant();
				visit_url("place.php?whichplace=chateau&action=chateau_painting");
				ccAdvBypass(1, $location[Noob Cave]);
				return true;
			}
		} else if(get_property("chateauMonster") == "Bram the Stoker")
		{
			if(item_amount($item[bram's choker]) > 0)
			{
				return false;
			}
			if(possessEquipment($item[The Crown of Ed the Undying]))
			{
				maximize("exp, equip the crown of ed the undying", 0, 0, false);
				adjustEdHat("weasel");
				ed_use_servant($servant[scribe]);
				ed_use_servant();
				visit_url("place.php?whichplace=chateau&action=chateau_painting");
				ccAdvBypass(1, $location[Noob Cave]);
				return true;
			} else
			{
				if(my_Level() > 8)
				{
					maximize("hp, da, dr", 0, 0, false);
					if(my_hp() > 100)
					{
						print("Trying Bram, this is untested so continue at your own risk. Let me know the results.", "red");
						wait(20);
						visit_url("place.php?whichplace=chateau&action=chateau_painting");
						ccAdvBypass(1, $location[Noob Cave]);
						return true;
					}
				}
			}
		} else if(get_property("chateauMonster") == "Lobsterfrogman")
		{
			if(possessEquipment($item[The Crown of Ed the Undying]))
			{
				maximize("exp, equip the crown of ed the undying", 0, 0, false);
				adjustEdHat("weasel");
				ed_use_servant($servant[scribe]);
				ed_use_servant();
				visit_url("place.php?whichplace=chateau&action=chateau_painting");
				ccAdvBypass(1, $location[Noob Cave]);
				return true;
			} else
			{
				if(my_Level() > 8)
				{
					maximize("hp, da, dr", 0, 0, false);
					if(my_hp() > 100)
					{
						print("Trying Lobsterfrogman, this is untested so continue at your own risk. Let me know the results.", "red");
						wait(20);
						visit_url("place.php?whichplace=chateau&action=chateau_painting");
						ccAdvBypass(1, $location[Noob Cave]);
						return true;
					}
				}
			}
		} else
		{
			print("Your painting isn't officially supported by this script, but we'll give it the college try.", "red");
			maximize("HP, equip the crown of ed the undying", 0, 0, false);
			adjustEdHat("weasel");
			ed_use_servant($servant[scribe]);
			ed_use_servant();
			visit_url("place.php?whichplace=chateau&action=chateau_painting");
			ccAdvBypass(1, $location[Noob Cave]);
			return true;
		}
	}
	
	return false;
}

boolean L11_hiddenCityZones()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("ed_mcmuffin") != "start")
	{
		return false;
	}
	if(get_property("ed_hiddenzones") == "finished")
	{
		return false;
	}

	if(get_property("ed_hiddenzones") == "")
	{
		print("Machete the hidden zones!", "blue");
		set_property("choiceAdventure781", "1");
		set_property("choiceAdventure785", "1");
		set_property("choiceAdventure783", "1");
		set_property("choiceAdventure787", "1");
		set_property("choiceAdventure789", "2");
		set_property("choiceAdventure1002", "6");
		set_property("ed_hiddenzones", "0");
		if(possessEquipment($item[Antique Machete]))
		{
			set_property("ed_hiddenzones", "1");
		}
	}

	if(get_property("ed_hiddenzones") == "0")
	{
		//TODO:  why do we abandon the park after 10 adventures there??  Fewer janitors in the hospital and bowling alley is a good idea!
		if(possessEquipment($item[antique machete]) && ((item_amount($item[book of matches]) > 0) || ("The Hidden Park".to_location().turns_spent > 9)))
		{
			set_property("ed_hiddenzones", "1");
		}
		else
		{
			ccAdv(1, $location[The Hidden Park]);
			if(contains_text(get_property("lastEncounter"), "Where Does The Lone Ranger Take His Garbagester"))
			{
				set_property("choiceAdventure789", "1");
			}
			return true;
		}
	}

	if(get_property("ed_hiddenzones") == "1")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
		if(contains_text(get_property("lastEncounter"), "Earthbound and Down"))
		{
			set_property("ed_hiddenzones", "2");
		}
		return true;
	}

	if(get_property("ed_hiddenzones") == "2")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
		if(contains_text(get_property("lastEncounter"), "Air Apparent"))
		{
			set_property("ed_hiddenzones", "3");
		}
		return true;
	}

	if(get_property("ed_hiddenzones") == "3")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
		if(contains_text(get_property("lastEncounter"), "Water You Dune"))
		{
			set_property("ed_hiddenzones", "4");
		}
		return true;
	}

	if(get_property("ed_hiddenzones") == "4")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
		if(contains_text(get_property("lastEncounter"), "Fire When Ready"))
		{
			set_property("ed_hiddenzones", "5");
		}
		return true;
	}

	if(get_property("ed_hiddenzones") == "5")
	{
		equip($item[antique machete]);
		ccAdv(1, $location[A Massive Ziggurat]);
		if(contains_text(get_property("lastEncounter"), "Temple of the Legend in the Hidden City"))
		{
			set_property("choiceAdventure1002", "1");
			set_property("choiceAdventure781", "1");
			set_property("choiceAdventure785", "1");
			set_property("choiceAdventure783", "1");
			set_property("choiceAdventure787", "1");
			set_property("ed_hiddenzones", "finished");
		}
		maximize("exp", 1, 0, false);
		return true;
	}
	return false;
}

boolean fortuneCookieEvent()
{
	if(get_property("ed_dickstab").to_boolean() && (get_property("ed_orchard") == "finished"))
	{
		if(get_counters("Fortune Cookie", 0, 200) != "")  //TODO:  at the very least, change this to only detect if the counter is up right now.
		{
			print("We don't care about the semirares anymore, we are past the orchard. Cancelling.", "blue");
			cli_execute("counters clear");  // You know, I probably ate that fortune cookie for a reason.  And, never mind any other counters I might have been using....  yeah, 'dickstab' is pretty accurate.
		}
		return false;
	}
	if(get_property("ed_dickstab").to_boolean() && (get_property("ed_semirare").to_int() == 2))
	{
		if(get_counters("Fortune Cookie", 0, 200) != "")  //TODO:  only detect if the counter is up right now.  or, remove 'dickstab' support entirely.
		{
			print("We don't care about the semirares anymore. Cancelling.", "blue");
			cli_execute("counters clear");
		}
		return false;
	}

	if(get_counters("Fortune Cookie", 0, 0) != "Fortune Cookie") return false;

	print("Semi rare time!", "blue");
	int semiRareTurn = my_turncount();
	if (
		(get_property("ed_semirare") == "")
		&& (get_property("ed_spookysapling") == "finished")
		&& $location[The Hidden Temple] != to_location(get_property("semirareLocation"))
	) {
		if(my_mp() < 8)  //TODO: why is this different from the regular preadventure?
		{
			while(my_meat() > 89 && my_mp() < 8)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}

			if(my_mp() < 8)
			{
				abort("Couldn't restore your MP before attempting to grab a semi-rare");
			}
		}
		set_property("choiceAdventure579", "2");
		ed_use_servant($servant[cat]);
		ed_use_servant();
		//TODO:  can we add "confirm=on", to avoid the extra call to ccAdv?  Or at least detect if the first call did its thing.
		ccAdv(1, $location[The Hidden Temple]);
		if (my_turncount() == semiRareTurn) ccAdv(1, $location[The Hidden Temple]);
		//ccAdvBypass(280);  // The Hidden Temple
		if(item_amount($item[stone wool]) > 0)
		{
			set_property("ed_semirare", "1");
			print("Wool obtained!", "blue");
		}
		return true;
	} else if (
		(get_property("ed_semirare") == "1")
		&& (get_property("ed_castleground") == "finished")
		&& (get_property("ed_nuns") != "done")
		&& $location[The Castle in the Clouds in the Sky (Top Floor)] != to_location(get_property("semirareLocation"))
	) {
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
		if (my_turncount() == semiRareTurn) ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);
		//ccAdvBypass(324);  // The Castle in the Clouds in the Sky (Top Floor)
		if(item_amount($item[Mick\'s IcyVapoHotness Inhaler]) > 0)
		{
			set_property("ed_castleground", "done");
			set_property("ed_semisub", "limerick");
			set_property("ed_semirare", "2");
			print("Inhaler obtained!", "blue");
		}
		return true;
	} else if (
		(get_property("ed_semisub") == "limerick")
		&& (get_property("ed_maurice") != "finished")
		&& $location[The Limerick Dungeon] != to_location(get_property("semirareLocation"))
		&& 0 == item_amount($item[cyclops eyedrops])
	) {
		ccAdv(1, $location[The Limerick Dungeon]);
		if (my_turncount() == semiRareTurn) ccAdv(1, $location[The Limerick Dungeon]);
		//ccAdvBypass(19);  // The Limerick Dungeon
		if(item_amount($item[cyclops eyedrops]) > 0)
		{
			set_property("ed_semisub", "alley");
			print("Eyedrops obtained!", "blue");
		}
		return true;
	} else if (
		$location[The Sleazy Back Alley] != to_location(get_property("semirareLocation"))
	) {
		ccAdv(1, $location[The Sleazy Back Alley]);
		if (my_turncount() == semiRareTurn) ccAdv(1, $location[The Sleazy Back Alley]);
		//ccAdvBypass(112);  // The Sleazy Back Alley
		if(item_amount($item[distilled fortified wine]) > 0)
		{
			print("Wine got!", "blue");
			set_property("ed_semisub", "alley");
		}
		return true;
	}
	else
	{
		ccAdv(1, $location[The Haunted Pantry]);
		if (my_turncount() == semiRareTurn) ccAdv(1, $location[The Haunted Pantry]);
		//ccAdvBypass(113);  // The Haunted Pantry
		if(item_amount($item[tasty tart]) > 0)
		{
			print("Tarts got!", "blue");
			set_property("ed_semisub", "pantry");
		}
		return true;
	}
	// just for reference, outskirts of the knob is snarfblat 114
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
	if(get_property("ed_hiddenunlock") != "nose")
	{
		return false;
	}
	if(get_property("ed_hiddenunlock") == "finished")
	{
		return false;
	}

	print("Searching for the Hidden City", "blue");
	buffMaintain($effect[Stone-Faced], 0, 1, 1);
	set_property("choiceAdventure584", "4");
	set_property("choiceAdventure582", "2");

	if(ccAdvBypass(280))
	{
		print("Wandering monster interrupted our attempt at the Hidden City", "red");
		return true;
	}
	
	if(get_property("lastEncounter") == "Fitting In")
	{
		visit_url("choice.php?whichchoice=582&option=2&pwd");
	}
	if(get_property("lastEncounter") == "Fitting In"
		|| get_property("lastEncounter") == "The Hidden Heart of the Hidden Temple")
	{
		visit_url("choice.php?whichchoice=580&option=2&pwd");
		visit_url("choice.php?whichchoice=584&option=4&pwd");
		visit_url("choice.php?whichchoice=580&option=1&pwd");
		visit_url("choice.php?whichchoice=123&option=2&pwd");
		visit_url("choice.php");
		cli_execute("dvorak");
		visit_url("choice.php?whichchoice=125&option=3&pwd");
		print("Hidden Temple Unlocked", "blue");
		set_property("choiceAdventure582", "1");
		set_property("choiceAdventure579", "3");
		set_property("ed_hiddenunlock", "finished");
	}
	if(get_property("lastEncounter") == "Such Great Heights")
	{
		visit_url("choice.php?whichchoice=579&option=1&pwd");
	}
	if(get_property("lastEncounter") == "Such Great Depths")
	{
		visit_url("choice.php?whichchoice=581&option=3&pwd");
	}
	
	return true;
}

boolean L11_nostrilOfTheSerpent()
{
	if(get_property("ed_mcmuffin") == "")
	{
		return false;
	}
	if(get_property("ed_mcmuffin") != "start")
	{
		return false;
	}
	if(item_amount($item[The Nostril of the Serpent]) != 0)
	{
		return false;
	}
	//TODO:  check mafia's quest tracking, and set ed_hiddenunlock, as appropriate.  (questOverride is probably supposed to do that.)
	if(get_property("ed_hiddenunlock") != "")
	{
		return false;
	}

	print("Must get a snake nose.", "blue");
	set_property("choiceAdventure582", "1");
	set_property("choiceAdventure579", "2");
	buffMaintain($effect[Stone-Faced], 0, 1, 1);
	if(have_effect($effect[Stone-Faced]) == 0)
	{
		print("We are not Stone-Faced. Please get a stone wool and run me again or we'll just do this manually.", "red");
		wait(20);
	}
	if(ccAdvBypass(280))
	{
		print("Wandering monster interrupted our attempt at the Hidden City", "red");
		return true;
	}
	if((get_property("lastEncounter") == "The Hidden Heart of the Hidden Temple (Sun)") ||
	(get_property("lastEncounter") == "The Hidden Heart of the Hidden Temple (Stone)") ||
	(get_property("lastEncounter") == "The Hidden Heart of the Hidden Temple (Gargoyle)"))
	{
		visit_url("choice.php?whichchoice=580&option=1&pwd");
	}
	if(get_property("lastEncounter") == "Such Great Heights")
	{
		visit_url("choice.php?whichchoice=579&option=2&pwd");
	}
	if(get_property("lastEncounter") == "Such Great Depths")
	{
		visit_url("choice.php?whichchoice=581&option=3&pwd");
	}
	if(get_property("lastEncounter") == "Fitting In")
	{
		visit_url("choice.php?whichchoice=582&option=1&pwd");
		visit_url("choice.php?whichchoice=579&option=2&pwd");
	}
	
	cli_execute("refresh inv");
	if(item_amount($item[The Nostril of the Serpent]) == 1)
	{
		set_property("ed_hiddenunlock", "nose");
		set_property("choiceAdventure579", "3");
	}
	return true;
}

boolean LX_spookyBedroomCombat()
{
	set_property("ed_disableAdventureHandling", "yes");
	ccAdv(1, $location[The Haunted Bedroom]);
	set_property("ed_disableAdventureHandling", "no");
	return false;
}

boolean LX_handleSpookyravenFirstFloor()
{
	if(get_property("ed_spookyravennecklace") == "finished")
	{
		return false;
	}
	if(!have_skill($skill[Even More Elemental Wards]) && get_property("ed_edDelayHauntedKitchen").to_boolean())
	{
		print("Delaying kitchen till you got some more resistance", "blue");
		return false;
	}
	if(item_amount($item[Lady Spookyraven\'s Necklace]) > 0)
	{
		visit_url("place.php?whichplace=manor1&action=manor1_ladys");
		visit_url("main.php");
		cli_execute("refresh inv");
	}
	if(item_amount($item[Ghost of a Necklace]) > 0)
	{
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		set_property("ed_spookyravennecklace", "finished");
		return true;
	}
	
	if(get_property("writingDesksDefeated").to_int() >= 5)
	{
		abort("Mafia reports 5 or more writing desks defeated yet we are still looking for them? Give Lady Spookyraven her necklace?");
	}

	if(item_amount($item[Spookyraven Library Key]) == 1)
	{
			print("Well, we need writing desks", "blue");
			print("Going to the liberry!", "blue");
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
		if (0 < numeric_modifier("combat rate")) return false;
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
		int progress = to_int(get_property("manorDrawerCount"));
		print("Looking for the Billards Room key: Progress " + progress + "/24", "blue");
		if (progress < 21) {
			//TODO:  demonskin trousers?  asshat?  (anything else?)
			maximize("hot res, stench res", 1, 0, false);
		} else {
			maximize("exp", 1, 0, false);
		}
		buffMaintain($effect[Hide of Sobek], 10, 1, 1);
		ccAdv(1, $location[The Haunted Kitchen]);
		if (21 <= progress && 0 == item_amount($item[Spookyraven Billiards Room Key]))
		{
			cli_execute("refresh inv");
			if(item_amount($item[Spookyraven Billiards Room Key]) == 0)
			{
				print("We think you've opened enough drawers in the kitchen but you don't have the Billiards Room Key.", "red");
				wait(10);
			}
		}
	}
	
	return true;
}

void ed_configureOutInTheGarden() {
	if (
		(
			!possessEquipment($item[serpentine sword]) && !possessEquipment($item[snake shield])
			&& have_skill($skill[Wrath of Ra])
			&& 0 == have_effect($effect[Everything Looks Yellow])
		) || (
			(!possessEquipment($item[serpentine sword]) || !possessEquipment($item[snake shield]))
			&& have_skill($skill[Lash of the Cobra])
			&& my_basestat($stat[SubMysticality]) < 20000
		)
	) {
		//TODO:  are the conditions above likely to waste adventures fighting the knight, when we could be getting experience directly from the other non-combat?  20000 is quite likely too high, and the Ra branch should probably have an xp limit, too.
		set_property("choiceAdventure89", "2");
	}
	else
	{
		set_property("choiceAdventure89", "6");
	}
}

boolean LX_spookyravenSecond()
{
	if(get_property("ed_spookyravensecond") == "finished")
	{
		return false;
	}
	if(get_property("ed_spookyravennecklace") != "finished")
	{
		return false;
	}
	if(get_property("lastSecondFloorUnlock") == 0)
	{
		return false;
	}
	
	print("Starting Spookyraven Second Floor.", "blue");
	set_property("choiceAdventure876", "2");
	set_property("choiceAdventure877", "1");
	set_property("choiceAdventure878", "3");
	set_property("choiceAdventure879", "1");
	set_property("choiceAdventure880", "1");
//Handle lights-out
	set_property("choiceAdventure897", "2");
	set_property("choiceAdventure896", "1");
	set_property("choiceAdventure892", "2");

	if((item_amount($item[Lady Spookyraven\'s Powder Puff]) == 1) && (item_amount($item[Lady Spookyraven\'s Dancing Shoes]) == 1) && (item_amount($item[Lady Spookyraven\'s Finest Gown]) == 1))
	{
		print("Finished Spookyraven, just dancing with the lady.", "blue");
		visit_url("place.php?whichplace=manor2&action=manor2_ladys");
		ccAdv(1, $location[The Haunted Ballroom]);
		if(contains_text(get_property("lastEncounter"), "Lights Out in the Ballroom"))
		{
			ccAdv(1, $location[The Haunted Ballroom]);
		}
		visit_url("place.php?whichplace=manor3");
		set_property("ed_ballroomopen", "open");
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
	ed_configureOutInTheGarden();

	if(get_property("ed_ballroomopen") == "open")
	{
		if((item_amount($item[Lord Spookyraven\'s Spectacles]) == 1) && (item_amount($item[Disposable Instant Camera]) == 1))
		{
			set_property("ed_spookyravensecond", "finished");
		}
		else
		{
			if(item_amount($item[Lord Spookyraven\'s Spectacles]) == 0)
			{
				print("Need Spectacles, damn it.", "blue");
				set_property("choiceAdventure878", "3");
				LX_spookyBedroomCombat();
				print("Finished 1 Spookyraven Bedroom Spectacle Sequence", "blue");
			}
			if(item_amount($item[Disposable Instant Camera]) == 0)
			{
				print("Need Spectacles, damn it.", "blue");
				set_property("choiceAdventure878", "4");
				LX_spookyBedroomCombat();
				print("Finished 1 Spookyraven Bedroom Spectacle Sequence", "blue");
			}
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
			if(my_mp() < 40)
			{
				while(my_meat() > 89 && my_mp() < 40)
				{
					buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
					use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				}
				
				if(my_mp() < 40)
				{
					abort("Couldn't restore your MP before attempting to YR at the gallery");
				}
			}
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
	if(get_property("ed_maurice") != "")
	{
		return false;
	}
	if(get_property("ed_spookyravennecklace") != "finished")
	{
		return false;
	}
	if(get_property("ed_mcmuffin") != "start")
	{
		return false;
	}
	if(my_level() < 11)
	{
		return false;
	}

	if(get_property("ed_ballroomflat") == "")
	{
		print("Searching for the basement of Spookyraven", "blue");
		set_property("choiceAdventure106", "1");
		set_property("choiceAdventure90", "3");
		maximize("exp, -combat", 1, 0, false);
		
		if(!ccAdv(1, $location[The Haunted Ballroom]))
		{
			visit_url("place.php?whichplace=manor2");
			//print("If 'That Area is not available', mafia isn't recognizing it without a visit to manor2, not sure why.", "red");
		}
		if(contains_text(get_property("lastEncounter"), "We\'ll All Be Flat"))
		{
			set_property("ed_ballroomflat", "finished");
		}
		return true;
	}
	if(item_amount($item[recipe: mortar-dissolving solution]) == 0)
	{
		equip($slot[acc3], $item[Lord Spookyraven\'s Spectacles]);
		visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		use(1, $item[recipe: mortar-dissolving solution]);

		#Cellar, laundry room Lights out ignore
		set_property("choiceAdventure901", "2");
		set_property("choiceAdventure891", "1");
	}

	if((item_amount($item[blasting soda]) == 1) && (item_amount($item[bottle of Chateau de Vinegar]) == 1))
	{
		print("Time to cook up something explosive! Science fair unstable fulminate time!", "green");
		craft("cook", 1, $item[bottle of Chateau de Vinegar], $item[blasting soda]);
		set_property("ed_winebomb", "partial");
	}

	if(possessEquipment($item[Unstable Fulminate]))
	{
		set_property("ed_winebomb", "partial");
	}

	if((item_amount($item[bottle of Chateau de Vinegar]) == 0) && (get_property("ed_winebomb") == ""))
	{
		print("Searching for vinegar", "blue");
		maximize("0.5 exp, item drop", 1, 0, false);
		ccAdv(1, $location[The Haunted Wine Cellar]);
		return true;
	}
	if((item_amount($item[blasting soda]) == 0) && (get_property("ed_winebomb") == ""))
	{
		print("Searching for baking soda, I mean, blasting pop.", "blue");
		maximize("0.5 exp, item drop", 1, 0, false);
		ccAdv(1, $location[The Haunted Laundry Room]);
		return true;
	}

	if(get_property("ed_winebomb") == "partial")
	{
		print("Now we mix and heat it up.", "blue");
		maximize("ML 100 max, equip unstable fulminate", 0, 0, false);
		ccAdv(1, $location[The Haunted Boiler Room]);

		if(item_amount($item[wine bomb]) == 1)
		{
			set_property("ed_winebomb", "finished");
			visit_url("place.php?whichplace=manor4&action=manor4_chamberwall");
		}
		return true;
	}

	if(get_property("ed_winebomb") == "finished")
	{
		print("Down with the brick wall of Spookyraven!", "blue");
		visit_url("place.php?whichplace=manor4&action=manor4_chamberboss");
		cli_execute("refresh inventory");
		if(item_amount($item[7962]) == 0)
		{
			set_property("ed_maurice", "finished");
		}
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
	if(!get_property("ed_getDinseyGarbageMoney").to_boolean())
	{
		return false;
	}
	if(get_property("ed_dinseyGarbageMoney").to_int() == my_daycount())
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
	if(get_property("ed_sonata") == "finished")
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) < 5)
	{
		return false;
	}
	if(get_property("ed_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 64))
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
	set_property("ed_sonata", "finished");
	return true;
}

boolean L12_gremlinStart()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("ed_gremlins") != "")
	{
		return false;
	}
	print("Gremlin prep", "blue");
	set_property("ed_gremlins", "start");
	return true;
}

boolean L12_gremlins()
{
	if(get_property("ed_gremlins") != "start")
	{
		return false;
	}
	if(get_property("sidequestJunkyardCompleted") != "none")
	{
		return false;
	}
	if(get_property("ed_hippyInstead").to_boolean() && (get_property("fratboysDefeated").to_int() < 192))
	{
		return false;
	}
	if(get_property("warProgress") == "finished")
	{
		return false;
	}

	#Put a different shield in here.
	print("Doing them gremlins", "blue");
	
	set_property("edDefeatAbort", "5");
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
	set_property("ed_gremlins", "finished");
	return true;
}


boolean L12_sonofaBeach()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("ed_sonata") == "finished")
	{
		return false;
	}
	if(item_amount($item[barrel of gunpowder]) >= 5)
	{
		return false;
	}
	if(get_property("sidequestLighthouseCompleted") != "none")
	{
		set_property("ed_sonata", "finished");
		return true;
	}

	if ((item_amount($item[Talisman of Horus]) == 0) && (have_effect($effect[Taunt of Horus]) == 0))
	{
		abort("We ran out of horus talismen for the beach, such bad luck!");
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
		set_property("ed_doCombatCopy", "yes");
	}

	//TODO:  is ed_preadventure supposed to take care of these?
	buffMaintain($effect[Hippy Stench], 0, 1, 1);
	if (0 == have_effect($effect[taunt of horus]) && 0 < item_amount($item[talisman of horus])) {
		use(1, $item[talisman of Horus]);
	}

	try {
		set_property("autoAbortThreshold", "-0.05");
		//set_property("hpAutoRecovery", "-0.05");
		ccAdv(1, $location[Sonofa Beach]);
	} finally {
		//TODO:  does the autoAbortThreshold setting above prevent any auto-stops here?
		set_property("ed_doCombatCopy", "no");

		if(my_hp() == 0)
		{
			use(1, $item[Linen Bandages]);
		}
		return true;
	}
}

boolean L12_filthworms()
{
	if(my_level() < 12)
	{
		return false;
	}
	if(get_property("ed_orchard") != "start")
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
			set_property("ed_orchard", "done");
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
	if(get_property("ed_orchard") != "")
	{
		return false;
	}
	if((get_property("hippiesDefeated").to_int() < 64) && !get_property("ed_hippyInstead").to_boolean())
	{
		return false;
	}

	warOutfit();
	visit_url("bigisland.php?place=orchard&action=stand&pwd");
	set_property("ed_orchard", "start");
	return true;
}

boolean L12_orchardFinalize()
{
	if(get_property("ed_orchard") != "done")
	{
		return false;
	}
	set_property("ed_orchard", "finished");

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
	if(get_property("ed_castletop") != "")
	{
		return false;
	}
	set_property("choiceAdventure676", 3);
	set_property("choiceAdventure678", 4);
	string extra;
	if((item_amount($item[Mohawk Wig]) > 0))
	{
		if(my_basestat($stat[Moxie]) < 55) return false;
		extra = ", equip mohawk wig";
		set_property("choiceAdventure676", 4);
		set_property("choiceAdventure678", 1);
	}

	print("Castle Top Floor", "blue");
	maximize("exp, -combat" + extra, 0, 0, false);
	set_property("choiceAdventure675", 3);
	if((item_amount($item[drum 'n' bass 'n' drum 'n' bass record]) > 0))
	{
		set_property("choiceAdventure675", 2);
	}
	set_property("choiceAdventure677", 1);
	set_property("choiceAdventure679", 2);
	
	ccAdv(1, $location[The Castle in the Clouds in the Sky (Top Floor)]);

	if(contains_text(get_property("lastEncounter"), "Keep On Turnin\' the Wheel in the Sky"))
	{
		set_property("ed_castletop", "finished");
		council();
	}
	if(contains_text(get_property("lastEncounter"), "Copper Feel"))
	{
		set_property("ed_castletop", "finished");
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
	if(get_property("ed_castleground") != "")
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
		set_property("ed_castleground", "finished");
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
	if(get_property("ed_castlebasement") != "")
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
	set_property("choiceAdventure670", "5");  //FIXME:  choice 5 is not valid, says Mafia.  Why does this seem to work??
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
		set_property("ed_castlebasement", "finished");
	}
	else if(contains_text(get_property("lastEncounter"), "You Don\'t Mess Around with Gym"))
	{
		print("Just messed with Gym", "blue");
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
		set_property("ed_castlebasement", "finished");
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
		set_property("ed_airship", "finished");
	}
	if(get_property("ed_airship") != "")
	{
		return false;
	}

	visit_url("place.php?whichplace=beanstalk");
	print("Fantasy Airship Fly Fly time", "blue");

	if(item_amount($item[model airship]) == 0)
	{
		set_property("choiceAdventure182", "4");
	}
	else
	{
		set_property("choiceAdventure182", "1");
	}
	
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
	if((my_level() < 7) || (get_property("ed_crypt") != ""))
	{
		return false;
	}
	if(item_amount($item[chest of the bonerdagon]) == 1)
	{
		set_property("ed_crypt", "finished");
		use(1, $item[chest of the bonerdagon]);
		return false;
	}

	if (my_spleen_use() < spleen_limit() && item_amount($item[Ka coin]) + my_adventures() < 15) {
		print("Delaying the Cyrpt due to low Ka & adventures", "red");
	}

	boolean noTauntActive = 0 == have_effect($effect[Taunt of Horus]) && 0 == have_effect($effect[Hippy Stench]);
	//buffMaintain($effect[Browbeaten], 0, 1, 1);
	buffMaintain($effect[Rosewater Mark], 0, 1, 1);  //TODO:  ?
	if (
		(get_property("cyrptAlcoveEvilness").to_int() > 26)
		&& have_skill($skill[More Legs])
		&& ((my_maxhp() > 50) || (elemental_resist($element[spooky]) > 3))
		&& noTauntActive
	)
	{
		print("The Alcove! (" + initiative_modifier() + ") init.", "blue");
		buyUpTo(1, $item[third-hand lantern]);
		maximize("initiative, 0.25 exp, -combat", 0, 0, false);
		//TODO:  Shelter of Shed?  I guess preadventure does that?  does it?
		//TODO:  Hustlin'
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buyUpTo(1, $item[Hair Spray]);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buffMaintain($effect[Well-Swabbed Ear], 0, 1, 1);
		buffMaintain($effect[Sepia Tan], 0, 1, 1);
		ccAdv(1, $location[The Defiled Alcove]);
		return true;
	}
	if (
		(get_property("cyrptAlcoveEvilness").to_int() > 0)
		&& ((my_maxhp() > 50) || (elemental_resist($element[spooky]) > 3))
	)
	{
		print("The Alcove boss! (or maybe the last guy before him?)", "blue");
		maximize("exp", 0, 0, false);
		ccAdv(1, $location[The Defiled Alcove]);
		return true;
	}

	if (
		0 < get_property("cyrptNookEvilness").to_int()
	) {
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

	if(get_property("cyrptCrannyEvilness").to_int() > 26 && noTauntActive)
	{
		print("The Cranny!", "blue");
		maximize("ml, -combat", 0, 0, false);
		set_property("choiceAdventure523", "4");
		//buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		//buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		//buyUpTo(1, $item[Hair Spray]);
		//buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		ccAdv(1, $location[The Defiled Cranny]);
		
		return true;
	}
	if (
		0 < get_property("cyrptCrannyEvilness").to_int()
		&& get_property("cyrptCrannyEvilness").to_int() <= 26
	) {
		print("The Cranny boss! (okay, yeah, or maybe the last guy before him.)", "blue");
		maximize("exp", 0, 0, false);
		set_property("choiceAdventure523", "5");
		ccAdv(1, $location[The Defiled Cranny]);

		return true;
	}

	if(get_property("cyrptTotalEvilness").to_int() <= 0)
	{
		boolean tryBoner = ccAdv(1, $location[Haert of the Cyrpt]);
		if(item_amount($item[chest of the bonerdagon]) == 1)
		{
			set_property("ed_crypt", "finished");
			use(1, $item[chest of the bonerdagon]);
		}
		else if(!tryBoner)
		{
			print("We tried to kill the Bonerdagon because the cyrpt was defiled but couldn't adventure there and the chest of the bonerdagon is gone so we can't check that. Anyway, we are going to assume the cyrpt is done now.", "red");
			set_property("ed_crypt", "finished");
		}
		else
		{
			abort("Failed to kill bonerdagon");
		}
		return true;
	}
	return false;
}

boolean ed_LX_legDay()
{
	if (0 == item_amount($item[Dingy Dinghy])) {
		return false;
	}
	if(!have_skill($skill[Upgraded Legs]))
	{
		set_property("ed_legsbeforebread", "true");  //TODO:  now that i'm working on smooch support, defer legs until after consumption organs?
	}

	if(item_amount($item[Ka Coin]) < 10 && !have_skill($skill[Upgraded Legs]))
	{
		if(jump_chance($monster[Rushing Bum]) < 70 && my_maxhp() < 30)
		{
			change_mcd(3);
		}

		print("Getting ka to upgrade legs.", "blue");
		ccAdv(1, $location[the sleazy back alley]);
		return true;
	}

	print("Doing leg-day.", "blue");

	string extra;
	if (jump_chance($monster[filthy hippy]) < 50) {
		change_mcd(0);  //TODO:  does it make a difference?
		extra = ", init";
		buyUpTo(1, $item[third-hand lantern]);
		//TODO:  Hustlin'?
	} else {
		handleMCD();  //TODO: (isn't that the default?)
	}
	maximize("exp, -equip filthy knitted dread sack" + extra, min(my_meat(), 100), 1, false);

	buffMaintain($effect[Wisdom of Thoth], 15, 1, 1);
	//buffMaintain($effect[Power of Heka], 15, 1, 1);
	// note that once we have wisdom of thoth, we defeat them with a single spell, crit or otherwise.  (is that really true?  even at low mys & no +damage astral item?  What if we have, say, Lapdog in effect?)
	buffMaintain($effect[Bounty of Renenutet], 35, 1, 1);
	if (300 < my_meat()) buffMaintain($effect[Blessing of Serqet], 30, 1, 1);
	if (600 < my_meat()) buffMaintain($effect[Purr of the Feline], 25, 1, 1);
	set_property("edDefeatAbort", "3");
	ccAdv(1, $location[Hippy Camp]);
	return true;
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
	if(get_property("ed_dickstab").to_boolean())
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

boolean ed_smoochQuestToday() {
	if (to_boolean(get_property("ed_smoochQuestDay" + my_daycount()))) return true;
	if (to_boolean(get_property("ed_smoochQuestEveryDay"))) return true;
	return false;
}

int ed_smoochTurnsToday() {
	if ("" == get_property("ed_dayOfSmoochAdventureCount")) return 0;
	if (my_daycount() != to_int(get_property("ed_dayOfSmoochAdventureCount"))) return 0;
	return $location[The SMOOCH Army HQ].turns_spent
		- to_int(get_property("ed_smoochAdventureCount"));
}

boolean ed_LX_smooch()
{
	// collect Ka and/or complete a quest at the SMOOCH Army HQ.
	if (!elementalPlanes_access($element[hot])) {
		return false;
	}
	maximize("exp, 0.5 mys", 1, 0, false);
	if (ed_smoochTurnsToday() < 40 || 50 < ed_smoochTurnsToday() || !ed_smoochQuestToday()) {
		//  this should avoid Serqet for bosses.
		buffMaintain($effect[Blessing of Serqet], 0, 1, 1);
	}
	buffMaintain($effect[Bounty of Renenutet], 0, 1, 1);
	buffMaintain($effect[Purr of the Feline], 0, 1, 1);
	//TODO:  Is Purr of the Feline automatically maintained, when appropriate?  (Yes, I believe so.)
	buffMaintain($effect[Glittering Eyelashes], 0, 1, 1);
	if (10000 < my_meat()) buffMaintain($effect[Erudite], 0, 1, 1);
	if (0 < item_amount($item[CSA bravery badge])) cli_execute("use CSA bravery badge");
	if (0 == ed_smoochTurnsToday()) {
		set_property("ed_dayOfSmoochAdventureCount", my_daycount());
		set_property("ed_smoochAdventureCount", $location[The SMOOCH Army HQ].turns_spent);

		//buffMaintain($effect[Lapdog], 0, 1, 1);
		if (!to_boolean(get_property("_olympicSwimmingPool"))) cli_execute("swim laps");
		//buffMaintain($effect[Thaumodynamic], 0, 1, 1);
		if (!to_boolean(get_property("_aprilShower"))) cli_execute("shower lukewarm");
	}
	if (50 == ed_smoochTurnsToday()) {
		//TODO:  is there a reasonable strategy to beat the bosses?  current ed_combat.ash cast an ineffective Curse of Indecision....  But I think that without the +ML, it may be a reasonable fight.  I think the only times I've beaten one of them involved a good deal of luck.  More Legs?  DR/DA upgrades?
		//       Yes, with 0 ML, Pener fell to a single (albeit critical) Storm of the Scarab.  Got the jump, too.
		//TODO:  also, when does the choice adventure re-appear, if we get beaten up by the boss?
		buffMaintain($effect[Power of Heka], 0, 1, 1);
		if (ed_smoochQuestToday()) {
			ed_selectSmoochDoor();
		} else {
			set_property("choiceAdventure1094", "5");
		}
		maximize("mys", 1, 0, false);
		change_mcd(0);
	}
	ccAdv(1, $location[The SMOOCH Army HQ]);
	return true;
}

boolean ed_LX_smoochQuest() {
	if (!ed_smoochQuestToday()) return false;
	if (51 < ed_smoochTurnsToday()) return false;
	if (!ed_smoochQuestAvailable()) return false;
	if (1 < my_daycount()) ed_use_servant($servant[scribe]);  //TODO:  this is currently overridden by the ed_handleAdventureServant logic.
	if (!ed_LX_smooch()) return false;
	if (ed_smoochQuestItemAvailable()) ed_turnInVolcanoQuestItem();
	return true;
}

boolean L1_edVacation(int dickstabOverride)
{
	if(!get_property("spookyAirportAlways").to_boolean())
	{
		return false;
	}
	
	skill blocker = $skill[Still Another Extra Spleen];
	if(get_property("ed_dickstab").to_boolean())
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
	// collect Ka wherever we can.
	if(elementalPlanes_access($element[spooky]))
	{
		return false;
	}
	//if (have_skill($skill[More Legs]) && 35 == my_spleen_use()) return false;
	if (35 == my_spleen_use() && 5 == fullness_limit() && 4 == inebriety_limit()) return false;
	if((my_level() >= 10) || ((my_level() >= 7) && have_skill($skill[Still Another Extra Spleen])))
		//TODO:  relax the above test?
	{
		float kaPerAdventure = 0.5;
		int budget = item_amount($item[Ka coin]) + kaPerAdventure * (my_adventures() - 5);
		if (45 <= budget) return false;
			// with our current ka & adventures, we already expect to buy (at least) the next
			// spleen, plus a haunch to fill it.
		if (
			my_spleen_use() + 5 <= spleen_limit()
			&& (0 < item_amount($item[mummified beef haunch])
				|| 15 <= budget)
		) return false;
			// with our current ka & adventures, we already expect to chew at least one more haunch.
	}
	if(elementalPlanes_access($element[stench]))
	{
		L1_edDinsey();
	}
	int reodorantNeeded = ceil(
		("finished" != get_property("questL08Trapper") ? 1.5 : 0)
		+ ("none" == get_property("sidequestLighthouseCompleted") ? 1.5 : 0) );
	//TODO:  reodorant only saves a few adventures, and doesn't drop much.  Make sure we aren't favoring it too strongly.
	if (reodorantNeeded <= item_amount($item[reodorant]) && ed_LX_smooch()) return true;
	//TODO:  also, if (elementalPlanes_access($element[sleaze]))
	if (ed_LX_islandAccess()) return true;
	if (ed_LX_legDay()) return true;
	print("We need to gather Ka, but we don't have island access.", "red");
	ccAdv(1, $location[the sleazy back alley]);
	return true;
}

boolean L6_friarsGetParts()
{
	if((my_level() < 6) || (get_property("ed_friars") != ""))
	{
		return false;
	}

	if (my_spleen_use() < spleen_limit() && item_amount($item[Ka coin]) + my_adventures() < 15) {
		print("Delaying the Friars due to low Ka & adventures", "red");
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

	if((item_amount($item[hot wing]) < 3) && (get_property("questM12Pirate").to_int() < 3))
	{
		print("Need more Hot Wings", "blue");
		ccAdv(1, $location[The Dark Heart of the Woods]);
		return true;
	}
	
	print("Finishing friars", "blue");
	visit_url("friars.php?action=ritual&pwd");
	council();
	set_property("ed_friars", "finished");
	return false;
}

boolean L8_trapperYeti()
{
	if(get_property("ed_trapper") != "yeti")
	{
		return false;
	}

	if((item_amount($item[Ninja Rope]) > 0) && (item_amount($item[Ninja Carabiner]) > 0) && (item_amount($item[Ninja Crampons]) > 0))
	{
		if (elemental_resist($element[cold]) + (0 == have_effect($effect[Hide of Sobek]) ? 1 : 0) >= 5)
		{
			//TODO:  Oil of Parrrlay?
			buffMaintain($effect[Hide of Sobek], 10, 1, 1);
			if(get_property("ed_mistypeak") == "")
			{
				visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
				visit_url("place.php?whichplace=mclargehuge&action=cloudypeak");
				set_property("ed_mistypeak", "finished");
			}

			print("Time to take out Gargle", "blue");
			visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
			string questStatus = get_property("questL08Trapper");
			if ("finished" == questStatus) questStatus = "step5";
			if ("step" == questStatus.substring(0,4)) questStatus = substring(questStatus, 4);
			if((item_amount($item[Winged Yeti Fur]) == 0) && (questStatus.to_int() < 5))
			{
				ccAdv(1, $location[Mist-shrouded Peak]);
			}
			else
			{
				set_property("ed_trapper", "finished");
				council();
			}
			return true;
		}
	}
	else
	{
		if((have_effect($effect[taunt of horus]) == 0) && (item_amount($item[talisman of horus]) == 0))
		{
			print("No +combat = no assassins, delaying...", "blue");
			return false;
		}
		int effectRemovalItems = item_amount($item[ancient cure-all]) + item_amount($item[soft green echo eyedrop antidote]);
		if (0 < have_effect($effect[Shelter Of Shed]))
		{
			print("We don't want Shelter of Shed for ninja snowmen.  Delaying...", "blue");
			return false;
		}

		buffMaintain($effect[Hide of Sobek], 0, 1, 1);
		buyUpTo(1, $item[hair spray]);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		buyUpTo(1, $item[Ben-Gal&trade; Balm]);
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);

		if (possessEquipment($item[The Crown of Ed the Undying]))
		{
			adjustEdHat("weasel");
			//TODO:  is that really the only preparation needed?  Have I inadvertently removed something?
		} else if (
			jump_chance($monster[ninja snowman assassin]) < 90
			&& my_maxhp() <= ed_assassinDamage()
		) {
			if (0 < have_effect($effect[Blessing of Serqet]) && effectRemovalItems < 1) {
				print("We don't want Blessing of Serqet for ninja snowmen, and can't remove it.  Delaying...", "blue");
				return false;
			}
			maximize("-ml, 0.1 hp, cold res, init", 1, 0, false);
			change_mcd(0);

			if (jump_chance($monster[ninja snowman assassin]) < 70 && my_maxhp() <= ed_assassinDamage()) {
				if (!uneffect($effect[Blessing of Serqet])) {
					print("Could not uneffect Blessing of Serqet for ninja snowmen, delaying until you can survive an encounter...", "red");
					handleMcd();
					maximize("exp", 1, 0, false);
					return false;
				}
				if (my_maxhp() < ed_assassinDamage()) {
					//FIXME:  it would have been nice to detect this before using an SGEAA item!
					print("Delaying snowmen until you can survive an encounter...", "red");
					handleMcd();
					maximize("exp", 1, 0, false);
					return false;
				}
			}
		}

		buffMaintain($effect[Well-Swabbed Ear], 0, 1, 1);
		buffMaintain($effect[Sepia Tan], 0, 1, 1);
		//TODO:
		//buffMaintain($effect[Hustlin'], 0, 1, 1);
		print("Anticipated assassin damage:  " + ed_assassinDamage(), "orange");
		if (jump_chance($monster[ninja snowman assassin]) < 90 && my_maxhp() <= ed_assassinDamage()) {
			print("Failed to prepare properly for ninja snowman assassins!", "red");
abort("WHM testing");
			return false;
		}
		buffMaintain($effect[Hippy Stench], 0, 1, 1);
		if (0 == have_effect($effect[taunt of horus]) && 0 < item_amount($item[talisman of horus])) {
			use(1, $item[talisman of Horus]);
		}
		ccAdv(1, $location[Lair of the Ninja Snowmen]);
		maximize("exp", 1, 0, false);
		return true;
	}
	return false;
}

boolean L8_trapperGround()
{
	if(get_property("ed_trapper") != "start")
	{
		return false;
	}
	
	item oreGoal = to_item(get_property("trapperOre"));
	if((item_amount(oreGoal) >= 3) && (item_amount($item[goat cheese]) >= 3))
	{
		print("Giving Trapper goat cheese and " + oreGoal, "blue");
		visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
		set_property("ed_trapper", "yeti");
		return true;
	}

	if(item_amount($item[goat cheese]) < 3)
	{
		print("Yay for goat cheese!", "blue");
		if (get_property("friarsBlessingReceived") == "false") {
			cli_execute("friars food");
		}
		ccAdv(1, $location[The Goatlet]);
		return true;
	}
	if((item_amount(oreGoal) < 3) && (item_amount($item[Disassembled Clover]) > 0))
	{
		print("Starting Trapper Ore Collection", "blue");
		use(1, $item[Disassembled Clover]);
		if(ccAdvBypass(270, $location[Itznotyerzitz Mine]))
		{
			print("Wandering monster interrupt at Itznotyerzitz Mine", "red");
			return true;
		}

		use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		return true;
	}
	
	return false;
}

boolean L8_trapperStart()
{
	if((my_level() < 8) || (get_property("ed_trapper") != ""))
	{
		return false;
	}
	
	print("Let's meet the trapper.", "blue");
	council();
	visit_url("place.php?whichplace=mclargehuge&action=trappercabin");
	set_property("ed_trapper", "start");
	return true;
}

boolean L5_goblinKing()
{
	if(get_property("ed_goblinking") == "finished")
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

	//print("Death to the gobbo!! If you want a specific drop, please reset your MCD now.", "blue");
	//wait(15);
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
		set_property("ed_goblinking", "finished");
		council();
	}
	return true;
}

boolean L4_batCave()
{
	if(get_property("ed_bat") == "finished")
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
			set_property("ed_bat", "finished");
		}
		return true;
	}
	
	if(contains_text(batHole, "bathole_bg3"))
	{
		if(have_skill($skill[Wrath of Ra]) && (have_effect($effect[Everything Looks Yellow]) == 0))
		{
			if(my_mp() < 40)
			{
				while(my_meat() > 89 && my_mp() < 40)
				{
					buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
					use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				}
			}
		}
		
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

boolean ed_LX_islandAccess()
{
	if (
		item_amount($item[Dingy Dinghy]) == 0
		&& (3 <= item_amount($item[Shore Inc. Ship Trip Scrip]) || 0 < item_amount($item[dinghy plans]))
		&& (400 <= my_meat() || 0 < item_amount($item[dingy planks]))
	) {
		ed_acquire(1, $item[dinghy plans]);
		ed_acquire(1, $item[dingy planks]);
		use(1, $item[dinghy plans]);
		return true;
	}
	if(item_amount($item[Dingy Dinghy]) > 0)
	{
		return false;
	}
	if((my_adventures() <= 3) || (my_meat() <= 600))
	{
		print("You should be going to the shore right now, but you're a little short on time or cash to do this.  We will try again later.", "red");
		return false;
	}
	if(get_counters("Fortune Cookie", 0, 3) == "Fortune Cookie")
	{
		//Just check the Fortune Cookie counter not any others.
		return false;
	}

	print("At the shore, la de da!", "blue");
	maximize("mp", 0, 0, false);
	buffMaintain($effect[Wisdom of Thoth], 0, 1, 4);
	set_property("choiceAdventure793", "2");
	int scripBefore = item_amount($item[Shore Inc. Ship Trip Scrip]);
	if((item_amount($item[Shore Inc. Ship Trip Scrip]) < 3) && (my_meat() > 500))
	{
		set_property("ed_disableAdventureHandling", "yes");
		ccAdv(1, $location[The Shore\, Inc. Travel Agency]);
		set_property("ed_disableAdventureHandling", "no");
	}
	if(item_amount($item[Shore Inc. Ship Trip Scrip]) == scripBefore)
	{
		print("Failed to get enough Shore Scrip for some reason.  Trying something else....", "red");
		return false;
	}
	ed_buySkills();
	return true;
}

boolean L2_treeCoin()
{
	if(get_property("ed_treecoin") == "finished")
	{
		return false;
	}
	print("Time for a tree-holed coin", "blue");
	set_property("choiceAdventure502", "2");
	set_property("choiceAdventure505", "2");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[tree-holed coin]) == 1)
	{
		set_property("ed_treecoin", "finished");
	}
	return true;
}

boolean L2_spookyMap()
{
	if(get_property("ed_spookymap") == "finished")
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
		set_property("ed_spookymap", "finished");
	}
	return true;
}

boolean L2_spookyFertilizer()
{
	if(get_property("ed_spookyfertilizer") == "finished")
	{
		return false;
	}
	print("Need a some poop, I mean fertilizer now", "blue");
	set_property("choiceAdventure502", "3");
	set_property("choiceAdventure506", "2");
	ccAdv(1, $location[the spooky forest]);
	if(item_amount($item[Spooky-Gro Fertilizer]) == 1)
	{
		set_property("ed_spookyfertilizer", "finished");
	}
	return true;
}

boolean L2_spookySapling()
{
	if(get_property("ed_spookysapling") == "finished")
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

	//TODO:  need to do servant switching, maintain buffs, etc.
#	cli_execute("aa none");
	if(contains_text(visit_url("adventure.php?snarfblat=15"), "Combat"))
	{
		//TODO:  ccAdv does servant switching & buff maintenance, which produces "You are currently in a fight."  get rid of that.
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
			set_property("ed_spookysapling", "finished");
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
	if(get_property("ed_mosquito") == "finished")
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
		set_property("ed_mosquito", "finished");
	}
	return true;
}

boolean L5_getEncryptionKey()
{
	if(get_property("ed_day1_cobb") == "finished")
	{
		return false;
	}
	
	maximize("exp", 0, 0, false);
	if((jump_chance($monster[Knob Goblin Barbecue Team]) < 50 && my_maxhp() < 30))
	{
		change_mcd(3);
		maximize("exp, -ml", 0, 0, false);
	}
	print("Looking for the knob.", "blue");
	if (0 == item_amount($item[Knob Goblin Encryption Key])) {
		ccAdv(1, $location[the outskirts of cobb\'s knob]);
		cli_execute("refresh inventory");
	}

	if(item_amount($item[Knob Goblin Encryption Key]) == 1)
	{
		set_property("ed_day1_cobb", "finished");
		council();
	}
	return true;
}

boolean LX_getLunchbox() {
	if(get_counters("Semirare window end", 0, 10) == "Semirare window end") {
		return L5_getEncryptionKey();
	}
	return false;
}

boolean ed_LX_lightsOut() {
	if (get_counters("Spookyraven Lights Out", 0, 0) == "Spookyraven Lights Out") {
		location l = to_location(get_property("nextSpookyravenStephenRoom"));
		if ($location[The Haunted Laboratory] == l) l = to_location(get_property("nextSpookyravenElizabethRoom"));
		if ($locations[none, The Haunted Gallery] contains l) return false;
		string oldSetting = get_property("lightsOutAutomation");
		set_property("lightsOutAutomation", "1");
		try {
			buffer page = visit_url(to_url(l) + "&confirm=on");
			if (contains_text(page, "Combat")) abort("Spookyraven Lights Out quest automation failure!");
			//ccAdv(0, l);
			adv1(l, 0, "");
		} finally {
			set_property("lightsOutAutomation", oldSetting);
		}
	}
	return false;
}

boolean L12_startWar()
{
	if(get_property("ed_prewar") != "")
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
		visit_url("bigisland.php?action=junkman&pwd");
		visit_url("bigisland.php?place=concert&pwd");
		set_property("ed_prewar", "started");
	}
	return true;
}

boolean L12_hippyOutfit()
{
	if(item_amount($item[Dingy Dinghy]) == 0)
	{
		return false;
	}
	if(possessEquipment($item[Filthy Knitted Dread Sack]) && possessEquipment($item[Filthy Corduroys]))
	{
		set_property("ed_hippyOutfit", "finished");
		return false;
	}
	if(have_skill($skill[Wrath of Ra]) && !get_property("ed_legsbeforebread").to_boolean())
	{
		if(have_effect($effect[Everything Looks Yellow]) != 0)
		{
			return false;
		}
		if(my_mp() < 40)
		{
			while(my_meat() > 89 && my_mp() < 40)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			
			if(my_mp() < 40)
			{
				return false;
			}
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

boolean L12_getOutfit()
{
	if(get_property("ed_fratWarOutfit") == "finished")
	{
		return false;
	}
	if(possessEquipment($item[beer helmet]) && possessEquipment($item[bejeweled pledge pin]) && possessEquipment($item[distressed denim pants]))
	{
		set_property("choiceAdventure139", "3");
		set_property("choiceAdventure140", "3");
		set_property("choiceAdventure141", "3");
		set_property("choiceAdventure142", "3");
		set_property("ed_fratWarOutfit", "finished");
		return false;
	}

	maximize("exp", 0, 0, false);
	outfit("filthy hippy disguise");
	
	if(have_skill($skill[Wrath of Ra]) && have_effect($effect[Everything Looks Yellow]) == 0)
	{
		if(my_mp() < 40)
		{
			while(my_meat() > 89 && my_mp() < 40)
			{
				buyUpTo(1, $item[Doc Galaktik\'s Invigorating Tonic]);
				use(1, $item[Doc Galaktik\'s Invigorating Tonic]);
			}
			
			if(my_mp() < 40)
			{
				return false;
			}
		}
	}
	else
	{
		if (have_skill($skill[Wrath of Ra])) return false;  // (wait for cooldown to end)
	}

	ccAdv(1, $location[Wartime Frat House]);
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

	print("Done with this Rock Band crap", "blue");
	outfit("frat warrior fatigues");
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
	if(get_property("ed_highlandlord") == "finished")
	{
		return false;
	}
	if(!get_property("ed_chasmBusted").to_boolean())
	{
		return false;
	}
	if(get_property("ed_highlandlord") == "")
	{
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		set_property("choiceAdventure296", "1");
		set_property("ed_highlandlord", "start");
		return true;
	}
	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire1.gif"))
	{
		set_property("ed_boopeak", "finished");
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

	if((get_property("twinPeakProgress").to_int() == 15) && (get_property("ed_oilpeak") == "finished") && (get_property("ed_boopeak") == "finished"))
	{
		print("Highlord Done", "blue");
		visit_url("place.php?whichplace=highlands&action=highlands_dude");
		council();
		set_property("ed_highlandlord", "finished");
		return true;
	}

	return false;
}

boolean L9_aBooPeak()
{
	if(get_property("ed_boopeak") == "finished")
	{
		return false;
	}
	// Allows you to grab the boo-clues you need before finishing off the peak, so you can get the xp from the ghosts you fight, etc.
	if (to_int(get_property("booPeakProgress")) > 90)
	{
		//FIXME:  after the first 10 adventures, what if we still need more clovers/clues?
		print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
		maximize("item drop, 0.5 exp", 0, 0, false);
		ccAdv(1, $location[A-Boo Peak]);
		return true;
	}

/*
	if(get_property("ed_war") != "finished")
	{
		return false;
	}
*/
	print("A-Boo Peak: " + get_property("booPeakProgress"), "blue");
	if(item_amount($item[a-boo clue]) > 0 && to_int(get_property("booPeakProgress")) > 2)
	{
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		
		if(item_amount($item[Linen Bandages]) == 0)
		{
			return false;
		}

		int coldResist = elemental_resist($element[cold]);
		int spookyResist = elemental_resist($element[spooky]);
		int expectedMaximumHp = my_maxhp();

		foreach s in $slots[] {
			coldResist -= numeric_modifier(equipped_item(s), "cold resistance");
			spookyResist -= numeric_modifier(equipped_item(s), "spooky resistance");
			expectedMaximumHp -= numeric_modifier(equipped_item(s), "Maximum HP");
			expectedMaximumHp -= numeric_modifier(equipped_item(s), "Muscle");
			expectedMaximumHp -= ceil(my_basestat($stat[Muscle]) * numeric_modifier(equipped_item(s), "Muscle Percent") / 100);
		}

		if(possessEquipment($item[The Crown of Ed the Undying]))
		{
			//maximize("spooky res, cold res, equip The Crown of Ed the Undying", 0, 0, false);
			//adjustEdHat("bear");
			foreach i,r in maximize("spooky res, cold res, equip The Crown of Ed the Undying", 0, 0, true, true) {
				coldResist += numeric_modifier(r.item, "cold resistance");
				spookyResist += numeric_modifier(r.item, "spooky resistance");
				expectedMaximumHp += numeric_modifier(r.item, "Maximum HP");
				expectedMaximumHp += numeric_modifier(r.item, "Muscle");
				expectedMaximumHp += ceil(my_basestat($stat[Muscle]) * numeric_modifier(r.item, "Muscle Percent") / 100);
			}
			if (get_property("edPiece") != "bear") expectedMaximumHp += 20;
		} else
		{
			//maximize("spooky res, cold res, 0.075 HP", 0, 0, false);
			foreach i,r in maximize("spooky res, cold res, 0.075 HP", 0, 0, true, true) {
				coldResist += numeric_modifier(r.item, "cold resistance");
				spookyResist += numeric_modifier(r.item, "spooky resistance");
				expectedMaximumHp += numeric_modifier(r.item, "Maximum HP");
				expectedMaximumHp += numeric_modifier(r.item, "Muscle");
				expectedMaximumHp += ceil(my_basestat($stat[Muscle]) * numeric_modifier(r.item, "Muscle Percent") / 100);
			}
		}

		if(item_amount($item[Spooky Powder]) > 0 && 0 == have_effect($effect[Spookypants]))
		{
			spookyResist = spookyResist + 1;
		}
		if(item_amount($item[Cold Powder]) > 0 && 0 == have_effect($effect[Insulated Trousers]))
		{
			coldResist = coldResist + 1;
		}
		if(black_market_available() && (item_amount($item[Can of Black Paint]) == 0) && (have_effect($effect[Red Door Syndrome]) == 0) && (my_meat() >= 1000))
		{
			buyUpTo(1, $item[Can of Black Paint]);
		}
		if(item_amount($item[Can of Black Paint]) > 0 && 0 == have_effect($effect[Red Door Syndrome]))
		{
			spookyResist = spookyResist + 2;
			coldResist = coldResist + 2;
		}
		if(item_amount($item[Oil of Parrrlay]) > 0 && 0 == have_effect($effect[Well-Oiled]))
		{
			spookyResist = spookyResist + 1;
			coldResist = coldResist + 1;
		}
		if(item_amount($item[Pec Oil]) > 0 && 0 == have_effect($effect[Oiled-Up]))
		{
			spookyResist = spookyResist + 2;
			coldResist = coldResist + 2;
		}
		if (
			have_skill($skill[hide of sobek])
			&& 0 == have_effect($effect[Hide of Sobek])
			&& mp_cost($skill[hide of sobek]) + 10 <= my_mp()
		) {
			spookyResist = spookyResist + 1;
			coldResist = coldResist + 1;
		}
		
		// Calculate how much boo peak damage does
		//TODO:  use accurate calculation.  see expectedDamage calculation further down.
		int estimatedCold = 5 + (13+25+50+125+250) * ((100.0 - elemental_resist_value(coldResist)) / 100.0);
		int estimatedSpooky = 5 + (13+25+50+125+250) * ((100.0 - elemental_resist_value(spookyResist)) / 100.0);
		print("Current HP/expected maximum: " + my_hp() + "/" + expectedMaximumHp, "orange");
		print("Expected cold resistance level: " + coldResist + " Expected spooky resistance level: " + spookyResist, "orange");
		print("Expected cold damage: " + estimatedCold + " Expected spooky damage: " + estimatedSpooky, "orange");
		int totalDamage = estimatedCold + estimatedSpooky;
		if(my_turncount() == get_property("ed_lastABooConsider").to_int())
		{
			set_property("ed_lastABooCycleFix", get_property("ed_lastABooCycleFix").to_int() + 1);
			if(get_property("ed_lastABooCycleFix").to_int() > 5)
			{
				abort("We are in an A-Boo Peak cycle and can't find anything else to do. Aborting. If you have actual other quests left, please report this. Otherwise, complete A-Boo peak manually");
			}
		}
		else
		{
			set_property("ed_lastABooConsider", my_turncount());
			set_property("ed_lastABooCycleFix", 0);
		}

		if (expectedMaximumHp < totalDamage) return false;
		if (my_hp() + 20 * item_amount($item[linen bandages]) <= totalDamage) {
			// Don't bother using up the bandages unless we are completely certain to hit the target HP.
			return false;
		}
		if (possessEquipment($item[The Crown of Ed the Undying])) {
			maximize("spooky res, cold res, equip The Crown of Ed the Undying", 0, 0, false);
			adjustEdHat("bear");
		} else {
			maximize("spooky res, cold res, 0.075 HP", 0, 0, false);
		}

		print("After equipment changes, HP: " + my_hp() + "/" + my_maxhp(), "orange");
		if (my_maxhp() != expectedMaximumHp) {
			print("FIXME:  expectedMaximumHp is not correct!", "red");
			abort();
		}

		boolean doThisBoo = true;
		// Restore enough HP to pass:
		while (
			doThisBoo
			&& 0 < item_amount($item[linen bandages])
			&& my_hp() <= totalDamage
		) {
			use(1, $item[linen bandages]);
		}
		if (doThisBoo && my_hp() < totalDamage)
		{
			abort("Failed to achieve target HP by using linen bandages!");
		}
		if (doThisBoo) {
			print("Ready to use A-Boo clue, with " + my_hp() + " HP.", "blue");

			buffMaintain($effect[Spookypants], 0, 1, 1);
			buffMaintain($effect[Insulated Trousers], 0, 1, 1);
			buffMaintain($effect[Red Door Syndrome], 0, 1, 1);
			buffMaintain($effect[Well-Oiled], 0, 1, 1);
			buffMaintain($effect[Oiled-Up], 0, 1, 1);
			buffMaintain($effect[Hide of Sobek], 0, 1, 1);

			float coldFactor = elemental_resistance($element[cold])/100.0;
			float spookyFactor = elemental_resistance($element[spooky])/100.0;
			int damageFrom(int base, float factor) {
				return max(1, base - floor(factor*(base<30?30:base)+0.5));
			}
			int expectedDamage =
				damageFrom(13, coldFactor)
				+ damageFrom(25, coldFactor)
				+ damageFrom(50, coldFactor)
				+ damageFrom(125, coldFactor)
				+ damageFrom(250, coldFactor)
				+ damageFrom(13, spookyFactor)
				+ damageFrom(25, spookyFactor)
				+ damageFrom(50, spookyFactor)
				+ damageFrom(125, spookyFactor)
				+ damageFrom(250, spookyFactor);
			print("At cold resistance level: " + numeric_modifier("cold resistance") + ", spooky resistance level: " + numeric_modifier("spooky resistance"), "orange");
			if (numeric_modifier("cold resistance") != coldResist || numeric_modifier("spooky resistance") != spookyResist) {
				abort("projections of cold and/or spooky resistance were incorrect!");
				//FIXME:  end users won't want an abort here, as long as they can pass the test.  and even if they can't pass it, we can still continue automation.
			}
			print("Expected damage is:  " + expectedDamage, "orange");
			if (my_hp() <= expectedDamage) abort("Failed to prepare properly for The Horror!");

			set_property("choiceAdventure611", "1");
			use(1, $item[A-Boo clue]);
			int hpBefore = my_hp();
			visit_url("adventure.php?snarfblat=296");
			ed_ccAdv(1, $location[A-Boo Peak], "", true);
			if (hpBefore - my_hp() < expectedDamage - 5 || expectedDamage + 5 < hpBefore - my_hp()) {
				print("Calculations predicted " + expectedDamage + " damage, but we took " + (hpBefore - my_hp()) + ".  Need to fix the accuracy!", "red");
			}
			if (my_hp() == 0)
			{
				use(1, $item[Linen Bandages]);
			}
			return true;
		}

		maximize("exp", 1, 0, false);
	}
	else if((get_property("ed_abooclover") == "") && (get_property("booPeakProgress").to_int() >= 40))
	{
		if(item_amount($item[disassembled clover]) > 0)
		{
			use(1, $item[disassembled clover]);

			string page = visit_url("adventure.php?snarfblat=296&confirm=on");
			if(contains_text(page, "Combat"))
			{
				print("Wandering monster interrupt at a-boo peak", "red");
				ccAdv(1, $location[A-Boo Peak]);
			}
			else
			{
				set_property("ed_abooclover", "used");
			}
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			return true;
		}
	}
	else
	{
		ccAdv(1, $location[A-Boo Peak]);
		if(get_property("lastEncounter") == "Come On Ghosty, Light My Pyre")
		{
			set_property("ed_boopeak", "finished");
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
	if(get_property("ed_oilpeak") != "finished")
	{
		return false;
	}

	if(get_property("ed_twinpeakprogress") == "")
	{
		print("Twin Peak", "blue");
		set_property("choiceAdventure604", "1");
		set_property("choiceAdventure618", "2");
		ccAdv(1, $location[Twin Peak]);
		if(last_monster() != $monster[gourmet gourami])
		{
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Continue...");
			visit_url("choice.php?pwd&whichchoice=604&option=1&choiceform1=Everything+goes+black.");
			set_property("ed_twinpeakprogress", "1");
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
	if(get_property("ed_oilpeak") != "")
	{
		return false;
	}

	if (my_spleen_use() < spleen_limit() && item_amount($item[Ka coin]) + my_adventures() < 15) {
		print("Delaying the Oil Peak due to low Ka & adventures", "red");
	}

	print("Oil Peak with ML: " + monster_level_adjustment(), "blue");

	if(contains_text(visit_url("place.php?whichplace=highlands"), "fire3.gif"))
	{
		if(item_amount($item[bubblin\' crude]) >= 12)
		{
			cli_execute("make jar of oil");
			set_property("ed_oilpeak", "finished");
			return true;
		}
		if(item_amount($item[Jar of oil]) > 0)
		{
			set_property("ed_oilpeak", "finished");
			return true;
		}
		print("Oil Peak is finished but we need more crude!", "blue");
	}

	handleMCD();
	maximize("ML 120 max, sleaze res, 0.25 hp", 0, 0, false);
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

	if(!get_property("ed_chasmBusted").to_boolean())
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

			set_property("ed_chasmBusted", true);
			abort("Please find the Hulking Bridge Troll manually");
		}
		set_property("ed_chasmBusted", true);
		set_property("chasmBridgeProgress", 0);
		return true;
	}

	int need = (30 - get_property("chasmBridgeProgress").to_int());
	int clovers = item_amount($item[Disassembled Clover]);
	if (
		(get_property("ed_trapper") == "yeti")
		&& 0 < clovers
		&& need <= 3*clovers
		&& 0 == need % 3
	)
	{
		use(1, $item[disassembled clover]);
		visit_url("adventure.php?snarfblat=295&confirm=on");
		if(contains_text(visit_url("main.php"), "Combat"))
		{
			ccAdv(1, $location[The Smut Orc Logging Camp]);
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			return true;
		}
		visit_url("place.php?whichplace=orc_chasm&action=bridge"+(to_int(get_property("chasmBridgeProgress"))));
		return true;
	}

	print("Turns spent at Smut:  " + $location[The Smut Orc Logging Camp].turns_spent + ", bridge " + get_property("chasmBridgeProgress").to_int() + "/30", "orange");
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
		} else if (0 < item_amount($item[rusty screwdriver])) {
			visit_url("place.php?whichplace=knoll_friendly&action=dk_innabox");
			visit_url("place.php?whichplace=forestvillage&action=fv_untinker");
			return 0 == item_amount($item[rusty screwdriver]);
		} else {
			visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");
			ccAdv(1, $location[The Degrassi Knoll Garage]);
			return true;
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
	if(!get_property("ed_chasmBusted").to_boolean())
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
			set_property("ed_chasmBusted", true);
			print("Looks like we've already been here.", "blue");
		}
		set_property("ed_chasmBusted", true);
		//set_property("chasmBridgeProgress", 0);
		return true;
	}
	return false;
}

boolean L11_Palindrome()
{
	if((get_property("ed_mcmuffin") == "start") && (get_property("ed_swordfish") == "finished") && (get_property("ed_palindome") == ""))
	{
		if(get_property("questL11Palindome") == "finished")
		{
			set_property("ed_palindome", "finished");
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
		if (item_amount($item[&quot;I Love Me\, Vol. I&quot;]) > 0) {
			use(1, $item[&quot;I Love Me\, Vol. I&quot;]);
		}
		buffer palindomePage = visit_url("place.php?whichplace=palindome");
		boolean lovemeDone = contains_text(palindomePage, "pal_drlabel");
		print("In the palindome", "blue");
		if(loveMeDone && 4 == total)
		{
			visit_url("place.php?whichplace=palindome&action=pal_drlabel");
			visit_url("choice.php?pwd&whichchoice=872&option=1&photo1=2259&photo2=7264&photo3=7263&photo4=7265");
			if (0 == item_amount($item[Staff of Fats])) set_property("ed_palindome", "finished");
			return true;
		}
		else
		{
			if(my_meat() < 500)
			{
				abort("We don't have enough meat to buy a photograph!");
			}
			maximize("exp, -combat, equip Talisman O' Namsilat", 1, 0, false);
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
		set_property("ed_swordfish", "finished");
		set_property("ed_gaudy", "finished");
	}
	if(get_property("ed_swordfish") == "finished")
	{
		if(!possessEquipment($item[Talisman O\' Namsilat]))
		{
			print("We should have a Talisman O' Namsilat but we don't know about it, refreshing inventory", "red");
			cli_execute("create talisman o' namsilat");
			cli_execute("refresh inv");
		}
		return false;
	}
	if(get_property("ed_mcmuffin") != "start")
	{
		return false;
	}
	if(!possessEquipment($item[Pirate Fledges]))
	{
		return false;
	}
	if((get_property("ed_war") == "finished") || (get_property("ed_prewar") == ""))
	{
		maximize("exp, equip pirate fledges", 1, 0, false);
		set_property("choiceAdventure189", "1");
		set_property("oceanAction", "continue");
		set_property("oceanDestination", to_lower_case(my_primestat()));
		if(get_property("ed_gaudy") == "")
		{
			print("It always be swordfish.", "blue");
			ccAdv(1, $location[The Poop Deck]);
			if(contains_text(get_property("lastEncounter"), "It\'s Always Swordfish"))
			{
				set_property("ed_gaudy", "start");
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
			set_property("ed_gaudy", "finished");
			set_property("ed_swordfish", "finished");

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
	set_property("ed_mcmuffin", "start");
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
	if(get_property("ed_mcmuffin") != "")
	{
		return false;
	}
	if(get_property("ed_blackmap") == "finished")
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
	set_property("ed_blackmap", "finished");
	return true;

}

boolean L11_blackMarket()
{
	if(my_level() < 11)
	{
		return false;
	}
	if(get_property("ed_blackmap") != "")
	{
		return false;
	}
	if(black_market_available())
	{
		set_property("ed_blackmap", "document");
		return false;
	}
	if(item_amount($item[black map]) == 0)
	{
		council();
		cli_execute("refresh inventory");
		set_property("ed_blackfam", false);
	}
	
	print("Must find the Black Market: " + get_property("blackForestProgress"), "blue");
	if(!get_property("ed_blackfam").to_boolean() && item_amount($item[reassembled blackbird]) > 0)
	{
		set_property("ed_blackfam", true);
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
		maximize("exp, equip blackberry galoshes", 1, 0, false);
	} else {
		maximize("exp", 1, 0, false);
	}
	
	if(possessEquipment($item[Blackberry Galoshes]) && 2 <= get_property("blackForestProgress").to_int())
	{
		set_property("choiceAdventure923", "2");
		set_property("choiceAdventure925", "2");
	}

	ccAdv(1, $location[The Black Forest]);
	if(black_market_available())
	{
		buyUpTo(2, $item[can of black paint]);
		set_property("ed_blackmap", "document");
		if(my_meat() >= 5000)
		{
			buyUpTo(1, $item[forged identification documents]);
			set_property("ed_blackmap", "finished");
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
	if(item_amount($item[abridged dictionary]) >= 1)
	{
		return false;
	}
	if(item_amount($item[dictionary]) >= 1)
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
	if(get_property("ed_pirateoutfit") != "finished")
	{
		return false;
	}
	if(get_property("ed_fcle") != "")
	{
		return false;
	}
	if(possessEquipment($item[pirate fledges]))
	{
		set_property("ed_fcle", "finished");
		visit_url("store.php?whichstore=r");
		print("Updating Pirate Bookstore Item (" + get_property("lastPirateEphemeraReset") + "): " + get_property("lastPirateEphemera"), "blue");
		return true;
	}
	if(get_property("ed_prewar") != "")
	{
		if(get_property("ed_war") != "finished")
		{
			return false;
		}
	}
	
	if(my_hp() < 20)
	{
		set_property("choiceAdventure191", 1);
	}
	else
	{
		set_property("choiceAdventure191", 4);
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
	if(item_amount($item[Talisman of Renenutet]) == 0)
	{
		//TODO:  what if we squandered them on something else?  We need to make sure the script doesn't ever do that.  If the user did so manually, then it's reasonable to just wait until tomorrow.
		print("Skipping F'c'le, because no talismen of Renenutet are available.", "red");
		return false;
	}
	if (
		my_maxhp() < expected_damage($monster[curmudgeonly pirate]) + 5
		&& !have_skill($skill[Curse of Indecision])
	) {
		//TODO:  the formula here will need some tweaking.  For starters, we aren't wearing the outfit yet.
		// (we probably won't get a Renenutet in edgewise)
		return false;
	}
	if(!uneffect($effect[Shelter Of Shed]))
	{
		//TODO:  should we use a cure-all, or just burn turns elsewhere?
		print("Could not uneffect Shelter of Shed for F'C'le, delaying", "orange");
		return false;
	}

	print("Fcle time!", "blue");
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
	buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
	cli_execute("outfit swashbuckling getup");
	ccAdv(1, $location[The F\'c\'le]);
	return true;
}

boolean LX_pirateBeerPong()
{
	if(get_property("ed_pirateoutfit") != "almost")
	{
		return false;
	}
	cli_execute("outfit swashbuckling getup");
	string page = tryBeerPong();
	if(contains_text(page, "victory laps"))
	{
		set_property("ed_pirateoutfit", "finished");
	}
	else if(contains_text(page, "Combat"))
	{
		ccAdv(1, $location[barrrney\'s barrr]);
	}
	return true;
}

boolean LX_nastyBooty()
{
	if(get_property("ed_pirateoutfit") != "blueprint")
	{
		return false;
	}
	if (0 < item_amount($item[orcish frat house blueprints])) {
		return false;
	}

	if (
		0 == item_amount($item[Cap\'m Caronch\'s Map])
		&& 0 == item_amount($item[Cap\'m Caronch\'s Nasty Booty])
	) {
		//TODO:  -combat?
		cli_execute("outfit swashbuckling getup");
		ccAdv(1, $location[barrrney\'s barrr]);
		return true;
	}
	if(item_amount($item[Cap\'m Caronch\'s Nasty Booty]) != 0)
	{
		return false;
	}
	if(my_maxhp() < expected_damage($monster[booty crab]) && jump_chance($monster[booty crab]) < 60) return false;

	ed_use_servant($servant[Priest]);
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

	ed_use_servant();
	set_location($location[The Obligatory Pirate\'s Cove]);
	cli_execute("ed_preadventure.ash");
	set_property("ed_disableAdventureHandling", "yes");
	visit_url("inv_use.php?pwd=&which=3&whichitem=2950");
	ccAdvBypass(1, $location[Noob Cave]);
	set_property("ed_disableAdventureHandling", "no");
	return true;
}

boolean LX_pirateBlueprint()
{
	if(get_property("ed_pirateoutfit") != "blueprint")
	{
		return false;
	}

	if(item_amount($item[Cap\'m Caronch\'s Nasty Booty]) == 0
		&& item_amount($item[orcish frat house blueprints]) == 0)
	{
		return false;
	}
	print("Trying to blueprint handle", "blue");
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
			visit_url("place.php?whichplace=forestvillage&preaction=screwquest&action=fv_untinker_quest");

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
		set_property("ed_pirateoutfit", "almost");
		return true;
	}
}

boolean LX_pirateInsults()
{
	if(get_property("ed_pirateoutfit") != "insults")
	{
		return false;
	}
	if(my_basestat($stat[moxie]) < 25)
	{
		return false;
	}
	if(my_maxhp() < 60)
	{
		return false;
	}
	print("Insult gathering party.", "blue");
	cli_execute("outfit swashbuckling getup");

	if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
	{
		buyUpTo(1, $item[the big book of pirate insults]);
	}
	if(item_amount($item[the big book of pirate insults]) == 0)
	{
		return false;
	}

	buyUpTo(1, $item[hair spray]);
	buyUpTo(1, $item[ben-gal&trade; balm]);
	buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
	buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);

	cli_execute("refresh inv");
	ccAdv(1, $location[barrrney\'s barrr]);
	if(numPirateInsults() >= 7)
	{
		set_property("ed_pirateoutfit", "blueprint");
	}
	return true;
}

boolean LX_pirateOutfit()
{
	if(get_property("ed_pirateoutfit") != "")
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
			set_property("ed_pirateoutfit", "insults");
			return true;
		}
		if((item_amount($item[the big book of pirate insults]) == 0) && (my_meat() > 500))
		{
			set_property("ed_pirateoutfit", "insults");
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

boolean ed_tavern()
{
	if(get_property("ed_tavern") == "finished")
	{
		return false;
	}
	visit_url("cellar.php");
	# Mafia usually fixes tavernLayout when we visit the cellar. However, it sometimes leaves it in a broken state so we can't guarantee this will actually help. However, it will result in no net change in tavernLayout so at least we can abort.
	string tavern = get_property("tavernLayout");
	if(index_of(tavern, "3") != -1)
	{
		set_property("ed_tavern", "finished");
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
				if(get_property("ed_newbieOverride").to_boolean())
				{
					set_property("ed_newbieOverride", false);
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
	if(get_property("ed_tavern") == "finished")
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

	set_property("choiceAdventure1000", "1");
	set_property("choiceAdventure1001", "2");
	if((my_mp() < 15) && have_skill($skill[Shelter of Shed]))
	{
		return false;
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

	handleMCD();
/*
	while(ed_tavern())
	{
		if(my_adventures() <= 0)
		{
			abort("Ran out of adventures while doing the tavern.");
		}
		wait(4);
	}
*/
	if (!ed_tavern()) return false;

	if (index_of(get_property("tavernLayout"), "3") != -1) {
		visit_url("tavern.php?place=barkeep");
		set_property("ed_tavern", "finished");
		council();
	}
	return true;
}

boolean ed_LX_xp() {
	if (my_level() >= 13) return false;

	print("We've done everything possible at this time and have not reached the next level, so power-leveling in the most basic way Ed can, abort if you want to do this on your own.", "blue");
	buffMaintain($effect[Purr of the Feline], 0, 1, 1);

	boolean galleryAndBathroomOpen = get_property("ed_spookyravennecklace") == "finished";
	// note, clovers used at:  trapper, guano, a-boo, bridge.
	int reservedClovers
		= (get_property("ed_boopeak") == "finished" ? 0 : 1)  //TODO:  how much left?  do we have clues?
		+ (get_property("ed_chasmBridgeProgress").to_int() < 25 ? 0 : 1);
	int spareClovers =  item_amount($item[disassembled clover]) - reservedClovers;
	if (!galleryAndBathroomOpen || spareClovers <= 0) {
		//TODO:  account for Taunt and/or Hippy Stench in calculations.  (and other combat rate modifiers?)
		float galleryExperienceEstimate
			= (6 + numeric_modifier("Mysticality Experience")) * (18.0/25)
				+ min(200.0, 3*my_basestat($stat[Mysticality])) * (1+numeric_modifier("Mysticality Experience Percent")/100.0) * (7.0/25);
		float smoochExperienceEstimate = my_buffedstat($stat[Mysticality]) / 5;
			//TODO:  when does smooch give better experience than the gallery?
		print("gallery versus smooch:  " + galleryExperienceEstimate + " / " + smoochExperienceEstimate,"orange");
		if (galleryExperienceEstimate < smoochExperienceEstimate) {
			if (ed_LX_smooch()) return true;
		}
		if (0 < have_effect($effect[Taunt of Horus]) || 0 < have_effect($effect[Hippy Stench])) {
			if (ed_LX_smooch()) return true;
		}
	}
	if(get_property("ed_spookyravennecklace") == "finished")
	{
		if (0 < spareClovers) {
			print("TODO:  clovering at the bathroom.  is that the best use of this clover??", "orange");
			use(1, $item[disassembled clover]);
			visit_url("adventure.php?snarfblat=392&confirm=on");  // The Haunted Bathroom
			if (contains_text(visit_url("main.php"), "Combat")) {
				ccAdv(1, $location[The Haunted Bathroom]);
			}
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			return true;
		}
		//TODO:  how does the bathroom compare?
		set_property("ed_galleryFarm", TRUE);
		maximize("exp, -combat", 0, 0, false);
		set_property("louvreDesiredGoal", "5");
		ed_configureOutInTheGarden();
		buffMaintain($effect[Shelter of Shed], 0, 1, 1);
		if (
			-20.0 <= numeric_modifier("Combat Rate")
			&& !to_boolean(get_property("_olympicSwimmingPool"))
		) cli_execute("swim sprints");
		//buffMaintain($effect[Thaumodynamic], 0, 1, 1);
		if (!to_boolean(get_property("_aprilShower"))) cli_execute("shower lukewarm");
		ccAdv(1, $location[The Haunted Gallery]);
		return true;
	} else if((my_level() > 9) && (get_property("ed_castlebasement") == "finished")) {
		maximize("exp, -combat", 0, 0, false);
		set_property("choiceAdventure669", "1");
		set_property("choiceAdventure670", "4");
		set_property("choiceAdventure671", "2");
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		return true;
	}
	else if(my_level() <= 10)
	{
		if (have_skill($skill[Even More Elemental Wards]))
		{
			ed_use_servant($servant[Scribe]);
		}
		maximize("exp, -equip filthy knitted dread sack", 0, 0, false);
		ccAdv(1, $location[Hippy Camp]);
		return true;
	}
	else
	{
		abort("You need to reach the next level before this script can do any more for you, but you have no leveling options available.");
	}
	abort("This code should be unreachable.  check the if statements above for a missing 'return'!");
	return true;  // ?? I thought ASH detected unreachable code?  Can code after an abort ever be reached?
}

boolean ed_L12_flyers() {
	if (0 == item_amount($item[rock band flyers])) return false;
	if (10000 < get_property("flyeredML").to_int()) return false;

	print("Not enough flyer ML but we are ready for the war... uh oh", "blue");
	print("Should not have so little flyer ML at this point, trying high ML locations.", "red");
	wait(1);
	maximize("ML", 0, 0, false);
	if(get_property("sleazeAirportAlways").to_boolean())
	{
		ccAdv(1, $location[Sloppy Seconds Diner]);
		return true;
	}
	if(get_property("spookyAirportAlways").to_boolean())
	{
		ccAdv(1, $location[The Deep Dark Jungle]);
		return true;
	}
	if(get_property("stenchAirportAlways").to_boolean())
	{
		ccAdv(1, $location[Pirates of the Garbage Barges]);
		return true;
	}
	else
	{
		set_property("choiceAdventure669", "1");
		set_property("choiceAdventure670", "4");
		set_property("choiceAdventure671", "2");
		buffMaintain($effect[Go Get \'Em\, Tiger!], 0, 1, 1);
		buffMaintain($effect[Butt-Rock Hair], 0, 1, 1);
		ccAdv(1, $location[The Castle in the Clouds in the Sky (Basement)]);
		return true;
	}
}

boolean doTasks()
{
	// Handles MCD setting to 10 or 11
	handleMCD();

	// Autosells junk items to help generate MP
	sellStuff();

	// Checks to make sure you have all the latest quests up to date
	if(my_level() > get_property("lastCouncilVisit").to_int())
	{
		council();
	}

	// Noob override that makes sure you don't accidentally go to the Noob Cave, and if you do aborts so you can see what went wrong.
	if (last_monster() == $monster[Crate])
	{
		if(get_property("ed_newbieOverride").to_boolean())
		{
			set_property("ed_newbieOverride", false);
		}
		else
		{
			abort("We went to the Noob Cave for reals... uh oh");
		}
	}
	else
	{
		set_property("ed_newbieOverride", false);
	}

	//Eating before fortune handling, so you can pick up the semirare number
	if(ed_eatStuff())
	{
		return true;
	}

	//Purchase skills from pyramid and releases servants each level
	ed_buySkills();

	maximize("exp", 1, 0, false);
		//TODO:  grumpy old man charrrm bracelet

	//Heals
	if(my_hp() == 0)
	{
		if(item_amount($item[linen bandages]) > 0)
		{
			use(1, $item[linen bandages]);
		} else {
			abort("Out of HP, and no restorer is available.  You'll have to figure out how to handle this manually.");
		}
	}

	//Fortune cookie handling here instead of as a pre-adventure due to the chance of a semi-rare being off (from wrong fortune cookie numbers)
	//and thus combat, plus baabaabaran and such
	if (fortuneCookieEvent()) return true;

	//Using +stat buffs
	buffMaintain($effect[From Nantucket], 0, 1, 1);
	buffMaintain($effect[Squatting and Thrusting], 0, 1, 1);
	buffMaintain($effect[You Read the Manual], 0, 1, 1);
	//TODO:  Add the old rosewater one.

	if (ed_LX_lightsOut()) return true;
	//This should allow us to pick up the semi-rare in the Outskirts for some low level food/drink
	if (LX_getLunchbox()) return true;

	if(LX_chateauDailyPainting())
	{
		return true;
	}

	if(L1_edVacation(0))
	{
		return true;
	}

	if (ed_LX_islandAccess()) return true;

	ed_hermitClovers();

	if (ed_LX_smoochQuest()) return true;

	if(L1_edIslandFallback())
	{
		return true;
	}

	if(get_property("ed_dickstab").to_boolean())
	{
		if(L4_batCave())
		{
			return true;
		}
	}

	if(L12_hippyOutfit())
	{
		return true;
	}

	if(L4_batCave())
	{
		return true;
	}

	if(L2_mosquito() || L2_treeCoin() || L2_spookyMap() || L2_spookyFertilizer() || L2_spookySapling())
	{
		return true;
	}
	
	if(get_property("ed_dickstab").to_boolean())
	{
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
		if(LX_pirateOutfit() || LX_pirateInsults() || LX_nastyBooty() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
		{
			return true;
		}
		if(LX_dinseylandfillFunbucks())
		{
			return true;
		}
		if(L1_edVacation(10))
		{
			return true;
		}
	}

	if(LX_pirateOutfit() || LX_pirateInsults())
	{
		return true;
	}
	
	if(L5_getEncryptionKey())
	{
		return true;
	}

	if(L6_friarsGetParts())
	{
		return true;
	}
	
	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}
	
	if(ed_doResting())
	{
		return true;
	}
	
	if(LX_nastyBooty() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
	{
		return true;
	}
	
	if(L3_tavern())
	{
		return true;
	}
	
	if(L5_haremOutfit())
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
	
	if(L10_airship() || L10_basement() || L10_ground() || L10_topFloor())
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
	
	if(LX_handleSpookyravenFirstFloor())
	{
		return true;
	}
	
	if(LX_spookyravenSecond())
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

	if((my_level() >= 12) && (item_amount($item[rock band flyers]) == 0) && (get_property("flyeredML").to_int() < 10000) && ((get_property("ed_hiddenapartment") == "0") || (get_property("ed_hiddenapartment") == "finished")))
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

	if(L6_friarsGetParts())
	{
		return true;
	}

	if(L8_trapperStart() || L8_trapperGround() || L8_trapperYeti())
	{
		return true;
	}

	if(LX_pirateOutfit() || LX_pirateInsults() || LX_nastyBooty() || LX_pirateBlueprint() || LX_pirateBeerPong() || LX_fcle())
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

	if(get_property("ed_hippyInstead").to_boolean() && (get_property("ed_nunsTrick") == "true"))
	{
		set_property("ed_nunsTrick", "false");
		set_property("ed_ignoreFlyer", true);
	}
	
//	if(get_property("ed_nunsTrick") == "true")
//	{
//		if(possessEquipment($item[reinforced beaded headband]) && possessEquipment($item[bullet-proof corduroys]) && possessEquipment($item[round purple sunglasses]))
//		{
//			print("Had gotten War Hippy Fatigues during the Ferret rescue. Don't need to worry about them now.", "blue");
//			set_property("ed_nunsTrick", "got");
//		}
//		else
//		{
//			print("Only have some of the War Hippy Fatigues, so I'm going to closet everything relevant to get them in the desert", "blue");
//			put_closet(item_amount($item[beer helmet]), $item[beer helmet]);
//			put_closet(item_amount($item[distressed denim pants]), $item[distressed denim pants]);
//			put_closet(item_amount($item[bejeweled pledge pin]), $item[bejeweled pledge pin]);
//			put_closet(item_amount($item[reinforced beaded headband]), $item[reinforced beaded headband]);
//			put_closet(item_amount($item[bullet-proof corduroys]), $item[bullet-proof corduroys]);
//			put_closet(item_amount($item[round purple sunglasses]), $item[round purple sunglasses]);
//				
//			ccAdv(1, $location[The Arid\, Extra-Dry Desert]);
//				
//			if(contains_text(get_property("lastEncounter"), "He Got His Just Desserts"))
//			{
//				take_closet(1, $item[beer helmet]);
//				take_closet(1, $item[distressed denim pants]);
//				take_closet(1, $item[bejeweled pledge pin]);
//				set_property("ed_nunsTrick", "got");
//			}
//
//			return true;
//		}
//	}
	
	if((get_property("ed_nunsTrick") == "got") && (get_property("currentNunneryMeat").to_int() < 100000) && !get_property("ed_100familiar").to_boolean())
	{
		set_property("ed_nunsTrickActive", "yes");
		if((get_property("ed_mcmuffin") == "ed") || (get_property("ed_mcmuffin") == "finished"))
		{
			if(doThemtharHills(true))
			{
				return true;
			}
		}
	}

	if(get_property("ed_nunsTrickActive") == "yes")
	{
		set_property("ed_nunsTrickActive", "no");
	}

	boolean canDoHidden = true;
	if((item_amount($item[Moss-Covered Stone Sphere]) == 0) && (get_property("ed_hiddenapartment") != "finished") && 0 == have_effect($effect[Thrice-Cursed]))
		//TODO:  i don't quite get it.  added the Thrice-Cursed check....  maybe that belongs in the Fortune Cookie counter check??
	{
		if(get_counters("Fortune Cookie", 0, 9) == "Fortune Cookie")
		{
			canDoHidden = false;
		}
		if((my_adventures() < (9 - get_property("ed_hiddenapartment").to_int())))
		{
			canDoHidden = false;
		}
	}

	if((get_property("ed_hiddenzones") == "finished") && (get_property("ed_hiddencity") == "") && canDoHidden)
	{
		if(item_amount($item[7963]) == 0)
		{
			set_property("ed_hiddencity", "finished");
			return true;
		}

		if((item_amount($item[Book of Matches]) > 0) && (my_ascensions() > get_property("hiddenTavernUnlock").to_int()))
		{
			use(1, $item[Book of Matches]);
		}

		if((get_property("ed_hiddenapartment") != "finished"))
		{
			if(item_amount($item[Moss-Covered Stone Sphere]) > 0)
			{
				cli_execute("hottub");
				if(have_effect($effect[Thrice-Cursed]) > 0)
				{
					uneffect($effect[Thrice-Cursed]);
				}
				set_property("ed_hiddenapartment", "finished");
				return true;
			}
			print("The idden [sic] apartment!", "blue");
			int current = get_property("ed_hiddenapartment").to_int();
			current = current + 1;
			set_property("ed_hiddenapartment", current);
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
		if((get_property("ed_hiddenoffice") != "finished") && (my_adventures() >= 11))
		{
			if(item_amount($item[Crackling Stone Sphere]) > 0)
			{
				set_property("ed_hiddenoffice", "finished");
				return true;
			}
			print("The idden [sic] office!", "blue");
			int current = get_property("ed_hiddenoffice").to_int();
			current = current + 1;
			set_property("ed_hiddenoffice", ""+current);
			if(current <= 6)
			{
				set_property("choiceAdventure786", "2");
			}
			else
			{
				set_property("choiceAdventure786", "1");
			}

			print("Hidden Office Progress: " + get_property("hiddenOfficeProgress"), "blue");
			if(get_property("ed_autoCraft") == "")
			{
				set_property("ed_autoCraft", get_property("autoCraft").to_boolean());
			}
			set_property("autoCraft", false);
			ccAdv(1, $location[The Hidden Office Building]);
			if((item_amount($item[Boring Binder Clip]) == 1) && (item_amount($item[McClusky File (Page 5)]) == 1))
			{
				visit_url("inv_use.php?pwd=&which=3&whichitem=6694");
				cli_execute("refresh inv");
			}
			if(get_property("ed_autoCraft") != "")
			{
				set_property("autoCraft", get_property("ed_autoCraft").to_boolean());
				set_property("ed_autoCraft", "");
			}
			return true;
		}

		if(get_property("ed_hiddenbowling") != "finished")
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
				set_property("ed_hiddenbowling", "finished");
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

		if(get_property("ed_hiddenhospital") != "finished")
		{
			if(item_amount($item[Dripping Stone Sphere]) > 0)
			{
				set_property("ed_hiddenhospital", "finished");
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
		if((get_property("ed_hiddenapartment") == "finished") && (get_property("ed_hiddenoffice") == "finished") && (get_property("ed_hiddenbowling") == "finished") && (get_property("ed_hiddenhospital") == "finished"))
		{
			print("Getting the stone triangles", "blue");
			if(item_amount($item[stone triangle]) == 0)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northwest)]);
			}
			if(item_amount($item[stone triangle]) == 1)
			{
				ccAdv(1, $location[An Overgrown Shrine (Northeast)]);
			}
			if(item_amount($item[stone triangle]) == 2)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southwest)]);
			}
			if(item_amount($item[stone triangle]) == 3)
			{
				ccAdv(1, $location[An Overgrown Shrine (Southeast)]);
			}

			print("Visiting the out-of-work spirit", "blue");

			ccAdv(1, $location[A Massive Ziggurat]);

			if(item_amount($item[2180]) == 0)
			{
				set_property("ed_hiddencity", "finished");
			}
			
			return true;
		}
		abort("Should not have gotten here. Aborting");
	}

	if((my_level() >= 12) && (get_property("ed_gremlins") == ""))
	{
		print("Gremlin prep", "blue");
		set_property("ed_gremlins", "start");
		return true;
	}

	if((item_amount($item[barrel of gunpowder]) >= 5) && ((get_property("ed_hippyInstead") == "no") || (get_property("fratboysDefeated").to_int() >= 64)))
	{
		warOutfit();
		visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
		visit_url("bigisland.php?place=lighthouse&action=pyro&pwd");
		set_property("ed_sonata", "finished");
		return true;
	}

	if((get_property("ed_gremlins") == "start") && ((get_property("ed_hippyInstead") == "no") || (get_property("fratboysDefeated").to_int() >= 192)))
	{
		maximize("exp, 0.5 hp, -muscle", 0, 0, false);
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
		set_property("ed_gremlins", "finished");
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

	if((get_property("ed_orchard") == "finished") && (get_property("sidequestOrchardCompleted") == "none"))
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

	if (ed_L12_flyers()) return true;

	if((my_level() >= 12) && ((get_property("hippiesDefeated").to_int() >= 192) || get_property("ed_hippyInstead").to_boolean()) && (get_property("ed_nuns") == ""))
	{
		if(doThemtharHills(false))
		{
			return true;
		}
	}

	if((get_property("ed_war") != "done") && (get_property("ed_war") != "finished") && ((get_property("hippiesDefeated").to_int() >= 1000) || (get_property("fratboysDefeated").to_int() >= 1000)))
	{
		set_property("ed_nuns", "finished");
		set_property("ed_war", "done");
	}

	if((my_level() >= 12) && (get_property("ed_battleFratplant") == ""))
	{
		warOutfit();
		warAdventure();
		set_property("ed_battleFratplant", "plant");
		return true;
	}

	if((get_property("ed_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 64) && (get_property("fratboysDefeated").to_int() < 64)) && (my_level() >= 12))
	{
		print("First 64 combats. To orchard/lighthouse", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("ed_battleFratplant") == "plant") && ((get_property("hippiesDefeated").to_int() < 192) && (get_property("fratboysDefeated").to_int() < 192)) && (my_level() >= 12))
	{
		print("Getting to the nunnery/junkyard", "blue");
		warOutfit();
		warAdventure();
		return true;
	}

	if((get_property("ed_nuns") == "done") && ((get_property("hippiesDefeated").to_int() < 1000) && (get_property("fratboysDefeated").to_int() < 1000)) && (my_level() >= 12))
	{
		print("Doing the wars.", "blue");
		warOutfit();
		warAdventure();
		return true;
	}
	
	if(get_property("ed_war") == "done")
	{
		equip($slot[hat], $item[none]);
		if (have_outfit("War Hippy Fatigues")) {
			print("Getting dimes.", "blue");
			outfit("War Hippy Fatigues");
			sell($item[padl phone].buyer, item_amount($item[padl phone]), $item[padl phone]);
			sell($item[red class ring].buyer, item_amount($item[red class ring]), $item[red class ring]);
			sell($item[blue class ring].buyer, item_amount($item[blue class ring]), $item[blue class ring]);
			sell($item[white class ring].buyer, item_amount($item[white class ring]), $item[white class ring]);
		}

		if (have_outfit("Frat Warrior Fatigues")) {
			print("Getting quarters.", "blue");
			outfit("Frat Warrior Fatigues");
			sell($item[pink clay bead].buyer, item_amount($item[pink clay bead]), $item[pink clay bead]);
			sell($item[purple clay bead].buyer, item_amount($item[purple clay bead]), $item[purple clay bead]);
			sell($item[green clay bead].buyer, item_amount($item[green clay bead]), $item[green clay bead]);
			sell($item[communications windchimes].buyer, item_amount($item[communications windchimes]), $item[communications windchimes]);
		}

		if (have_outfit("War Hippy Fatigues")) {
			print("Spending dimes.", "blue");
			outfit("War Hippy Fatigues");

			while($coinmaster[Dimemaster].available_tokens >= 5)
			{
				ed_buy($coinmaster[Dimemaster].available_tokens / 5, $item[fancy seashell necklace]);
			}
			while($coinmaster[Dimemaster].available_tokens >= 2)
			{
				ed_buy($coinmaster[Dimemaster].available_tokens / 2, $item[filthy poultice]);
			}
			while($coinmaster[Dimemaster].available_tokens >= 1)
			{
				ed_buy(1, $item[water pipe bomb]);
			}
			if (0 < $coinmaster[Dimemaster].available_tokens) abort("Script failure:  no dimes should remain!");
		}

		if (have_outfit("Frat Warrior Fatigues")) {
			print("Spending quarters.", "blue");
			outfit("Frat Warrior Fatigues");
			while($coinmaster[Quartersmaster].available_tokens >= 5)
			{
				ed_buy($coinmaster[Quartersmaster].available_tokens / 5, $item[commemorative war stein]);
			}
			while($coinmaster[Quartersmaster].available_tokens >= 2)
			{
				ed_buy($coinmaster[Quartersmaster].available_tokens / 2, $item[gauze garter]);
			}
			while($coinmaster[Quartersmaster].available_tokens >= 1)
			{
				ed_buy(1, $item[beer bomb]);
			}
			if (0 < $coinmaster[Quartersmaster].available_tokens) abort("Script failure:  no quarters should remain!");
		}

		warOutfit();
		cli_execute("refresh equip");
		if(my_hp() < my_maxhp())
		{
			print("My hp is: " + my_hp(), "orange");
			print("My max hp is: " + my_maxhp(), "orange");
		}
		print("Let's fight the boss!", "blue");
		set_property("edDefeatAbort", "5");
		visit_url("bigisland.php?place=camp&whichcamp=1");
		visit_url("bigisland.php?place=camp&whichcamp=2");
		visit_url("bigisland.php?action=bossfight&pwd");
		ccAdvBypass(1, $location[Noob Cave]);
		council();
		set_property("ed_war", "finished");
		return true;
	}

	if (ed_LX_xp()) return true;

	if(get_property("ed_sorceress") == "")
	{
		council();
		if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
		{
			if (have_display()) put_display(item_amount($item[thwaitgold scarab beetle statuette]), $item[thwaitgold scarab beetle statuette]);
			set_property("ed_sorceress", "finished");
			council();
			return true;
		}
		
		if(contains_text(visit_url("place.php?whichplace=nstower"), "ns_10_sorcfight"))
		{
			print("We found the jerkwad!! Revenge!!!!!", "blue");
			set_property("edDefeatAbort", "5");
			string page = visit_url("place.php?whichplace=nstower&action=ns_10_sorcfight");
			if(contains_text(page, "Combat"))
			{
				ccAdv(1, $location[Noob Cave]);
			}
			if(item_amount($item[Thwaitgold Scarab Beetle Statuette]) > 0)
			{
				set_property("ed_sorceress", "finished");
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

	if((get_property("ed_sorceress") == "finished"))
	{
		if(item_amount($item[7965]) == 0)
		{
			ccAdv(1, $location[The Secret Council Warehouse]);
		}
		else if(get_property("ed_delayToDayFour").to_boolean() && (item_amount($item[7965]) > 0))
		{
			if(my_daycount() > 3)
			{
				use(7, $item[mummified beef haunch]);
				print("Spleened and good to go!", "green");
				return false;
			}
			else
			{
				print("Overdrink, eat, etc, burn some turns if you have more than 160, buy some spleen items", "orange");
				return false;
			}
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
			print("Ed Combats: " + get_property("ed_edCombatCount"), "blue");
			print("Ed Combat Rounds: " + get_property("ed_edCombatRoundCount"), "blue");
		}
		
		return true;
	}

	print("I should not get here more than once because I pretty much just finished all my in-run stuff. Beep", "blue");
	wait(5);
	return false;
}

void ed_begin()
{
	cli_execute("spookyraven off");

	print("Hello " + my_name() + ", time to explode!");
#	print("This is version: 1.0.0.7");
	print("This is day " + my_daycount() + ".");
	print("Turns played: " + my_turncount() + " current adventures: " + my_adventures());
	print("Current Ascension: " + my_path());
	
	if ((my_class() != $class[Ed]))
	{
		abort("Hold it pardner, this script is meant for mummies only. Come back after you've dried out a bit!");
	}
	
	initializeSettings();
	initializeDay(my_daycount());
	equipBaseline();

	if(vars["chit.helpers.xiblaxian"] != "false")
	{
		print("Switching off CHiT Xiblaxian Counter, will resume during bedtime");
		set_property("ed_priorXiblaxianMode", 1);
		setvar("chit.helpers.xiblaxian", false);
	}

	questOverride();
	set_property("edDefeatAbort", "2");

	int retryLimit = 20;
	int retries = 0;
	int lastAdventureCount = my_adventures();
	while (
		(my_adventures() > 1)
		&& (my_inebriety() <= inebriety_limit())
		&& (get_property("kingLiberated") == "false")
		&& doTasks()
	) {
		if (lastAdventureCount != my_adventures()) {
			retries = 0;
		} else {
			retries += 1;
			if (retryLimit <= retries) {
				abort("We appear to be stuck in a loop.");
			}
		}
		lastAdventureCount = my_adventures();
	}
	
	doBedtime();
	print("Done for today (" + my_daycount() + "), beep boop");
}

void main()
{
	ed_begin();
}
