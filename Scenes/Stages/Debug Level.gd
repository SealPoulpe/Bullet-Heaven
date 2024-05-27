extends Node2D

var bgLoader = ResourceLoader.load("res://Scenes/Background/Tiled Background.tscn")
var game_manager;	#game manager passed in from parent

func _ready():
	var bgSceneInstance = bgLoader.instantiate()
	add_child(bgSceneInstance)
	game_manager = get_parent().get_node("GameManager")
