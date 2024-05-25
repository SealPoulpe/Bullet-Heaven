extends "res://Scenes/Enemies/Enemy.gd"

var ENEMYSPEED = 10000;

var velocityUnitVector;
var safeDistance;

signal fire_bullet(position : Vector2)

func _initialize():
	health = 10;
	enemy_type = "eyeball"
	visible = true;
	safeDistance = randi_range(400, 500)

func _physics_process(delta):
	if position.distance_to(Player.position) < safeDistance:
		velocityUnitVector = Vector2(0,0)
	else:
		velocityUnitVector = _get_unit_vector_toward_player();
		
	velocity.x = (velocityUnitVector.x * ENEMYSPEED) * delta;
	velocity.y = (velocityUnitVector.y * ENEMYSPEED) * delta;

	move_and_slide()
	
	if(randi_range(0, 2000) > 1998):	#TODO: More intelligent firing mechanics
		fire_bullet.emit(Vector2(position.x, position.y))

func _on_body_entered(body):
	return
