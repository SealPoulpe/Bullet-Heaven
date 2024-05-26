extends Area2D
const Player = preload("res://Scenes/Player/Player.gd")

signal exp_collected(node : Node2D);

func _on_body_entered(body):
	var player = body as Player
	if not player:
		return;
		
	player._get_experience();
	exp_collected.emit(self)
