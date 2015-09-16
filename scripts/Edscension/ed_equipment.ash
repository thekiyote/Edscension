script "ed_equipment.ash";
import <ed_util.ash>
void equipBaseline();
void equipBaselineWeapon();
void equipBaselinePants();
void equipBaselineBack();
void equipBaselineShirt();
void equipBaselineHat();
void equipBaselineAcc1();
void equipBaselineAcc2();
void equipBaselineAcc3();
void equipBaselineHat(boolean wantNC);
void equipRollover();
void handleOffHand();
boolean possessEquipment(item equipment);

boolean possessEquipment(item equipment)
{
	if(item_amount(equipment) > 0)
	{
		return true;
	}
	if(equipped_item($slot[hat]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[back]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[shirt]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[weapon]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[off-hand]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[pants]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc1]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc2]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[acc3]) == equipment)
	{
		return true;
	}
	if(equipped_item($slot[familiar]) == equipment)
	{
		return true;
	}
	return false;
}

void handleOffHand()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Hot Plate, Disturbing Fanfic, Coffin Lid];

	if(weapon_hands(equipped_item($slot[weapon])) > 1)
	{
		return;
	}

	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if(contains_text(holiday(), "Oyster Egg Day"))
	{
		if((toEquip == $item[none]) || (poss contains toEquip))
		{
			if(!possessEquipment($item[Oyster Basket]) && (my_meat() >= 300))
			{
				buy(1, $item[Oyster Basket]);
			}
			if(possessEquipment($item[Oyster Basket]))
			{
				toEquip = $item[Oyster Basket];
			}
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[off-hand])))
	{
		equip($slot[Off-hand], toEquip);
	}
}

void equipBaselineHat()
{
	equipBaselineHat(true);
}

void equipBaselinePants()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Old Sweatpants, Knob Goblin Pants, Filthy Corduroys, Swashbuckling Pants, Leotarrrd, Distressed Denim Pants, Troll Britches, Astral Shorts];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[pants])))
	{
		equip(toEquip);
	}
}

void equipBaselineShirt()
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Astral Shirt];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[shirt])))
	{
		equip(toEquip);
	}
}

void equipBaselineBack()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Giant Gym Membership Card, Misty Cloak, Misty Cape, Misty Robe];

	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[back])))
	{
		equip(toEquip);
	}
}

void equipBaselineHat(boolean wantNC)
{
	item toEquip = $item[none];

	boolean[item] poss = $items[Hollandaise Helmet, Viking Helmet, Chef\'s Hat, Crown of the Goblin King, Safarrri Hat, Mohawk Wig, Fuzzy Earmuffs, Reinforced Beaded Headband, Giant Yellow Hat, 8185];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}

		if(my_class() == $class[Ed])
		{
			if(possessEquipment(thing) && (thing == $item[8185]))
			{
				toEquip = thing;
				visit_url("inv_equip.php?pwd=&which=2&action=equip&whichitem=8185");
				return;
			}
		}
	}

	if(wantNC)
	{
		if(possessEquipment($item[Xiblaxian Stealth Cowl]))
		{
			toEquip = $item[Xiblaxian Stealth Cowl];
		}
	}

	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[hat])))
	{
		equip(toEquip);
	}
}

void equipBaselineWeapon()
{
	item toEquip = $item[none];
	boolean[item] poss;

	switch(my_class())
	{
	case $class[Ed]:
#		poss = $items[Titanium Assault Umbrella, Staff of Ed];
		poss = $items[Spiked Femur, Grassy Cutlass, Oversized Pizza Cutter, Titanium Assault Umbrella, Ocarina of Space, sewage-clogged pistol, 7961];
		break;
	default:
		abort("You don't have a valid class for this equipper, must be an avatar path or something.");
		break;
	}

	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[weapon])))
	{
		equip($slot[weapon], toEquip);
	}

	handleOffHand();
}

void equipBaselineAcc1()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Astral Mask, Astral Belt, Astral Ring, Astral Bracer];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc1])))
	{
		equip($slot[acc1], toEquip);
	}
}

void equipBaselineAcc2()
{
	item toEquip = $item[none];
	boolean[item] poss;
	if((my_level() >= 13) && (get_property("flyeredML").to_int() >= 10000))
	{
		poss = $items[Glowing Red Eye, First-Aid Pouch, Bonerdagon Necklace, Jangly Bracelet, Pirate Fledges, Iron Beta of Industry];
	}
	else
	{
		poss = $items[Jolly Roger Charrrm Bracelet, Glowing Red Eye, First-Aid Pouch, Jangly Bracelet, Pirate Fledges, Compression Stocking, Iron Beta of Industry, perfume-soaked bandana];
	}
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc2])))
	{
		equip($slot[acc2], toEquip);
	}
}

void equipBaselineAcc3()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Glowing Red Eye, Xiblaxian Holo-Wrist-Puter, Badge Of Authority];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}
}

void equipBaseline()
{
	equipBaselineHat();
	equipBaselineShirt();
	equipBaselineWeapon();
	handleOffHand();
	equipBaselinePants();
	equipBaselineBack();
	equipBaselineAcc1();
	equipBaselineAcc2();
	equipBaselineAcc3();
}

void equipRollover()
{
	item toEquip = $item[none];
	boolean[item] poss = $items[Gold Wedding Ring];
	foreach thing in poss
	{
		if(possessEquipment(thing) && can_equip(thing))
		{
			toEquip = thing;
		}
	}
	if((toEquip != $item[none]) && (toEquip != equipped_item($slot[acc3])))
	{
		equip($slot[acc3], toEquip);
	}
}

string ed_maximizationString;
string ed_maximizationStringForCachedEquipmentPredictions;
item[int] ed_equipmentForCachedEquipmentPredictions;
	//TODO:  are there other factors that the maximizer took into account, that may have changed since we cached its reccomendations?

void ed_setMaximization(string maxString) {
	ed_maximizationString = maxString;
	//if (60 <= my_basestat($stat[Mysticality]) && !contains_text(maxString, "swash")) ed_maximizationString += ", equip solid gold pegleg";
		// (handicap)
	ed_maximizationStringForCachedEquipmentPredictions = "";
}

void ed_appendMaximization(string maxString) {
	if (contains_text(maxString, "swash")) ed_maximizationString = ed_maximizationString.replace_string(", equip solid gold pegleg", "");
	ed_maximizationString += maxString;
	ed_maximizationStringForCachedEquipmentPredictions = "";
}

float ed_predictMaximizationModifier(string modifier) {
	if (ed_maximizationStringForCachedEquipmentPredictions != ed_maximizationString) {
		ed_equipmentForCachedEquipmentPredictions.clear();
		foreach i,r in maximize(ed_maximizationString, 0, 0, true, true) {
			if ($slot[none] == to_slot(r.item)) continue;
			if ($slot[off-hand] == to_slot(r.item)) {
				boolean noConflict = true;
				foreach j,w in ed_equipmentForCachedEquipmentPredictions {
					if ($slot[weapon] == to_slot(w) && 2 == weapon_hands(w)) {
						noConflict = false;
						break;
					}
				}
				if (!noConflict) continue;
			}
			ed_equipmentForCachedEquipmentPredictions[count(ed_equipmentForCachedEquipmentPredictions)] = r.item;
		}
		ed_maximizationStringForCachedEquipmentPredictions = ed_maximizationString;
	}
	float result = 0.0;
	foreach s in $slots[] {
		result -= numeric_modifier(equipped_item(s), modifier);
	}
	foreach i,equippedItem in ed_equipmentForCachedEquipmentPredictions {
		result += numeric_modifier(equippedItem, modifier);
	}
	return result;
}

void ed_maximize() {
	float[string] predictions;
	foreach mn in $strings[cold resistance, spooky resistance, Maximum HP, Muscle, Muscle Percent, Pool Skill, Initiative, ML] {
		predictions[mn] = numeric_modifier(mn) + ed_predictMaximizationModifier(mn);
	}

	print("maximizing '" + ed_maximizationString + "'", "orange");
	//boolean success = maximize("equip solid gold pegleg, " + ed_maximizationString, 1, 0, false);
	boolean success = maximize(ed_maximizationString, 1, 0, false);
	if (!success) abort("We seem to be unabled to equip some required item(s).");

	foreach mn,v in predictions {
		if (numeric_modifier(mn) != predictions[mn]) abort("Our prediction for " + mn + " was not correct.  Predicted " + predictions[mn] + ", but got " + numeric_modifier(mn) + ".");
	}
}

