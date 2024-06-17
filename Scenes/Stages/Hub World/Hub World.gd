extends Node2D
const Player = preload("res://Scenes/Player/Player.gd")

#game manager passed in from parent
var game_manager;
signal change_levels(old_level_name: String, new_level_name: String)

func _ready():
	game_manager = get_parent().get_node("GameManager");


func _on_start_level_element_2_body_entered(body):
	var player = body as Player
	if(not player):
		return
		
	change_levels.emit("Hub World", "Debug Level")
	
