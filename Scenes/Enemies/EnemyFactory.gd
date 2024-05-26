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

func _createMook(position: Vector2):
	var newMook = mookLoader.instantiate() if cachedMooks.is_empty() else cachedMooks.pop_back();
	newMook.visible = true;
	newMook._initialize();
	newMook.position = position
	return newMook;

func _createEyeball(position: Vector2):
	var newEyeball;
	if (cachedEyeballs.is_empty()):
		newEyeball = eyeballLoader.instantiate()
		newEyeball.fire_bullet.connect(_createBadBullet)
	else:
		newEyeball = cachedEyeballs.pop_back();
		
	newEyeball._initialize();
	newEyeball.position = position
	return newEyeball;

func _createBadBullet(position: Vector2):
	var newBadBullet = bulletLoader.instantiate() if cachedBadBullets.is_empty() else cachedBadBullets.pop_back();
	newBadBullet._initialize();
	newBadBullet.position = position
	newBadBullet.velocityUnitVector = (Player.position - position).normalized();
	newBadBullet.kill_bullet.connect(_killBullet);
	add_child(newBadBullet)
	
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
