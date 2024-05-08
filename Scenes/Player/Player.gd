extends CharacterBody2D
const Direction = preload("res://Library/Enums.gd").Direction

var MOVESPEED = 250;
var health = 100;
var last_direction_faced

signal got_hit(newHealthValue)
signal do_stomp(direction)
signal do_shot

func _ready():
	get_node("StompTimer").timeout.connect(_do_stomp);
	get_node("ShotTimer").timeout.connect(_do_shot);

func _got_hit():
	health -= 5;
	got_hit.emit(health)
	
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
	do_stomp.emit(last_direction_faced);
	
func _do_shot():
	do_shot.emit();
	
