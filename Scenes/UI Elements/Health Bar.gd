extends Control

func _ready():
	var plyr = get_parent().get_parent().get_node("Player");
	plyr.got_hit.connect(onhealthupdate);

func onhealthupdate(newHealthValue):
	get_node("Health Bar").size.x = 450 * (newHealthValue / 100.0);
