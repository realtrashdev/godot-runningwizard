extends Node
class_name HealthComponent

signal DamageTaken()

@export var MAX_HEALTH : float = 10.0
var health : float

func _ready() -> void:
	health = MAX_HEALTH

func damage(attack: Attack):
	print(get_parent().name + " damaged for " + str(attack.attack_damage) + " damage.")
	health -= attack.attack_damage
	DamageTaken.emit(attack.attack_damage, attack.attack_force)
	
	# dead
	if health <= 0:
		health = 0
		print(get_parent().name + " dead")

func heal(healing: float):
	pass
