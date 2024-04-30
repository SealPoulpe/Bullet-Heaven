extends CharacterBody2D

var MOVESPEED = 250;

var health = 100;

signal got_hit(newHealthValue)
signal do_stomp

func _ready():
	get_node("Timer").timeout.connect(_do_stomp);

func _got_hit():
	health -= 5;
	print("ouch! Health: " + str(health))
	got_hit.emit(health)
	
func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		position.y -= MOVESPEED * delta;
	
	if Input.is_key_pressed(KEY_A):
		position.x -= MOVESPEED * delta;
	
	if Input.is_key_pressed(KEY_S):
		position.y += MOVESPEED * delta;

	if Input.is_key_pressed(KEY_D):
		position.x += MOVESPEED * delta;
	
func _do_stomp():
	do_stomp.emit();
