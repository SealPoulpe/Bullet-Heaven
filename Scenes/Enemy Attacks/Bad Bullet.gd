extends Area2D
const Player = preload("res://Scenes/Player/Player.gd")

var velocityUnitVector : Vector2
var BULLETSPEED = 300;
var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player");
	velocityUnitVector = (player.position - position).normalized();

func _physics_process(delta):
	position.x += (velocityUnitVector.x * BULLETSPEED) * delta;
	position.y += (velocityUnitVector.y * BULLETSPEED) * delta;
	

func _on_body_entered(body):
	var player = body as Player
	if not player:
		return;
	player._got_hit();
	queue_free()
