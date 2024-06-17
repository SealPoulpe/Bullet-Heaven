extends Node2D

const Enemy = preload("res://Scenes/Enemies/Enemy.gd")
var Player;

var mookLoader = ResourceLoader.load("res://Scenes/Enemies/Mook.tscn")
var cachedMooks = [];

var eyeballLoader = ResourceLoader.load("res://Scenes/Enemies/Eyeball.tscn")
var cachedEyeballs = [];

var bulletLoader = ResourceLoader.load("res://Scenes/Enemy Attacks/Bad Bullet.tscn")
var cachedBadBullets = [];

signal create_experience_crystal(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_parent().get_node("Player")
	pass # Replace with function body.

func _createMook(spawn_position: Vector2):
	var newMook = mookLoader.instantiate() if cachedMooks.is_empty() else cachedMooks.pop_back();
	newMook.visible = true;
	newMook._initialize();
	newMook.position = spawn_position
	return newMook;

func _createEyeball(spawn_position: Vector2):
	var newEyeball;
	if (cachedEyeballs.is_empty()):
		newEyeball = eyeballLoader.instantiate()
		newEyeball.fire_bullet.connect(_createBadBullet)
	else:
		newEyeball = cachedEyeballs.pop_back();
		
	newEyeball._initialize();
	newEyeball.position = spawn_position
	return newEyeball;

func _createBadBullet(spawn_position: Vector2):
	var new_bad_bullet;
	if(cachedBadBullets.is_empty()):
		new_bad_bullet = bulletLoader.instantiate()
		new_bad_bullet.kill_bullet.connect(_killBullet);
		add_child(new_bad_bullet)
	else:
		new_bad_bullet = cachedBadBullets.pop_back()
		new_bad_bullet.visible = true
		
	new_bad_bullet._initialize();
	new_bad_bullet.velocityUnitVector = (Player.position - spawn_position).normalized();
	new_bad_bullet.position = spawn_position
	
func _killEnemy(node: Enemy):
	node.visible = false;
	
	match node.enemy_type:
		"eyeball":
			cachedEyeballs.append(node);
		"mook":
			cachedMooks.append(node);
		_:
			assert(false, "unregistered enemy type")
			
	create_experience_crystal.emit(node.position)
	pass;

func _killBullet(node): # TODO: Enemy Attacks need a generic type
	node.visible = false;
	
	match node.attack_type:
		"badbullet":
			cachedBadBullets.append(node);
		_:
			assert(false, "unregistered enemy attack type")
	pass;
