extends Area2D

var velocityUnitVector : Vector2
var BULLETSPEED = 5;
var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player");
	velocityUnitVector = (player.position - position).normalized();

func _physics_process(delta):
	position.x += (velocityUnitVector.x * BULLETSPEED);
	position.y += (velocityUnitVector.y * BULLETSPEED);
	

func _on_body_entered(body):
	player._got_hit();
	queue_free()
