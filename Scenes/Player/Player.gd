extends CharacterBody2D

var MOVESPEED = 500;

var health;

signal got_hit(newHealthValue)

func _got_hit():
	health -= 5;
	print("ouch! Health: " + str(health))
	got_hit.emit(health)

func _ready():
	health = 100;
	
func _physics_process(delta):
	
	velocity.x = 0
	velocity.y = 0
	
	if Input.is_key_pressed(KEY_W):
		velocity.y = -1 * MOVESPEED;
	
	if Input.is_key_pressed(KEY_A):
		velocity.x = -1 * MOVESPEED;
	
	if Input.is_key_pressed(KEY_S):
		velocity.y = MOVESPEED;

	if Input.is_key_pressed(KEY_D):
		velocity.x = MOVESPEED;

	move_and_slide()
