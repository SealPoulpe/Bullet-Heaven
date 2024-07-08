extends "res://Scenes/Enemies/Enemy.gd"

var ENEMYSPEED = 10000;

var velocityUnitVector;
var attack_animation_player;

signal do_attack(enemy : CharacterBody2D)

func _initialize():
	health = 2;
	enemy_type = "mook"
	visible = true;
	attack_animation_player = get_node("AnimationPlayer")
	if (!is_connected('stop_animations', _stop_animation)):
		stop_animations.connect(_stop_animation)
	

func _physics_process(delta):
	if !attack_animation_player.is_playing():
		velocityUnitVector = _get_unit_vector_toward_player();
		
		if position.distance_to(Player.position) < 150 && randf() > 0.95:
			attack_animation_player.play("Mook Attack");
	else:
		velocityUnitVector = Vector2(0,0)
		
	velocity.x = (velocityUnitVector.x * ENEMYSPEED) * delta;
	velocity.y = (velocityUnitVector.y * ENEMYSPEED) * delta;
		
	move_and_slide()

func _stop_animation():
	attack_animation_player.stop();
	
func _do_attack():
	do_attack.emit(self)
