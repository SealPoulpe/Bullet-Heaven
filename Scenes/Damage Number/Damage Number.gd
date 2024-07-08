extends Node2D


func _animation_stopped():
	get_node("AnimationPlayer").stop();
	queue_free();
