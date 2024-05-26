extends Control

func _ready():
	var player = get_parent().get_parent().get_node("Player");
	player.got_experience.connect(_on_experience_update);
	get_node("Experience Bar").size.x = 0;
	
func _on_experience_update(new_experience_percentage):
	get_node("Experience Bar").size.x = 450 * (new_experience_percentage);
