extends CharacterBody2D
const Direction = preload("res://Library/Enums.gd").Direction

var MOVESPEED = 250;
var health = 100;
var experience = 0;
var next_level_experience_threshold = 200;
var last_direction_faced
var player_level;
var skill_shot_level;
var skill_stomp_level;

var level_up_overlay;

signal got_hit(newHealthValue)
signal got_experience(new_exp_percentage)
signal do_stomp(level, direction)
signal do_shot(level)

func _ready():
	get_node("StompTimer").timeout.connect(_do_stomp);
	get_node("ShotTimer").timeout.connect(_do_shot);
	level_up_overlay = get_node("LevelUpOverlay")
	level_up_overlay.level_up_skill_selected.connect(_level_up);
	_initialize();

func _initialize():
	player_level = 1;
	skill_shot_level = 1;
	skill_stomp_level = 2;
	experience = 0;
	
func _got_hit():
	health -= 5;
	got_hit.emit(health)
	
func _enable_attacks(is_enabled : bool):
	if is_enabled:
		get_node("StompTimer").start()
		get_node("ShotTimer").start()
	else:
		get_node("StompTimer").stop()
		get_node("ShotTimer").stop()
	
func _level_up(skill_name):
	match skill_name:
		"shot":
			skill_shot_level += 1;
		"stomp":
			skill_stomp_level += 1;
		_:
			assert(false, "unregistered player skill type")
	
func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		position.y -= MOVESPEED * delta;
		last_direction_faced = Direction.UP
	
	if Input.is_key_pressed(KEY_A):
		position.x -= MOVESPEED * delta;
		last_direction_faced = Direction.LEFT
	
	if Input.is_key_pressed(KEY_S):
		position.y += MOVESPEED * delta;
		last_direction_faced = Direction.DOWN

	if Input.is_key_pressed(KEY_D):
		position.x += MOVESPEED * delta;
		last_direction_faced = Direction.RIGHT
	
func _do_stomp():
	do_stomp.emit(skill_stomp_level, last_direction_faced);
	
func _do_shot():
	do_shot.emit(skill_shot_level);
	
func _get_experience():
	experience += 10;
	if (experience >= next_level_experience_threshold):
		experience = experience % int(next_level_experience_threshold);
		next_level_experience_threshold += 50
		get_tree().paused = true;
		level_up_overlay.show();
	
	got_experience.emit(float(experience) / float(next_level_experience_threshold));
	
