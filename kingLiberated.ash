script "kingLiberated.ash";
import <zlib.ash>
import <ed_util.ash>

void handleKingLiberation()
{
	if((get_property("kingLiberated") == "true") && (get_property("ed_snapshot") == ""))
	{
		print("Yay! The King is saved. I suppose you should do stuff.");
		#visit_url("storage.php?action=pullall&pwd&");
		visit_url("storage.php?action=takemeat&pwd&amt=" + my_storage_meat());
		visit_url("storage.php?pwd&");
		put_display(item_amount($item[thwaitgold scarab beetle statuette]), $item[thwaitgold scarab beetle statuette]);

		print("Banishers: ", "green");
		print(get_property("ed_banishes_day1"), "blue");
		print(get_property("ed_banishes_day2"), "blue");
		print(get_property("ed_banishes_day3"), "blue");
		print("Yellow Rays: ", "green");
		print(get_property("ed_yellowRay_day1"), "blue");
		print(get_property("ed_yellowRay_day2"), "blue");
		print(get_property("ed_yellowRay_day3"), "blue");
	}

void main(){
	handleKingLiberation();
}
