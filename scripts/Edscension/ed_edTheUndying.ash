script "ed_edTheUndying.ash"
import <ed_util.ash>
import <ed_equipment.ash>
import <ed_eudora.ash>
import <ed_preadventure.ash>

void ed_initializeSettings()
{
	set_property("ed_edSkills", -1);
	set_property("ed_semisub", "pantry");
	set_property("ed_lashes_day1", "");
	set_property("ed_lashes_day2", "");
	set_property("ed_lashes_day3", "");
	set_property("ed_lashes_day4", "");
	set_property("ed_lashes", "");
	set_property("ed_renenutet_day1", "");
	set_property("ed_renenutet_day2", "");
	set_property("ed_renenutet_day3", "");
	set_property("ed_renenutet_day4", "");
	set_property("ed_renenutet", "");
	set_property("ed_chasmBusted", "false");
	set_property("ed_renenutetBought", 0);
	set_property("ed_edCombatCount", 0);
	set_property("ed_edDelayHauntedKitchen", "true");
	set_property("choiceAdventure1002", 1);
	cli_execute("ccs null");
	cli_execute("set battleAction=custom combat script");
	cli_execute("mood apathetic");
	set_property("hpAutoRecoveryItems", "linen bandages");
	set_property("hpAutoRecovery", -0.05);
	set_property("hpAutoRecoveryTarget", 0.0);
}

void ed_initializeDay(int day)
{
	if(day == 1)
	{
		if(get_property("ed_day1_init") != "finished")
		{
			visit_url("place.php?whichplace=desertbeach&action=db_nukehouse");
			set_property("ed_renenutetBought", 0);
			if(item_amount($item[transmission from planet Xi]) > 0)
			{
				use(1, $item[transmission from planet xi]);
			}
			if(item_amount($item[Xiblaxian holo-wrist-puter simcode]) > 0)
			{
				use(1, $item[Xiblaxian holo-wrist-puter simcode]);
			}
			visit_url("tutorial.php?action=toot");
			use(item_amount($item[Letter to Ed the Undying]), $item[Letter to Ed the Undying]);
			use(item_amount($item[Pork Elf Goodies Sack]), $item[Pork Elf Goodies Sack]);
			tootGetMeat();

			equipBaseline();

			set_property("ed_day1_init", "finished");
		}
	}
	else if(day == 2)
	{
		if(get_property("ed_day2_init") == "")
		{
			equipBaseline();
			ovenHandle();
			set_property("ed_renenutetBought", 0);
			if((my_meat() > 500))
			{
				buyUpTo(1, $item[Hermit Permit]);
				cli_execute("hermit * clover");
			}
			set_property("ed_day2_init", "finished");
		}
	}
	else if(day == 3)
	{
		if(get_property("ed_day3_init") == "")
		{
			set_property("ed_renenutetBought", 0);
			if((my_meat() > 500))
			{
				buyUpTo(1, $item[Hermit Permit]);
				cli_execute("hermit * clover");
			}
			set_property("ed_day3_init", "finished");
		}
	}
	else if(day == 4)
	{
		if(get_property("ed_day4_init") == "")
		{
			set_property("ed_renenutetBought", 0);
			cli_execute("hermit * clover");
			set_property("ed_day4_init", "finished");
		}
	}
}

void createBurrito()
{
	if((my_daycount() == 2) && (eudora_current() == $item[Xi Receiver Unit]) && possessEquipment($item[Xiblaxian holo-wrist-puter]) && ((my_fullness() + 4) <= fullness_limit()) && (item_amount($item[Xiblaxian Circuitry]) >= 1) && (item_amount($item[Xiblaxian Polymer]) >= 1) && (item_amount($item[Xiblaxian Alloy]) >= 3))
	{
		if(item_amount($item[Xiblaxian 5D Printer]) == 0)
		{
			if(item_amount($item[transmission from planet Xi]) > 0)
			{
				use(1, $item[transmission from planet xi]);
				use(1, $item[Xiblaxian Cache Locator Simcode]);
			}
		}
		if(item_amount($item[Xiblaxian 5D Printer]) > 0)
		{
			int[item] canMake = eudora_xiblaxian();
			if(canMake contains $item[Xiblaxian Ultraburrito])
			{
				if(canMake[$item[Xiblaxian Ultraburrito]] > 0)
				{
					visit_url("shop.php?pwd=&whichshop=5dprinter&action=buyitem&quantity=1&whichrow=339", true);
				}
			}
		}
	}
}

boolean adjustEdHat(string goal)
{
	if(!possessEquipment($item[The Crown of Ed the Undying]))
	{
		return false;
	}
	int option = -1;
	goal = to_lower_case(goal);
	if(((goal == "muscle") || (goal == "bear")) && (get_property("edPiece") != "bear"))
	{
		option = 1;
	}
	else if(((goal == "myst") || (goal == "mysticality") || (goal == "owl")) && (get_property("edPiece") != "owl"))
	{
		option = 2;
	}
	else if(((goal == "moxie") || (goal == "puma")) && (get_property("edPiece") != "puma"))
	{
		option = 3;
	}
	else if(((goal == "ml") || (goal == "hyena")) && (get_property("edPiece") != "hyena"))
	{
		option = 4;
	}
	else if(((goal == "meat") || (goal == "item") || (goal == "items") || (goal == "drops") || (goal == "mouse")) && (get_property("edPiece") != "mouse"))
	{
		option = 5;
	}
	else if(((goal == "regen") || (goal == "regenerate") || (goal == "miss") || (goal == "dodge") || (goal == "weasel")) && (get_property("edPiece") != "weasel"))
	{
		option = 6;
	}

	if(option != -1)
	{
		visit_url("inventory.php?action=activateedhat");
		visit_url("choice.php?pwd=&whichchoice=1063&option=" + option, true);
		return true;
	}
	return false;
}

float edMeatBonus()
{
	if(have_skill($skill[Curse of Fortune]) && (item_amount($item[Ka Coin]) > 0))
	{
		return 200.0;
	}
	return 0.0;
}

boolean ed_doResting()
{
	if(!get_property("chateauAvailable").to_boolean() || get_property("timesRested").to_int() >= total_free_rests() || my_level() < 8 )
	{
		return false;
	}
	if(have_effect($effect[Prayer of Seshat]).to_int() >= 300)
	{
		return false;
	}
	
	if ((my_mp() + 110) < my_maxMP())
	{
		doRest();
	}
	
	if(monster_level_adjustment() > 50)
	{
		buffMaintain($effect[Hide of Sobek], 30, 3, 300);
	}
	buffMaintain($effect[Bounty of Renenutet], 30, 3, 300);
	buffMaintain($effect[Prayer of Seshat], 15, 3, 300);
	buffMaintain($effect[Wisdom of Thoth], 15, 3, 300);
	buffMaintain($effect[Power of Heka], 15, 3, 300);
	
	return true;
}

boolean ed_buySkills()
{
	if(my_level() <= get_property("ed_edSkills").to_int())
	{
		return false;
	}
	int possEdPoints = 0;
	int skillPoints = 0;

	string page = visit_url("place.php?whichplace=edbase&action=edbase_book");
	matcher my_skillPoints = create_matcher("You may memorize (\\d\+) more page", page);
	if(my_skillPoints.find())
	{
		skillPoints = to_int(my_skillPoints.group(1));
		if(skillPoints > 0)
		{
			print("Skill points found: " + skillPoints);
			possEdPoints += skillPoints;
		}
		possEdPoints = skillPoints - 1;

		if (get_property("ed_ignoreSkillPoints") != "") {
			skillPoints -= to_int(get_property("ed_ignoreSkillPoints"));
		}
		if (skillpoints > 8) {
			while(skillPoints > 0)
			{
				skillPoints = skillPoints - 1;
				int skillid = 20;
				if(!have_skill($skill[Curse of Vacation]))
				{
					skillid = 19;
				}
				if(!have_skill($skill[Curse of Fortune]))
				{
					skillid = 18;
				}
				if(!have_skill($skill[Curse of Heredity]))
				{
					skillid = 17;
				}
				if(!have_skill($skill[Curse of Yuck]))
				{
					skillid = 16;
				}
				if(!have_skill($skill[Curse of Indecision]))
				{
					skillid = 15;
				}
				if(!have_skill($skill[Curse of the Marshmallow]))
				{
					skillid = 14;
				}
				if(!have_skill($skill[Wrath of Ra]))
				{
					skillid = 13;
				}
				if(!have_skill($skill[Lash of the Cobra]))
				{
					skillid = 12;
				}
				if(!have_skill($skill[Bounty of Renenutet]))
				{
					skillid = 6;
				}
				if(!have_skill($skill[Shelter of Shed]))
				{
					skillid = 5;
				}
				if(!have_skill($skill[Blessing of Serqet]))
				{
					skillid = 4;
				}
				if(!have_skill($skill[Hide of Sobek]))
				{
					skillid = 3;
				}
				if(!have_skill($skill[Power of Heka]))
				{
					skillid = 2;
				}
				if(!have_skill($skill[Purr of the Feline]))
				{
					skillid = 11;
				}
				if(!have_skill($skill[Storm of the Scarab]))
				{
					skillid = 10;
				}
				if(!have_skill($skill[Roar of the Lion]))
				{
					skillid = 9;
				}
				if(!have_skill($skill[Howl of the Jackal]))
				{
					skillid = 8;
				}
				if(!have_skill($skill[Wisdom of Thoth]))
				{
					skillid = 1;
				}
				if(!have_skill($skill[Fist of the Mummy]))
				{
					skillid = 7;
				}
				if(!have_skill($skill[Prayer of Seshat]))
				{
					skillid = 0;
				}

				visit_url("choice.php?pwd&skillid=" + skillid + "&option=1&whichchoice=1051");
			}
		} else {
			while(skillPoints > 0)
			{
				skillPoints = skillPoints - 1;
				int skillid = 20;
				if(!have_skill($skill[Curse of Vacation]))
				{
					skillid = 19;
				}
				if(!have_skill($skill[Curse of Fortune]))
				{
					skillid = 18;
				}
				if(!have_skill($skill[Curse of Heredity]))
				{
					skillid = 17;
				}
				if(!have_skill($skill[Curse of Yuck]))
				{
					skillid = 16;
				}
				if(!have_skill($skill[Curse of Indecision]))
				{
					skillid = 15;
				}
				if(!have_skill($skill[Curse of the Marshmallow]))
				{
					skillid = 14;
				}
				if(!have_skill($skill[Wrath of Ra]))
				{
					skillid = 13;
				}
				if(!have_skill($skill[Lash of the Cobra]))
				{
					skillid = 12;
				}
				if(!have_skill($skill[Purr of the Feline]))
				{
					skillid = 11;
				}
				if(!have_skill($skill[Storm of the Scarab]))
				{
					skillid = 10;
				}
				if(!have_skill($skill[Roar of the Lion]))
				{
					skillid = 9;
				}
				if(!have_skill($skill[Howl of the Jackal]))
				{
					skillid = 8;
				}
				if(!have_skill($skill[Bounty of Renenutet]))
				{
					skillid = 6;
				}
				if(!have_skill($skill[Shelter of Shed]))
				{
					skillid = 5;
				}
				if(!have_skill($skill[Blessing of Serqet]))
				{
					skillid = 4;
				}
				if(!have_skill($skill[Hide of Sobek]))
				{
					skillid = 3;
				}
				if(!have_skill($skill[Power of Heka]))
				{
					skillid = 2;
				}
				if(!have_skill($skill[Wisdom of Thoth]))
				{
					skillid = 1;
				}
				if(!have_skill($skill[Fist of the Mummy]))
				{
					skillid = 7;
				}
				if(!have_skill($skill[Prayer of Seshat]))
				{
					skillid = 0;
				}

				visit_url("choice.php?pwd&skillid=" + skillid + "&option=1&whichchoice=1051");
			}
		}
		
	}
	#adding this after skill purchase, is mafia not detecting our skills?
	visit_url("charsheet.php");
	
	page = visit_url("place.php?whichplace=edbase&action=edbase_door");
	matcher my_imbuePoints = create_matcher("Impart Wisdom unto Current Servant ..100xp, (\\d\+) remain.", page);
	matcher my_servantPoints = create_matcher("You may release (\\d\+) more servant.", page);
	int imbuePoints = 0;
	int servantPoints = 0;
	if(my_imbuePoints.find())
	{
		imbuePoints = to_int(my_imbuePoints.group(1));
	}
	if(my_servantPoints.find())
	{
		servantPoints = to_int(my_servantPoints.group(1));
	}
	if(imbuePoints > 0)
	{
		print("Imbuement points found: " + imbuePoints);
		possEdPoints += imbuePoints;
	}
	if(servantPoints > 0)
	{
		print("Servant points found: " + servantPoints);
	}
	if(possEdPoints > get_property("edPoints").to_int())
	{
		print("Mismatch between Mafia's edPoints and calculated value from skill points and imbuement points!", "red");
		// (at the moment, I believe this may happen when we are ignoring some of the points.  I don't think we should mess with Mafia's value, though.)
		//set_property("edPoints", possEdPoints);
	}

	if (get_property("ed_ignoreImbuementPoints") != "") {
		imbuePoints -= to_int(get_property("ed_ignoreImbuementPoints"));
	}
	while(servantPoints > 0)
	{
		int sid = -1;
		if(!have_servant($servant[Maid]))
		{
			sid = 3;
		}
		if(!have_servant($servant[Belly-Dancer]) && !have_skill($skill[lash of the cobra]))
		{
			sid = 2;
		}
		if(!have_servant($servant[Cat]))
		{
			sid = 1;
		}
		if(!have_servant($servant[Scribe]))
		{
			sid = 5;
		}
		if(!have_servant($servant[Cat]) && !have_skill($skill[bounty of renenutet]))
		{
			sid = 1;
		}
		if(!have_servant($servant[Priest]))
		{
			sid = 6;
		}
		if(sid != -1)
		{
			visit_url("choice.php?whichchoice=1053&option=3&pwd&sid=" + sid);
		}
		
		servantPoints -= 1;
	}

	if((imbuePoints > 0) && (my_level() > 2))
	{
		while(imbuePoints > 0)
		{
			servant tryImbue = $servant[none];
			if(have_servant($servant[Priest]) && ($servant[Priest].experience < 81))
			{
				tryImbue = $servant[Priest];
			}
			else if(have_servant($servant[Scribe]) && ($servant[Scribe].experience < 441) && (imbuePoints > 4))
			{
				tryImbue = $servant[Scribe];
			}
			else if(have_servant($servant[Cat]) && ($servant[Cat].experience < 300))
			{
				tryImbue = $servant[Cat];
			}
			else if(have_servant($servant[Belly-Dancer]) && ($servant[Belly-Dancer].experience < 81))
			{
				tryImbue = $servant[Belly-Dancer];
			}
			else if(have_servant($servant[Scribe]) && ($servant[Scribe].experience < 221))
			{
				tryImbue = $servant[Scribe];
			}
			else if(have_servant($servant[Maid]) && ($servant[Maid].experience < 221) && have_skill($skill[Curse of Fortune]))
			{
				tryImbue = $servant[Maid];
			}
			else
			{
				if((imbuePoints > 4) && (my_level() >= 9))
				{
					if(have_servant($servant[Scribe]) && ($servant[Scribe].experience < 341))
					{
						tryImbue = $servant[Scribe];
					}
				}
			}

			if(tryImbue != $servant[none])
			{
				if(use_servant(tryImbue))
				{
					print("Trying to imbue " + tryImbue + " with glorious wisdom!!", "green");
					visit_url("choice.php?whichchoice=1053&option=5&pwd=");
				}
			}
			
			imbuePoints -= 1;
		}
	}

	if ((imbuePoints <= 0) && (servantPoints <= 0) && (skillPoints <= 0)) {
		set_property("ed_edSkills", my_level());
	}

	return true;
}

boolean ed_eatStuff()
{
	int canEat = (spleen_limit() - my_spleen_use()) / 5;
	int canDrink = inebriety_limit() - my_inebriety();
	int canOtherEat = fullness_limit() - my_fullness();
	if(canEat == 0 && canDrink == 0 && canOtherEat == 0)
	{
		return false;
	}

	//Spleens
	canEat = min(canEat, item_amount($item[Mummified Beef Haunch]));
	if(canEat > 0)
	{
		chew(canEat, $item[Mummified Beef Haunch]);
	}

	//TODO:  the code below doesn't "respect" the "dickstab" option....
	string cookie = get_counters("Fortune Cookie", 0, 200);
	if (cookie != "Fortune Cookie")
	{
		if(my_turncount() < 81)
		{
			return false;
		}
		if((my_meat() >= 500) && have_skill($skill[Replacement Liver]) && ((my_inebriety() == 0) || (my_inebriety() == 3)) && 0 < item_amount($item[Clan VIP Lounge key]))
		{
			cli_execute("drink 1 lucky lindy");
		}
		else if (
			(my_meat() >= 40)
			&& have_skill($skill[Replacement Stomach])
			&& ((my_fullness() == 0) || (fullness_limit() - my_fullness() == 1))
				//TODO:  I'm not sure what the reason is for this restriction
			&& (my_inebriety() == inebriety_limit() || 0 == item_amount($item[Clan VIP Lounge key]))
		)
		{
			buy(1, $item[Fortune Cookie]);
			eat(1, $item[Fortune Cookie]);
		}
	}
	return false;
/*
//Eats
	if(get_property("ed_dickstab").to_boolean() && !get_property("_fancyHotDogEaten").to_boolean() && ((my_fullness() + 2) <= fullness_limit()) && (item_amount($item[Clan VIP Lounge Key]) > 0) && !have_skill($skill[Dog Tired]) && get_property("chateauAvailable").to_boolean())
	{
//We're going to make the assumption here that you keep your hot dog stand stocked properly in advance
		cli_execute("eat 1 sleeping dog");
		if(!get_property("_fancyHotDogEaten").to_boolean())
		{
			abort("Failed eating sleeping dog (eat it manually I suppose?)....");
		}
	}
	if((item_amount($item[Xiblaxian Ultraburrito]) > 0) && (fullness_limit() - my_fullness() > 3) && (item_amount($item[Astral Hot Dog]) == 0))
	{
		createBurrito();
		eat(1, $item[Xiblaxian Ultraburrito]);
	}
	if((item_amount($item[Limp Broccoli]) > 0) && (my_level() >= 5) && ((my_fullness() == 0) || (my_fullness() == 3)) && (fullness_limit() >= 2))
	{
		eat(1, $item[Limp Broccoli]);
	}
	if((item_amount($item[Limp Broccoli]) > 0) && (my_level() >= 5) && (my_fullness() == 2) && (fullness_limit() >= 5) && (item_amount($item[Astral Hot Dog]) == 0))
	{
		eat(1, $item[Limp Broccoli]);
	}
	if((my_level() >= 11) && ((my_fullness() + 3) <= fullness_limit()) && (item_amount($item[Astral Hot Dog]) > 0))
	{
		eat(1, $item[Astral Hot Dog]);
	}
	if((my_level() >= 9) && ((my_fullness() + 3) <= fullness_limit()) && (item_amount($item[Astral Hot Dog]) > 0) && (my_adventures() < 4))
	{
		eat(1, $item[Astral Hot Dog]);
	}
	if(((my_fullness() + 3) <= fullness_limit()) && (item_amount($item[Tasty Tart]) > 0) && (item_amount($item[Astral Hot Dog]) == 0) )
	{
		eat(3, $item[Tasty Tart]);
	}
	if(((my_fullness() + 3) <= fullness_limit()) && (item_amount($item[Tasty Tart]) > 0) && (my_adventures() < 4))
	{
		eat(3, $item[Tasty Tart]);
	}
	
//Drinks
	if(item_amount($item[Astral Pilsner]) > 0)
	{
		if((my_inebriety() < inebriety_limit()) && (my_level() > 9) && (my_adventures() < 8) && (canEat == 0))
		{
			drink(1, $item[Astral Pilsner]);
		}
	}
	
	return true;
*/
	
//EXPERIMENTAL!!!!!! Thanks DeadNed
//
//	record food2beat {
//	   item name;
//	   float goodness;
//	   int size;
//	};
//	 
//	food2beat [int] jerky;
//	 
//	int counter=0;
//	 
//	foreach it in get_inventory() {
//	if (it.fullness >0){
//			string a=it.adventures;
//			string [int] b=split_string(a,"-");
//			float c;
//			int i=0;
//			foreach thing in b{
//					c += b[thing].to_int();
//					i+=1;
//					}
//			float e=c/i;
//	 
//			int h=it.fullness;
//			float j=e/h;
//			if (j==0)
//					j=1;
//		   
//			jerky[counter].name=it;
//			jerky[counter].goodness=j;
//			jerky[counter].size=h;
//			counter +=1;
//	 
//			}
//	}
//	sort jerky by -value.goodness;
//	for key from 0 to 10
//			print(jerky[key].name+": "+to_string(jerky[key].goodness,"%.2f")+" adv/full ("+jerky[key].size+" fullness) "+jerky[key].name.adventures);
//	print(" ");
//	 
//	for i from 0 to 10 {
//			print(" ");
//			print("sim["+i+"]");
//			int turnsGen=0;
//			int stomachSpace= fullness_limit()-my_fullness();
//			while (stomachSpace>0){
//					int eat1=available_amount(jerky[i].name);
//					int eat2=stomachSpace/jerky[i].size; //can't eat half a jerky.
//					if (eat2>eat1)
//							eat2=eat1;
//					if (eat2 != 0){
//							print("you'd eat: "+eat2+" "+jerky[i].name+" if you could!");
//							stomachSpace -= (eat2 * jerky[i].size);
//							turnsGen += (eat2 * jerky[i].goodness*jerky[i].size);
//							print("remaining space:"+stomachSpace);
//							}
//					i+=1;
//			}
//	}
}

record ed_ShoppingList {
	int[item] itemsToBuy;
	boolean[skill] skillsToBuy;
};

ed_ShoppingList ed_buildShoppingList(int kaAdjustment, int adventuresAdjustment) {
	ed_ShoppingList result;

	int coins = item_amount($item[Ka Coin]) + kaAdjustment;
	int adventures = my_adventures() + adventuresAdjustment;

	// Top priority is ensuring access the Hippy Camp, in order to guarantee 2Ka/adv.
	//TODO:  if we have access to, e.g., SMOOCH, then we don't need to prioritize the legs.
	if (!have_skill($skill[Upgraded Legs])) {
		if (10 <= coins) result.skillsToBuy[$skill[Upgraded Legs]] = true;
		return result;
	}

	int haunchesToBuy = (spleen_limit() - my_spleen_use()) / 5 - item_amount($item[Mummified Beef Haunch]);
	if (
		0 < haunchesToBuy
		&& (adventures + 20*item_amount($item[mummified beef haunch])) < 50
		&& 15 <= coins
	) {
		result.itemsToBuy[$item[Mummified Beef Haunch]] = 1;
		return result;
	}

	int futureKa = max(0, adventures - 5) * 0.5;  // A heuristic guess as to how much Ka we could spend today.
	int budget = coins + futureKa;

	if (0 < haunchesToBuy) budget -= 15;  // reserved for a future haunch

	// buying organs.  unlike Planned Parenthood, we expect to profit from them.
	if (!have_skill($skill[Extra Spleen])) {
		if (coins >= 5 + 15 && budget >= 5 + 15) {
			result.skillsToBuy[$skill[Extra Spleen]] = true;
		}
		return result;
	} else if (!have_skill($skill[Another Extra Spleen])) {
		if(coins >= 10 + 15 && budget >= 10 + 15)
		{
			result.skillsToBuy[$skill[Another Extra Spleen]] = true;
		}
		return result;
	}

	// note that once we reach this point, we have Upraded Legs, Extra Spleen, and Another Extra Spleen.
	// if we have many adventures, but only a few actual Ka on hand, then the remaining turngen organs
	// don't need to be purchased immediately.  We may potentially buy some MP restorers while we are
	// still waiting to accumulate Ka for bigger purchases.
	if (!have_skill($skill[Yet Another Extra Spleen])) {
		budget -= 15 + 15;
		if (coins >= 15 && budget >= 0)
		{
			result.skillsToBuy[$skill[Yet Another Extra Spleen]] = true;
			coins -= 15;
		}
	}
	if (!have_skill($skill[Replacement Stomach])) {
		budget -= 30;
		if (coins >= 30 && budget >= 0) {
			result.skillsToBuy[$skill[Replacement Stomach]] = true;
			coins -= 30;
		}
	}
	if (!have_skill($skill[Still Another Extra Spleen])) {
		budget -= 20 + 15;
		if (coins >= 20 && budget >= 0) {
			result.skillsToBuy[$skill[Still Another Extra Spleen]] = true;
			coins -= 20;
		}
	}
	if (!have_skill($skill[Just One More Extra Spleen])) {
		budget -= 25 + 15;
		if (coins >= 25 && budget >= 0) {
			result.skillsToBuy[$skill[Just One More Extra Spleen]] = true;
			coins -= 25;
		}
	}
	if (!have_skill($skill[Replacement Liver])) {
		budget -= 30;
		if (coins >= 30 && budget >= 0) {
			result.skillsToBuy[$skill[Replacement Liver]] = true;
			coins -= 30;
		}
	}
	if (!have_skill($skill[Okay Seriously, This is the Last Spleen])) {
		budget -= 30 + 15;
		if (coins >= 30 && budget >= 0) {
			result.skillsToBuy[$skill[Okay Seriously, This is the Last Spleen]] = true;
			coins -= 30;
		}
	}

	coins = max(0, min(coins, budget));

	if (get_property("ed_renenutetBought").to_int() < 7 && 1 < coins) {
		int renenutetToBuy = 7 - to_int(get_property("ed_renenutetBought"));
		if (my_spleen_use() < 30) renenutetToBuy = min(renenutetToBuy, max(0,2-item_amount($item[talisman of Renenutet])));
			// (Don't bother keeping more than a couple on hand, unless we might risk losing out on our daily allowance)
			//TODO:  we do need to make sure that we don't risk missing out on organs, though.
		renenutetToBuy = min(coins, renenutetToBuy);
		if (0 < renenutetToBuy) result.itemsToBuy[$item[talisman of Renenutet]] = renenutetToBuy;
		coins -= renenutetToBuy;
	}

	// MP restorers:
	// 1 Ka:  spring water restores ~50 & regenerates ~30  =>  80 MP/Ka
	// 2 Ka:  spirit beer restores ~90 & regenerates ~60  =>  75 MP/Ka
	// 3 Ka:  sacramental wine restores ~180 & regenerates ~90  =>  90 MP/Ka

	int mpUsed(skill s) { return have_skill(s) ? mp_cost(s) : 0; }
	// Hopefully, this can provide a useful heuristic of how much MP restoration to keep on hand:
	int mostMpUsedForOneAdventure
			= 3*mpUsed($skill[Fist of the Mummy])
			+ mpUsed($skill[Curse of Indecision])
			+ mpUsed($skill[Lash of the Cobra])
			+ mpUsed($skill[Wrath of Ra])
			+ mpUsed($skill[Curse of Vacation])
			+ mpUsed($skill[Curse of Stench]);
	mostMpUsedForOneAdventure = min(mostMpUsedForOneAdventure, my_maxmp());
	mostMpUsedForOneAdventure
		+= mpUsed($skill[Prayer of Seshat])
			+ mpUsed($skill[Wisdom of Thoth])
			+ mpUsed($skill[Power of Heka])
			+ mpUsed($skill[Hide of Sobek])
			+ mpUsed($skill[Blessing of Serqet])
			+ mpUsed($skill[Shelter of Shed])
			+ mpUsed($skill[Bounty of Renenutet])
			+ mpUsed($skill[Purr of the Feline]);

	int wineToBuy = (my_maxMP() < 180 ? 0 : mostMpUsedForOneAdventure / 180 + 1) - item_amount($item[sacramental wine]);
	while (0 < wineToBuy && 3 <= coins) {
		result.itemsToBuy[$item[sacramental wine]] += 1;
		wineToBuy -= 1;
		coins -= 3;
	}

	int springWaterToBuy = 1 + (mostMpUsedForOneAdventure - 180 * item_amount($item[sacramental wine]) - 180 * result.itemsToBuy[$item[sacramental wine]]) / 50;
	springWaterToBuy -= item_amount($item[Holy Spring Water]);
	while (0 < springWaterToBuy && 1 <= coins) {
		result.itemsToBuy[$item[Holy Spring Water]] += 1;
		springWaterToBuy -= 1;
		coins -= 1;
	}
/*
	int spiritBeerToBuy = (my_maxMP() < 80 ? 0 : my_maxMP() < 180 ? 2 : 0)
		- item_amount($item[spirit beer]);
	while (0 < spiritBeerToBuy && 2 <= coins) {
		result.itemsToBuy[$item[spirit beer]] += 1;
		spiritBeerToBuy -= 1;
		coins -= 2;
	}
*/

	if (!have_skill($skill[More Legs])) {
		coins -= 20;
		if (coins >= 0) {
			result.skillsToBuy[$skill[More Legs]] = true;
		}
	}

	if (!have_skill($skill[Elemental Wards])) {
		coins -= 10;
		if (coins >= 0) {
			result.skillsToBuy[$skill[Elemental Wards]] = true;
		}
	} else if (!have_skill($skill[More Elemental Wards])) {
		coins -= 20;
		if (coins >= 0) {
			result.skillsToBuy[$skill[More Elemental Wards]] = true;
		}
	} else if (!have_skill($skill[Even More Elemental Wards])) {
		coins -= 30;
		if (coins >= 0) {
			result.skillsToBuy[$skill[Even More Elemental Wards]] = true;
		}
	}

	if (
		!have_skill($skill[Tougher Skin])
		&& (1 < my_daycount() || 50 < monster_level_adjustment())
		&& 10 <= coins
	) {
		result.skillsToBuy[$skill[Tougher Skin]] = true;
		coins -= 10;
	}


	if (!have_skill($skill[Armor Plating]) && (my_daycount() > 1) && (coins > 20)) {
		result.skillsToBuy[$skill[Armor Plating]] = true;
		coins -= 20;
	} else if (!have_skill($skill[Upgraded Spine]) && (my_daycount() > 1) && (coins > 20)) {
		result.skillsToBuy[$skill[Upgraded Spine]] = true;
		coins -= 20;
	}
	else if (!have_skill($skill[Upgraded Arms]) && (my_daycount() > 1) && (coins > 20)) {
		result.skillsToBuy[$skill[Upgraded Arms]] = true;
		coins -= 20;
	}
	/*
	else if ((!have_skill($skill[Healing Scarabs])) && (my_daycount() > 1) && (coins > 20)) {
		result.skillsToBuy[$skill[Healing Scarabs]] = true;
		coins -= 20;
	} */  // these just seem counterproductive to me.  What are they for?

	int linenToBuy = my_maxHP() / 30;
		// (that's about enough for one full heal)
		// note, The Horror takes around 150 hp, iirc, when we normally do it.  Maybe keep 5 on hand, if we need to finish A-Boo?  Keep one on hand for Zerg Rush.
	if (my_level() < 9) linenToBuy = 0;  // (level 9 is peaks quest)
	if (get_property("booPeakProgress") == "0") linenToBuy = 3;
	linenToBuy -= item_amount($item[linen bandages]);
	while (0 < linenToBuy && 1 <= coins) {
		result.itemsToBuy[$item[linen bandages]] += 1;
		linenToBuy -= 1;
		coins -= 1;
	}

	int horusToBuy = 2;
	if (my_level() < 12) horusToBuy = 1;  // (level 12 is war quest)
	if ("none" != get_property("sidequestLighthouseCompleted")) horusToBuy = 1;
	horusToBuy -= item_amount($item[talisman of Horus]);
	while (0 < horusToBuy && 5 <= coins) {
		result.itemsToBuy[$item[talisman of Horus]] += 1;
		horusToBuy -= 1;
		coins -= 5;
	}

	int cureAllsToBuy = 2 - item_amount($item[ancient cure-all]) - item_amount($item[Soft Green Echo Eyedrop Antidote]);
	if (coins < 30) cureAllsToBuy = 0;
		//FIXME:  need to fix cureall wastage, first!  For now, avoid spending Ka on them.  unless we have plenty of Ka.
	while (0 < cureAllsToBuy && 5 <= coins) {
		result.itemsToBuy[$item[ancient cure-all]] += 1;
		cureAllsToBuy -= 1;
		coins -= 3;
	}

	return result;
}
ed_ShoppingList ed_buildShoppingList() {
	return ed_buildShoppingList(0, 0);
}

void display(ed_ShoppingList l) {
	foreach i,q in l.itemsToBuy print("Buy " + q + " " + i, "green");
	foreach s in l.skillsToBuy print("Buy " + s, "green");
}

boolean needShop(ed_ShoppingList l) {
	return 0 < count(l.itemsToBuy) || 0 < count(l.skillsToBuy);
}

boolean ed_needShop() {
	return needShop(ed_buildShoppingList());
}

boolean ed_shopping()
{
	ed_ShoppingList shoppingList = ed_buildShoppingList();

	if(!needShop(shoppingList) && !get_property("ed_breakstone").to_boolean())
	{
		return false;
	}
	print("Time to shop!", "green");
	display(shoppingList);
	wait(5);
	visit_url("choice.php?pwd=&whichchoice=1023&option=1", true);

	if(get_property("ed_breakstone").to_boolean())
	{
		visit_url("place.php?whichplace=edunder&action=edunder_hippy");
		visit_url("choice.php?pwd&whichchoice=1057&option=1", true);
		set_property("ed_breakstone", false);
	}

	int[item] row;
	row[$item[mummified beef haunch]] = 428;
	row[$item[linen bandages]] = 429;
	row[$item[silk bandages]] = 431;
	row[$item[spirit beer]] = 432;
	row[$item[sacramental wine]] = 433;
	row[$item[ancient cure-all]] = 435;
	row[$item[holy spring water]] = 436;
	row[$item[Talisman of Horus]] = 693;
	row[$item[Talisman of Renenutet]] = 439;

	while (needShop(shoppingList)) {
		foreach i,q in shoppingList.itemsToBuy {
			if (!(row contains i)) abort("Don't know how to buy " + i + " at the underworld shop");
			print("Buying " + i, "green");
			for j from 1 to q {
				visit_url("shop.php?pwd=&whichshop=edunder_shopshop&action=buyitem&quantity=1&whichrow=" + row[i], true);
				if (i == $item[talisman of Renenutet]) {
					set_property("ed_renenutetBought", 1 + get_property("ed_renenutetBought").to_int());
				}
			}
		}

		if (0 < count(shoppingList.skillsToBuy)) {
			visit_url("place.php?whichplace=edunder&action=edunder_bodyshop");
			foreach skillBuy in shoppingList.skillsToBuy {
				print("Buying " + skillBuy, "green");
				visit_url("choice.php?pwd&skillid=" + (to_int(skillBuy)-17000) + "&option=1&whichchoice=1052", true);
			}
			visit_url("choice.php?pwd&option=2&whichchoice=1052", true);
		}
		shoppingList = ed_buildShoppingList();
		if (needShop(shoppingList)) {
			print("Continuing to shop!", "green");
			display(shoppingList);
			wait(5);
		}
	}

	visit_url("place.php?whichplace=edunder&action=edunder_leave");
	visit_url("choice.php?pwd=&whichchoice=1024&option=1", true);
	return true;
}

servant ed_servant;
boolean ed_use_servant(servant which) {
        if (have_servant(which)) {
		ed_servant = which;
		return true;
	}
	return false;
}
void ed_use_servant() {
        if (
		ed_servant != $servant[none]
		&& ed_servant != my_servant()
	) use_servant(ed_servant);
}

boolean ed_handleAdventureServant(location loc)
{
//Default state (priest) and handling getting gifts
	if(!ed_use_servant($servant[priest]))
	{
		return false;
	}
	ed_use_servant($servant[Priest]);
	if(($servant[Scribe].experience == 441) && !have_skill($skill[Gift of the Scribe]) && have_servant($servant[Scribe]))
	{
		ed_use_servant($servant[Scribe]);
	}
	if(($servant[Cat].experience == 441) && !have_skill($skill[Gift of the Cat]) && have_servant($servant[Cat]))
	{
		ed_use_servant($servant[Cat]);
	}
	boolean reassign = false;
	if((my_daycount() > 1) && (my_level() > 10))
	{
		reassign = true;
	}
	if(reassign)
	{
		if((!have_skill($skill[Gift of the Scribe]) || (my_level() < 13)) && have_servant($servant[Scribe]))
		{
			ed_use_servant($servant[Scribe]);
		}
		else if(!have_skill($skill[Gift of the Cat]) && have_servant($servant[Cat]) && !get_property("ed_galleryFarm").to_boolean())
		{
			ed_use_servant($servant[Cat]);
		}
		else
		{
			ed_use_servant($servant[Scribe]);
		}
	}

//Per location handling
	if((loc == $location[The Defiled Nook]) ||
		(loc == $location[The Haunted Library]) ||
		(loc == $location[The Haunted Laundry Room]) ||
		(loc == $location[The Haunted Wine Cellar]) ||
		(loc == $location[Oil Peak]) ||
		(loc == $location[The Hidden Bowling Alley]) ||
		(loc == $location[The Hidden Temple]) ||
		(loc == $location[A-Boo Peak]) ||
		(loc == $location[The Goatlet]) ||
		(loc == $location[The Hidden Park]) && (get_property("relocatePygmyJanitor") == my_ascensions()))
	{
		if(!ed_use_servant($servant[Cat]))
		{
			if(!ed_use_servant($servant[Scribe]))
			{
				ed_use_servant($servant[Maid]);
			}
		}
	}
	if((loc == $location[The Dark Neck of the Woods]) ||
		(loc == $location[The Dark Heart of the Woods]) ||
		(loc == $location[The Dark Elbow of the Woods]))
	{
		if((get_property("ed_pirateoutfit") != "finished") && (get_property("ed_pirateoutfit") != "almost") && (item_amount($item[Hot Wing]) < 3))
		{
			if(!ed_use_servant($servant[Cat]))
			{
				ed_use_servant($servant[Scribe]);
			}
		}
		else
		{
			if(!ed_use_servant($servant[Scribe]))
			{
				ed_use_servant($servant[Cat]);
			}
		}
	}
	if((loc == $location[The Defiled Alcove]) ||
		(loc == $location[The Defiled Cranny]) ||
		(loc == $location[The Defiled Niche]) ||
		(loc == $location[The Haunted Bedroom]) ||
		(loc == $location[The Haunted Ballroom]) ||
		(loc == $location[The Haunted Billiards Room]) ||
		(loc == $location[The Haunted Kitchen]) ||
		(loc == $location[The Haunted Bathroom]) ||
		(loc == $location[The Haunted Library]) ||
		(loc == $location[The Haunted Gallery] && get_property("ed_galleryFarm").to_boolean()))
	{
		if(!ed_use_servant($servant[Scribe]))
		{
			//use_servant($servant[Cat]);
		}
	}
	if(loc == $location[The Themthar Hills])
	{
		ed_use_servant($servant[Maid]);
	}

	//The cat is swapped in at the shrines while macheteing them because your servant still gets xp points and it usually still needs some at this point, also sparrows. :D
	// For the rest of these locations, the cat is used for item drops.
	//TODO:  do we want the cat for the gremlins, for deleveling?
	if (
		(loc == $location[The Black Forest] && item_amount($item[reassembled blackbird]) == 0) ||
		(loc == $location[An Overgrown Shrine (Northwest)]) ||
		(loc == $location[An Overgrown Shrine (Northeast)]) ||
		(loc == $location[An Overgrown Shrine (Southwest)]) ||
		(loc == $location[An Overgrown Shrine (Southeast)]) ||
		(loc == $location[A Massive Ziggurat] && item_amount($item[stone triangle]) == 0) ||
		(loc == $location[The Hatching Chamber] && !have_skill($skill[Lash of the Cobra])) ||  //TODO:  or, if we are low/out of lashes?  Will that ever happen?
		(loc == $location[The Feeding Chamber] && !have_skill($skill[Lash of the Cobra])) ||
		(loc == $location[The Royal Guard Chamber] && !have_skill($skill[Lash of the Cobra])) ||
		(loc == $location[Wartime Frat House] && !have_skill($skill[Wrath of Ra])) ||
		(loc == $location[The F'c'le])
		|| (loc == $location[The Secret Council Warehouse])
	)
	{
		ed_use_servant($servant[Cat]);
	}

	if ($servant[Priest] == ed_servant && 50 <= item_amount($item[Ka coin])) ed_use_servant($servant[Scribe]);
	if ($servant[Scribe] == ed_servant && 13 <= my_level()) ed_use_servant($servant[Priest]);
	if (50 <= item_amount($item[Ka coin]) && 13 <= my_level()) ed_use_servant($servant[Cat]);
	return false;
}

boolean ed_preAdv(int num, location loc)
{
	set_location(loc);
	ed_handleAdventureServant(loc);
	ed_preadventure();
	
//Attempts to farm ultra-burrito ingredients if you have that option available
	if((have_equipped($item[Xiblaxian Holo-Wrist-Puter])) && (howLongBeforeHoloWristDrop() <= 1))
	{
		string area = loc.environment;
		item replace = $item[none];
		if((item_amount($item[Pirate Fledges]) > 0) && (can_equip($item[Pirate Fledges])))
		{
			replace = $item[Pirate Fledges];
		}

		# If we migrate all Ed workaround combats to the bypasser, we don't need to check main.php
		if(!contains_text(visit_url("main.php"), "Combat"))
		{
			if(loc == $location[Noob Cave])
			{
				equip($slot[acc3], replace);
				return true;
			}
			
			if((area == "indoor") && (item_amount($item[Xiblaxian Circuitry]) > 0))
			{
				equip($slot[acc3], replace);
			}
			else if((area == "outdoor") && (item_amount($item[Xiblaxian Polymer]) > 0))
			{
				equip($slot[acc3], replace);
			}
			else if((area == "underground") && (item_amount($item[Xiblaxian Alloy]) > 2))
			{
				equip($slot[acc3], replace);
			}
			else
			{
				print("We should be getting a Xiblaxian wotsit this combat. Beep boop.", "green");
			}
		}
	}

	return true;
}

boolean ed_ccAdv(int num, location loc, string option, boolean skipFirstLife)
{
	boolean status = false;
	if(option == "") option = "ed_edCombatHandler";  //TODO:  it's always ed_edCombatHandler, right??  No, sometimes it's the gremlins one.
	buffer page = visit_url("main.php");
	boolean mainMapAvailable = contains_text(page, "<b>The Kingdom of Loathing</b>");
	boolean inCombat = contains_text(page, "<b>Combat!</b>");
		//FIXME:  this is just for testing purposes.  remove.
	if(!skipFirstLife)
	{
		if (!mainMapAvailable) {
			abort("Edscension internal error!  ed_ccAdv called with \"!skipFirstLife\", but no access to the main map!");
		}
		ed_preAdv(num, loc);
		ed_use_servant();
	} else {
		if (mainMapAvailable) {
			// (note that this is harmless.  we don't start any new adventures, and break out of the loop when we see that we have access to the main map.)
			abort("Edscension internal error!  ed_ccAdv called with \"skipFirstLife\", but we are not yet in an adventure!");
		}
	}

	set_property("ed_disableAdventureHandling", "yes");

	if (get_property("_edDefeats") == "0") set_property("ed_edCombatHandler", "");
		//FIXME:  that only works heuristically; false positives & negatives both possible.
	for i from 0 to get_property("edDefeatAbort").to_int()+3 {  //TODO:  the +3 is because I am adjusting edDefeatAbort from within the combat filter, if we are flyering.
		int stage = get_property("_edDefeats").to_int();

		set_property("autoAbortThreshold", "-10.0");
		set_property("ed_edCombatStage", stage);

		if(!skipFirstLife || contains_text(page, "<b>Combat!</b>"))
		{
			print("Automating stage " + stage + " of Ed Battle at " + loc, "blue");
			status = adv1(loc, 0, option);
			if(!status && (get_property("lastEncounter") == "Like a Bat Into Hell"))
			{
				set_property("ed_disableAdventureHandling", "no");
				abort("Either a\) We had a connection problem and lost track of the battle, or b\) we were defeated multiple times beyond our usual UNDYING. Manually handle the fight and rerun.");
			}
			page = visit_url("main.php");
		}

		if(last_monster() == $monster[Crate])
		{
			abort("We went to the Noob Cave for reals... uh oh");
		}

		if (contains_text(page, "<b>The Kingdom of Loathing</b>")) break;
		matcher m = create_matcher("<input type=hidden name=whichchoice value=([0-9]+)>", page);
		int whichChoice = m.find() ? m.group(1).to_int() : -1;
		if (
			-1 != whichChoice && 1023 != whichChoice && 1024 != whichChoice
				// this covers all choice adventures, except for entering/leaving The Underworld.
		) {
			print("Automating choice " + whichChoice + " at " + my_location() , "blue");
			status = adv1(loc, 0, option);
			page = visit_url("main.php");
			whichChoice = m.find() ? m.group(1).to_int() : -1;
		}
		if (contains_text(page, "<b>The Kingdom of Loathing</b>")) break;
		if (1023 != whichChoice && 1024 != whichChoice && !contains_text(page, "<b>The Underworld</b>")) break;

		if (get_property("edDefeatAbort").to_int() <= get_property("_edDefeats").to_int()) {
			abort("We have exceeded the number of UNDEATHS that this script handles automatically!  You'll have to manually pay up, or spend an adventure to return to your tomb.");
				//TODO:  automatically spend an adventure, as long as we simply appear to be a bit unlucky.
		}

		print("Ed has UNDYING!" , "blue");
		if (1024 == whichChoice) {
			page = visit_url("choice.php?pwd=&whichchoice=1024&option=3", true);
		}
		if(!ed_shopping())
		{
			page = visit_url("choice.php?pwd=&whichchoice=1023&option=2", true);
		}

		if(get_property("_edDefeats").to_int() == 0)
		{
			print("Monster defeated in initialization.  Combat is over.", "green");
			break;
		}

		skipFirstLife = get_property("_edDefeats").to_int() == stage + 2;
	}
	set_property("ed_edCombatStage", 0);
	set_property("ed_disableAdventureHandling", "no");
	cli_execute("ed_postadventure.ash");

	return status;
}

