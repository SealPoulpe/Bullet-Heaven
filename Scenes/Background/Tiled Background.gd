extends Node2D

var TILESIZE : int = 450;

var DESTRUCTION_RADIUS : int;
var GRID_WIDTH : int;
var GRID_HEIGHT : int;

var tiles = []

func _ready():
	DESTRUCTION_RADIUS = TILESIZE * 4;
	GRID_WIDTH = (floor(DESTRUCTION_RADIUS * 2 / float(TILESIZE)))
	GRID_HEIGHT = (floor(DESTRUCTION_RADIUS * 2 / float(TILESIZE)))
	
	_initialize_background()

func _create_tile(grid_x : int, grid_y : int):
	var tile_instance = ResourceLoader.load("res://Scenes/Background/Single Tiles/Debug Tile Pink.tscn").instantiate()
			
	# tell the tile where it lives for dynamic generation later
	tile_instance.grid_x = grid_x;
	tile_instance.grid_y = grid_y;
	tile_instance.tile_entered.connect(_update_tiles)
	
	tile_instance.position.x = TILESIZE * grid_x;
	tile_instance.position.y = TILESIZE * grid_y;
	
	return tile_instance;


func _delete_tile(tile):
	tile.queue_free();
	tiles.erase(tile);
		
func _update_tiles(player):
	var leftmost_x = 0
	var tiles_to_save = []
	var tiles_to_add = []
	
	for tile in tiles:
		if abs(player.position.x - tile.position.x) > DESTRUCTION_RADIUS:
			var direction_multiplier = 1.0 if (player.position.x - tile.position.x) > 0 else -1.0;
			tiles_to_add.push_back(_create_tile(tile.grid_x + (direction_multiplier * GRID_WIDTH), tile.grid_y))
			tile.queue_free()
		elif abs(player.position.y - tile.position.y) > DESTRUCTION_RADIUS:
			var direction_multiplier = 1.0 if (player.position.y - tile.position.y) > 0 else -1.0;
			tiles_to_add.push_back(_create_tile(tile.grid_x, tile.grid_y + (direction_multiplier * GRID_HEIGHT)))
			tile.queue_free()
		else:
			tiles_to_save.push_back(tile);
			
	for new_tile in tiles_to_add:
		tiles_to_save.push_back(new_tile)
		call_deferred("add_child", new_tile);
	
	tiles = tiles_to_save
	return

func _initialize_background():
	var width = int(ceil(GRID_WIDTH/2.0));
	
	var height = int(ceil(GRID_HEIGHT/2.0));
	
	for x in range(-1 * width, width):
		for y in range (-1 * height, height):
			var tile = _create_tile(x, y);
			tiles.push_back(tile);
			call_deferred("add_child", tile);
	return
