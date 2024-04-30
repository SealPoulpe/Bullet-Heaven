extends Node

var rng = RandomNumberGenerator.new()
var player
var bgLoader = ResourceLoader.load("res://Scenes/Background/Tiled Background.tscn")
var bulletLoader = ResourceLoader.load("res://Scenes/Enemy Attacks/Bad Bullet.tscn")
var stompLoader = ResourceLoader.load("res://Scenes/Player Attacks/Circle Stomp.tscn")
var mookLoader = ResourceLoader.load("res://Scenes/Enemies/Mook.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player");
	
	var bgSceneInstance = bgLoader.instantiate()
	add_child(bgSceneInstance)
	
	player.do_stomp.connect(_do_stomp);
	return
	

func _pick_spawn_point_relative_to_player():
	var xLowerRange = rng.randi_range(0,1) * 500;
	var yLowerRange = 500 if (xLowerRange == 0) else 0;
	
	print("x: " + str(xLowerRange) + " y: " + str(yLowerRange));
	
	var x = player.position.x + rng.randi_range(xLowerRange,1000) * pow(-1, rng.randi_range(1,2))
	var y = player.position.y + rng.randi_range(yLowerRange,1000) * pow(-1, rng.randi_range(1,2))
		
	return Vector2(x,y);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rng.randi_range(0, 255) > 200):
		var bulletInstance = bulletLoader.instantiate()
		bulletInstance.position.x = rng.randi_range(0,100) * 50
		bulletInstance.position.y = rng.randi_range(0,100) * 50
		add_child(bulletInstance)
		
	if (rng.randi_range(0, 255) > 200):
		var mookInstance = mookLoader.instantiate();
		mookInstance.position = _pick_spawn_point_relative_to_player();
		add_child(mookInstance)
	return

func _do_stomp():
	var stompInstance = stompLoader.instantiate()
	
	# stomp distance is RELATIVE DISTANCE FROM CHARACTER
	# since character is producing it
	stompInstance.position.x = player.position.x - 50
	stompInstance.position.y = player.position.y
	stompInstance.scale.x = 4;
	stompInstance.scale.y = 4;
	add_child(stompInstance)
