extends Node2D


func _disable_timer(game_manager: Node):
	game_manager.get_node("Camera2D").get_node("Timer")._stop();
	game_manager.get_node("Camera2D").get_node("Timer").visible = false;
	
func _enable_timer(game_manager: Node):
	get_node("GameManager").get_node("Camera2D").get_node("Timer").visible = true;
	get_node("GameManager").get_node("Camera2D").get_node("Timer")._start(120);
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_manager = ResourceLoader.load("res://Scenes/GameManager.tscn").instantiate();
	add_child(game_manager)
	_disable_timer(game_manager)
	
	var hub_world = ResourceLoader.load("res://Scenes/Stages/Hub World/Hub World.tscn").instantiate();
	hub_world.change_levels.connect(_switch_level)
	add_child(hub_world)

func _switch_level(_old_level_name, new_level_name: String):
	get_node("HubWorld").queue_free()
	var game_manager = get_node("GameManager");
	
	match new_level_name:
		"Hub World":
			add_child(ResourceLoader.load("res://Scenes/Stages/Hub World/Hub World.tscn").instantiate())
			_disable_timer(game_manager)
		"Debug Level":
			var debug_level = ResourceLoader.load("res://Scenes/Stages/Debug Level.tscn").instantiate()
			add_child(debug_level)
			game_manager.stage_active = true
			game_manager.get_node("Player")._enable_attacks(true)
			_enable_timer(game_manager)
		_:
			assert(false, "level name missing")	
		
