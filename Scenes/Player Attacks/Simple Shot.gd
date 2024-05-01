extends Area2D
const Enemy = preload("res://Scenes/Enemies/Enemy.gd")

var velocityUnitVector : Vector2
var BULLETSPEED = 300;
var player;

func _initialize(unit_vector):
	velocityUnitVector = unit_vector
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player");
	position.x = player.position.x
	position.y = player.position.y

func _physics_process(delta):
	position.x += (velocityUnitVector.x * BULLETSPEED) * delta;
	position.y += (velocityUnitVector.y * BULLETSPEED) * delta;
	
	#If player is very far away (ie bullet offscreen) delete bullet
	if abs(position.x - player.position.x) > 2000 or abs(position.y - player.position.y) > 2000:
		queue_free();
	
func _on_body_entered(body):
	var enemy = body as Enemy
	if not enemy:
		return;
	enemy.queue_free();
	queue_free()
