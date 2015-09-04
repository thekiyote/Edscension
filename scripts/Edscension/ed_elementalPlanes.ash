script "ed_elementalPlanes.ash"

boolean elementalPlanes_initializeSettings()
{
/*
	string temp = "";

	if(!get_property("sleazeAirportAlways").to_boolean())
	{
		temp = visit_url("place.php?whichplace=airport_sleaze&intro=1");
		if(contains_text(temp, "you take a short, turbulence-free flight to Spring Break Beach."))
		{
			print("We have access to Spring Break Beach. Woo.", "green");
			set_property("sleazeAirportAlways", true);
		}
	}

	if(!get_property("spookyAirportAlways").to_boolean())
	{
		temp = visit_url("place.php?whichplace=airport_spooky&intro=1");
		if(contains_text(temp, "Your flight to Conspiracy Island is nasty, brutish and short."))
		{
			print("We have access to Conspiracy Island. Boo.", "green");
			set_property("spookyAirportAlways", true);
		}
	}

	if(!get_property("stenchAirportAlways").to_boolean())
	{
		temp = visit_url("place.php?whichplace=airport_stench&intro=1");
		if(contains_text(temp, "You get in line with the thousands of other passengers bound for Dinseylandfill."))
		{
			print("We have access to Dinseylandfill. Eww.", "green");
			set_property("stenchAirportAlways", true);
		}
	}

	if(!get_property("hotAirportAlways").to_boolean())
	{
		temp = visit_url("place.php?whichplace=airport_hot&intro=1");
		if(contains_text(temp, "FIXME"))
		{
			print("We have access to That 70's Volcano.  Ooh.", "green");
			set_property("hotAirportAlways", true);
		}
	}
*/
	return true;
}


boolean elementalPlanes_access(element ele)
{
	return (get_property("_" + ele + "AirportToday").to_boolean() || get_property(ele + "AirportAlways").to_boolean());
	//return get_property(ele + "AirportAlways").to_boolean();
}

boolean elementalPlanes_takeJob(element ele)
{
	if(!elementalPlanes_access(ele))
	{
		return false;
	}

	switch(ele)
	{
	case $element[spooky]:
		visit_url("place.php?whichplace=airport_spooky&action=airport2_radio");
		visit_url("choice.php?pwd&whichchoice=984&option=1", true);
		return true;
	case $element[stench]:
		string page = visit_url("place.php?whichplace=airport_stench&action=airport3_kiosk");
		int choice = 1;
		int at = index_of(page, "Available Assignments");
		if(at == -1)
		{
			return false;
		}

		int sustenance = index_of(page, "Guest Sustenance Assurance", at);
		boolean[string] jobs = $strings[Racism Reduction, Compulsory Fun, Waterway Debris Removal, Bear Removal, Electrical Maintenance, Track Maintenance, Sexism Reduction];

		if(sustenance != -1)
		{
			print("Trying to avoid Guest Sustenance Assurance Dinseylandfill job.", "blue");
			foreach job in jobs
			{
				int newAt = index_of(page, job, at);
				if(newAt != -1)
				{
					print("Found new job option: " + job, "blue");
					if(newAt < sustenance)
					{
						choice = 1;
					}
					else
					{
						choice = 2;
					}
				}
			}
		}

		visit_url("choice.php?pwd=&whichchoice=1066&option=" + choice,true);
		return true;
	}
	return false;
}

boolean dinseylandfill_garbageMoney()
{
	if(!elementalPlanes_access($element[stench]))
	{
		return false;
	}
	if(get_property("ed_dinseyGarbageMoney").to_int() == my_daycount())
	{
		return false;
	}
	if(!get_property("ed_getDinseyGarbageMoney").to_boolean())
	{
		return false;
	}
	if(item_amount($item[Bag of Park Garbage]) > 0)
	{
		set_property("ed_dinseyGarbageMoney", my_daycount());
		visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
		visit_url("choice.php?pwd=&whichchoice=1067&option=6",true);
		visit_url("main.php");
		cli_execute("refresh inv");
		return true;
	}
	else
	{
		return false;
	}

	return false;
}

int[item] ed_smoochQuestItemToDoor() {
	int[item] result;
	result[$item[the tongue of Smimmons]] = 1;
	result[$item[Raul's guitar pick]] = 2;
	result[$item[Pener's crisps]] = 3;
	result[$item[signed deuce]] = 4;
	return result;
}

boolean ed_smoochQuestAvailable() {
	if (!to_boolean(get_property("hotAirportAlways")) && !to_boolean(get_property("_hotAirportToday"))) return false;
	if (to_boolean(get_property("_volcanoItemRedeemed"))) return false;

	//TODO:  avoid unnecessary server hits
	buffer questsPage = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");
	int[item] itemToDoor = ed_smoochQuestItemToDoor();
	for i from 1 to 3 {
		item questItem = to_item(get_property("_volcanoItem" + i));
		if (itemToDoor contains questItem) return true;
	}
	return false;
}

boolean ed_smoochQuestItemAvailable() {
	foreach i in ed_smoochQuestItemToDoor() {
		if (0 < item_amount(i)) return true;
	}
	return false;
}

void ed_selectSmoochDoor() {
	if (!(to_boolean(get_property("hotAirportAlways")) || to_boolean(get_property("_hotAirportToday")))) return;
	int[item] itemToDoor = ed_smoochQuestItemToDoor();
	item[int] items;
	foreach i in itemToDoor {
		items[count(items)] = i;
	}
	sort items by random(10000);
		// if all else fails, pick one randomly.
	item selected = items[0];
	foreach k,i in items {
		if (item_amount(i) < item_amount(selected)) selected = i;
	}
	if (!to_boolean(get_property("_volcanoItemRedeemed"))) {
		buffer questsPage = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");
		for i from 1 to 3 {
			item questItem = to_item(get_property("_volcanoItem" + i));
			if (itemToDoor contains questItem) {
				selected = questItem;
			}
		}
	}
	if (!(itemToDoor contains selected)) abort("Failed to select a valid quest item!");
	set_property("choiceAdventure1094", itemToDoor[selected]);
}

void ed_turnInVolcanoQuestItem() {
	if (!(to_boolean(get_property("hotAirportAlways")) || to_boolean(get_property("_hotAirportToday")))) return;
	if (!to_boolean(get_property("_volcanoItemRedeemed"))) {
		buffer questsPage = visit_url("place.php?whichplace=airport_hot&action=airport4_questhub");
		int selection;
		for i from 1 to 3 {
			item questItem = to_item(get_property("_volcanoItem" + i));
			if (ed_smoochQuestItemToDoor() contains questItem) {
				// I'll prefer the SMOOCH quest items (at least for now).
				selection = i;
				break;
			}
			if (item_amount(to_item(get_property("_volcanoItem" + selection))) < item_amount(questItem)) {
				selection = i;
			}
		}
		if (0 == selection) return;
		visit_url("choice.php?whichchoice=1093&option=" + selection);
	}
}

