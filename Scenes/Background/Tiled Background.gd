extends Node2D

var TILESIZE : int = 450;

func _tile_background():
	for x in range(-20,20):
		for y in range (-20,20):
			var bgSceneInstance = ResourceLoader.load("res://Scenes/Background/Background Block.tscn").instantiate()
			bgSceneInstance.position.x = TILESIZE * x;
			bgSceneInstance.position.y = TILESIZE * y;
			add_child(bgSceneInstance)
	return


# Called when the node enters the scene tree for the first time.
func _ready():
	_tile_background()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
