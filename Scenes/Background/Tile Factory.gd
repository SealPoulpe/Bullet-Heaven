extends Node2D

var debug_tile_loader;
# Called when the node enters the scene tree for the first time.
func _ready():
	debug_tile_loader = ResourceLoader.load("res://Scenes/Background/Debug Tile.tscn").instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.a
func _process(delta):
	pass
