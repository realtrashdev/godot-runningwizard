extends Node
class_name HealthComponent

@export var MAX_HEALTH : float = 10.0
var health : float

func _ready() -> void:
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.damage
	
	# dead
	if health <= 0:
		health = 0
		print(get_tree().to_string() + "dead")
