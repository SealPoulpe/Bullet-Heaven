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
const Enemy = preload("res://Scenes/Enemies/Enemy.gd")

var expSmallLoader = ResourceLoader.load("res://Scenes/Experience/Experience_Small.tscn")
var cachedExperienceSmall = [];

var EnemyFactory;


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player");
	EnemyFactory = get_node("EnemyFactory")
	
	EnemyFactory.create_experience_crystal.connect(_create_experience_crystal)
	
	var bgSceneInstance = bgLoader.instantiate()
	add_child(bgSceneInstance)
	
	player.do_stomp.connect(_do_stomp);
	player.do_shot.connect(_do_shot);
	return

func _get_closest_enemy_to_player():
	player = get_node("Player")
	var children = get_children();
	
	var shortest_distance = null;
	var closest_enemy = null;
	
	for child in children:
		var enemy = child as Enemy
		if not enemy:
			continue;
		
		var distance = (Vector2(enemy.position.x, enemy.position.y) - Vector2(player.position.x, player.position.y)).length();
		if (shortest_distance == null || distance < shortest_distance):
			shortest_distance = distance;
			closest_enemy = child;
			
	return closest_enemy;

func _pick_spawn_point_relative_to_player():
	var xLowerRange = rng.randi_range(0,1) * 500;
	var yLowerRange = 500 if (xLowerRange == 0) else 0;
	
	var x = player.position.x + rng.randi_range(xLowerRange,1000) * pow(-1, rng.randi_range(1,2))
	var y = player.position.y + rng.randi_range(yLowerRange,1000) * pow(-1, rng.randi_range(1,2))
		
	return Vector2(x,y);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (rng.randi_range(0, 255) > 225):
		add_child(EnemyFactory._createMook(_pick_spawn_point_relative_to_player()))
		
	if (rng.randi_range(0, 255) > 225):
		add_child(EnemyFactory._createEyeball(_pick_spawn_point_relative_to_player()))
	return
	
func _do_stomp(level, direction):
	var stompInstance = stompLoader.instantiate()
	stompInstance.stomp_damage = level * 2;
	
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

func _do_shot(level):
	#var velocityUnitVector =  (player.position - position).normalized();
	var closest_enemy = _get_closest_enemy_to_player();
	if(closest_enemy == null):
		return
	
	var direction_to_closest_enemy = Vector2(closest_enemy.position.x, closest_enemy.position.y) - Vector2(player.position.x, player.position.y);
	direction_to_closest_enemy /= direction_to_closest_enemy.length();

	add_child(_make_shot(direction_to_closest_enemy));
	
	if(level >= 2):
		var radians_of_shot = atan2(direction_to_closest_enemy.y, direction_to_closest_enemy.x);
		for i in range(1, level):
			add_child(_make_shot(Vector2(cos(radians_of_shot + i*15*PI/180), sin(radians_of_shot + i*15*PI/180))))
			add_child(_make_shot(Vector2(cos(radians_of_shot - i*15*PI/180), sin(radians_of_shot - i*15*PI/180))))
	
func _create_experience_crystal(position):
	var new_small_exp_crystal = expSmallLoader.instantiate();
	new_small_exp_crystal.position = position;
	new_small_exp_crystal.exp_collected.connect(_kill_experience)
	add_child(new_small_exp_crystal);
	pass
	
func _kill_experience(experience_node : Node2D):
	experience_node.queue_free();
	pass
