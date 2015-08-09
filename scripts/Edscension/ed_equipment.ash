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
