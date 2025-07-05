extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var iframes: float

var attackable: bool = true

func damage(attack: Attack):
	if health_component and attackable:
		health_component.damage(attack)
		apply_iframes()

func apply_iframes():
	if iframes <= 0: return
	
	attackable = false
	await get_tree().create_timer(iframes).timeout
	attackable = true
