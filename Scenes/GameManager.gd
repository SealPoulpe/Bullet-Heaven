extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var bgSceneInstance = ResourceLoader.load("res://Scenes/Background/Tiled Background.tscn").instantiate()
	add_child(bgSceneInstance)
	return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rng.randi_range(0, 255) > 200):
		var bgSceneInstance = ResourceLoader.load("res://Scenes/Enemy Attacks/Bad Bullet.tscn").instantiate()
		bgSceneInstance.position.x = rng.randi_range(0,100) * 50
		bgSceneInstance.position.y = rng.randi_range(0,100) * 50
		add_child(bgSceneInstance)
	return
