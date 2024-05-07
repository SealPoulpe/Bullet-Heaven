extends "res://Scenes/Enemies/Enemy.gd"

var ENEMYSPEED = 10000;

var velocityUnitVector;

func _initialize():
	health = 2;
	enemy_type = "mook"

func _physics_process(delta):
	velocityUnitVector = _get_unit_vector_toward_player();
	
	velocity.x = (velocityUnitVector.x * ENEMYSPEED) * delta;
	velocity.y = (velocityUnitVector.y * ENEMYSPEED) * delta;
	
	move_and_slide()

func _on_body_entered(body):
	return
