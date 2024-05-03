extends "res://Scenes/Enemies/Enemy.gd"


var ENEMYSPEED = 10000;

var player;
var velocityUnitVector;

func _get_unit_vector_toward_player():
	return (player.position - position).normalized()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player");
	velocityUnitVector = _get_unit_vector_toward_player();
	health = 5;

func _physics_process(delta):
	velocityUnitVector = _get_unit_vector_toward_player();
	
	velocity.x = (velocityUnitVector.x * ENEMYSPEED) * delta;
	velocity.y = (velocityUnitVector.y * ENEMYSPEED) * delta;
	
	move_and_slide()
	

	

func _on_body_entered(body):
	return
