extends Node

const Enemy = preload("res://Scenes/Enemies/Enemy.gd")
var Player;
var Animation_Player;

var mookLoader = ResourceLoader.load("res://Scenes/Enemies/Mook.tscn")
var cachedMooks = [];

var eyeballLoader = ResourceLoader.load("res://Scenes/Enemies/Eyeball.tscn")
var cachedEyeballs = [];

var bulletLoader = ResourceLoader.load("res://Scenes/Enemy Attacks/Bad Bullet.tscn")
var cachedBadBullets = [];

var line_attack_loader = ResourceLoader.load("res://Scenes/Enemy Attacks/Line Attack.tscn")
var damage_number_loader = ResourceLoader.load("res://Scenes/Damage Number/Damage Number.tscn")

signal create_experience_crystal(position)

func _ready():
	Player = get_parent().get_node("Player")
	Animation_Player = get_node("AnimationPlayer")

func _createMook(spawn_position: Vector2):
	var newMook
	if(cachedMooks.is_empty()):
		newMook = mookLoader.instantiate()
		newMook.do_attack.connect(_create_line_attack)
	else:
		newMook = cachedMooks.pop_back()
	
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
	
func _create_line_attack(enemy: CharacterBody2D):
	var spawn_position = Vector2(enemy.position.x, enemy.position.y)
	var new_line_attack = line_attack_loader.instantiate();
	new_line_attack.get_node("Line2D").add_point(Vector2(0,0))
	
	var new_x = (Player.position.x - spawn_position.x) * 1.2
	var new_y = (Player.position.y - spawn_position.y) * 1.2
	
	new_line_attack.get_node("Line2D").add_point(Vector2(new_x, new_y))
	
	enemy.stop_animations.connect(new_line_attack._animation_stopped)
	
	enemy.add_child(new_line_attack)
	pass
	
func _create_damage_number(enemy: CharacterBody2D, damage_amount: int):
	var new_damage_number = damage_number_loader.instantiate();
	
	new_damage_number.get_node("Label_Container").get_node("Label").text = str(damage_amount)
	new_damage_number.get_node("AnimationPlayer").play("Damage Vanish");
	new_damage_number.position.y = -25
	
	enemy.stop_animations.connect(new_damage_number._animation_stopped)
	
	enemy.add_child(new_damage_number)
	pass
	
func _killEnemy(node: Enemy):
	node.visible = false;
	
	match node.enemy_type:
		"eyeball":
			cachedEyeballs.append(node);
		"mook":
			node.stop_animations.emit()
			cachedMooks.append(node);
		_:
			assert(false, "unregistered enemy type")
			
	#create_experience_crystal.emit(node.position)
	pass;

func _killBullet(node): # TODO: Enemy Attacks need a generic type
	node.visible = false;
	
	match node.attack_type:
		"badbullet":
			cachedBadBullets.append(node);
		_:
			assert(false, "unregistered enemy attack type")
	pass;
