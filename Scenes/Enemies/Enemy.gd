extends CharacterBody2D
var damageLoader = ResourceLoader.load("res://Scenes/Damage Number/Damage Number.tscn")

var health;

func _damage_taken(damage_amount):
	health -= damage_amount
	var damageInstance = damageLoader.instantiate();
	damageInstance.position.y -= 25
	damageInstance.get_node("Label_Container").get_node("Label").text = str(damage_amount)
	add_child(damageInstance)
	damageInstance.get_node("AnimationPlayer").play("Damage Vanish");
			
	if (health <= 0):
		queue_free()

func _ready():
	pass
