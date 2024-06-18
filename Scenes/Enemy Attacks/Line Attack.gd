extends Area2D
const Player = preload("res://Scenes/Player/Player.gd")

var collision_shape;

func _ready():
	collision_shape = get_node("CollisionShape2D")
	get_node("AnimationPlayer").play("Line Attack")

#to be called at the beginning of the animation to make the collision shape match the visual line
func _match_collision_shape():
	collision_shape.shape.a = get_node("Line2D").points[0];
	collision_shape.shape.b = get_node("Line2D").points[1];
	
#called by animation
func _execute_attack():
	collision_shape.disabled = false;
	pass
	
#called by animation
func _disable_attack():
	collision_shape.disabled = true;
	pass
	
func _on_body_entered(body):
	var player_instance = body as Player
	if not player_instance:
		return;
		
	player_instance._got_hit();
	
func _destroy_self():
	self.queue_free();
