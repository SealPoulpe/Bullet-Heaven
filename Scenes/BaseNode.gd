extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_manager = ResourceLoader.load("res://Scenes/GameManager.tscn").instantiate();
	add_child(game_manager)
	
	var hub_world = ResourceLoader.load("res://Scenes/Stages/Hub World/Hub World.tscn").instantiate();
	hub_world.change_levels.connect(_switch_level)
	add_child(hub_world)

func _switch_level(_old_level_name, new_level_name: String):
	get_node("HubWorld").queue_free()
	
	match new_level_name:
		"Hub World":
			add_child(ResourceLoader.load("res://Scenes/Stages/Hub World/Hub World.tscn").instantiate())
		"Debug Level":
			var debug_level = ResourceLoader.load("res://Scenes/Stages/Debug Level.tscn").instantiate()
			add_child(debug_level)
			get_node("GameManager").stage_active = true
			get_node("GameManager").get_node("Player")._enable_attacks(true)
		_:
			assert(false, "level name missing")	
		
