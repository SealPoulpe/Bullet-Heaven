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
		if(randi_range(0, 1000) > 950) && !get_node("AnimationPlayer").is_playing():	#TODO: More intelligent firing mechanics
			get_node("AnimationPlayer").play("Go Red")
	else:
		velocityUnitVector = _get_unit_vector_toward_player();
		
	get_node("Eyeball").flip_h = Player.position.x - position.x < 0
		
	velocity.x = (velocityUnitVector.x * ENEMYSPEED) * delta;
	velocity.y = (velocityUnitVector.y * ENEMYSPEED) * delta;

	move_and_slide()

func _fire_bullet():
	fire_bullet.emit(Vector2(position.x, position.y))
