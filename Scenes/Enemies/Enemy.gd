extends CharacterBody2D
var damageLoader = ResourceLoader.load("res://Scenes/Damage Number/Damage Number.tscn")

var health;
var EnemyFactory;
var Player;
var enemy_type;

func _ready():
	EnemyFactory = get_parent().get_node("EnemyFactory")
	Player = get_parent().get_node("Player");
	
func _get_unit_vector_toward_player():
	return (Player.position - position).normalized()
	
func _damage_taken(damage_amount):
	health -= damage_amount
	var damageInstance = damageLoader.instantiate();
	damageInstance.position.y -= 25
	damageInstance.get_node("Label_Container").get_node("Label").text = str(damage_amount)
	add_child(damageInstance)
	damageInstance.get_node("AnimationPlayer").play("Damage Vanish");
			
	if (health <= 0):
		get_parent().remove_child(self)
		EnemyFactory._killEnemy(self);
