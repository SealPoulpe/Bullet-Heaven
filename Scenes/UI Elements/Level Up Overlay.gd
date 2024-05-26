extends Window

signal level_up_skill_selected(skill : String)

func _ready():
	self.hide();

func _on_level_shot_pressed():
	level_up_skill_selected.emit("shot")
	_resume()

func _on_level_stomp_pressed():
	level_up_skill_selected.emit("stomp")
	_resume()

func _on_level_nothing_pressed():
	_resume()
	
func _resume():
	get_tree().paused = false;
	self.hide();
