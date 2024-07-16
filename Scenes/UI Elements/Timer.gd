extends Node2D

var timer;
var label;

func _ready():
	timer = get_node("Timer")
	label = get_node("Label")

func _convert_to_pretty_time_string(seconds : float):
	var secs = int(seconds) % 60
	var mins = int(seconds / 60.0)
	return str(mins) + ":" + str(secs)

func _process(_delta):
	var seconds_left = get_node("Timer").time_left
	get_node("Label").text = _convert_to_pretty_time_string(seconds_left);
	pass

func _stop():
	get_node("Timer").stop();
	
func _start(time: int):
	get_node("Timer").start(time);
