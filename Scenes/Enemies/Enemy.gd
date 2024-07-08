extends CharacterBody2D


var health;
var EnemyFactory;
var Player;
var enemy_type;

#emitted on death
signal stop_animations

func _ready():
	EnemyFactory = get_parent().get_node("EnemyFactory")
	Player = get_parent().get_node("Player");
	
func _get_unit_vector_toward_player():
	return (Player.position - position).normalized()
	
func _damage_taken(damage_amount):
	health -= damage_amount

	if (health <= 0):
		get_parent().remove_child(self)
		EnemyFactory._killEnemy(self);
	else:
		EnemyFactory._create_damage_number(self, damage_amount)
