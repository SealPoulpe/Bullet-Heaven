extends Area2D
const Player = preload("res://Scenes/Player/Player.gd")

var velocityUnitVector : Vector2
var BULLETSPEED = 300;
var player;
var attack_type = "badbullet";

signal kill_bullet(node: Node2D);
	
func _initialize():
	visible = true;

func _physics_process(delta):
	position.x += (velocityUnitVector.x * BULLETSPEED) * delta;
	position.y += (velocityUnitVector.y * BULLETSPEED) * delta; 

func _on_body_entered(body):
	var player = body as Player
	if not player:
		return;
		
	player._got_hit();
	kill_bullet.emit(self)
