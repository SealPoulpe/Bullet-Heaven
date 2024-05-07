extends Node2D

const Enemy = preload("res://Scenes/Enemies/Enemy.gd")
var mookLoader = ResourceLoader.load("res://Scenes/Enemies/Mook.tscn")
var eyeballLoader = ResourceLoader.load("res://Scenes/Enemies/Eyeball.tscn")

var cachedMooks = [];
var cachedEyeballs = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _createMook(position: Vector2):
	var newMook = mookLoader.instantiate() if cachedMooks.is_empty() else cachedMooks.pop_back();
	newMook._initialize();
	newMook.position = position
	return newMook;

func _createEyeball(position: Vector2):
	var newEyeball = eyeballLoader.instantiate() if cachedEyeballs.is_empty() else cachedEyeballs.pop_back();
	newEyeball._initialize();
	newEyeball.position = position
	return newEyeball;

func _killEnemy(node: Enemy):
	node.visible = false;
	
	match node.enemy_type:
		"eyeball":
			cachedEyeballs.append(node);
		"mook":
			cachedMooks.append(node);
		_:
			assert(false, "unregistered enemy type")
	pass;
