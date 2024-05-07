extends Node

var rng = RandomNumberGenerator.new()
var player
var bgLoader = ResourceLoader.load("res://Scenes/Background/Tiled Background.tscn")
var bulletLoader = ResourceLoader.load("res://Scenes/Enemy Attacks/Bad Bullet.tscn")
var stompLoader = ResourceLoader.load("res://Scenes/Player Attacks/Circle Stomp.tscn")
var shotLoader = ResourceLoader.load("res://Scenes/Player Attacks/Simple Shot.tscn")
var mookLoader = ResourceLoader.load("res://Scenes/Enemies/Mook.tscn")
var eyeballLoader = ResourceLoader.load("res://Scenes/Enemies/Eyeball.tscn")
var Direction = preload("res://Library/Enums.gd").Direction

var EnemyFactory;


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player");
	EnemyFactory = get_node("EnemyFactory")
	
	var bgSceneInstance = bgLoader.instantiate()
	add_child(bgSceneInstance)
	
	player.do_stomp.connect(_do_stomp);
	player.do_shot.connect(_do_shot);
	return
	

func _pick_spawn_point_relative_to_player():
	var xLowerRange = rng.randi_range(0,1) * 500;
	var yLowerRange = 500 if (xLowerRange == 0) else 0;
	
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
		
	if (rng.randi_range(0, 255) > 225):
		add_child(EnemyFactory._createMook(_pick_spawn_point_relative_to_player()))
		
	if (rng.randi_range(0, 255) > 225):
		add_child(EnemyFactory._createEyeball(_pick_spawn_point_relative_to_player()))
	return

func _do_stomp(direction):
	var stompInstance = stompLoader.instantiate()
	
	var STOMP_DISTANCE = 100
	var xModifier = -STOMP_DISTANCE if (direction == Direction.LEFT) else STOMP_DISTANCE if (direction == Direction.RIGHT) else 0;
	var yModifier = -STOMP_DISTANCE if (direction == Direction.UP) else STOMP_DISTANCE if (direction == Direction.DOWN) else 0;
	
	# stomp distance is RELATIVE DISTANCE FROM CHARACTER
	# since character is producing it
	stompInstance.position.x = player.position.x + xModifier
	stompInstance.position.y = player.position.y + yModifier
	stompInstance.scale.x = 4;
	stompInstance.scale.y = 4;
	add_child(stompInstance)

func _make_shot(unitVector):
	var shot = shotLoader.instantiate()
	shot._initialize(unitVector)
	return shot

func _do_shot():
	#var velocityUnitVector =  (player.position - position).normalized();

	add_child(_make_shot(Vector2(0,1)));
	add_child(_make_shot(Vector2(0,-1)));
	add_child(_make_shot(Vector2(1,0)));
	add_child(_make_shot(Vector2(-1,0)));
	add_child(_make_shot(Vector2(1/pow(2,0.5), 1/pow(2,0.5))));
	add_child(_make_shot(Vector2(-1/pow(2,0.5), 1/pow(2,0.5))));
	add_child(_make_shot(Vector2(1/pow(2,0.5), -1/pow(2,0.5))));
	add_child(_make_shot(Vector2(-1/pow(2,0.5), -1/pow(2,0.5))));
	
