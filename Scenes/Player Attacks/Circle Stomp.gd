extends Area2D
const Mook = preload("res://Scenes/Enemies/Mook.gd")
const Enemy = preload("res://Scenes/Enemies/Enemy.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Timer").timeout.connect(_end_stomp)


func _end_stomp():
	queue_free();

func _on_body_entered(body):
	var enemy = body as Enemy
	if not enemy:
		return;
	enemy._damage_taken(5);
