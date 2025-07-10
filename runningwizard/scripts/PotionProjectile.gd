extends RigidBody2D
class_name PotionProjectile

@export var potion: Resource
@export var explosion_radius: float = 50.0

func _ready():
	# connect collision
	body_entered.connect(_on_body_entered)
	
	# set color based on potion
	if potion and has_method("get_potion_color"):
		modulate = potion.get_potion_color()

func set_potion(new_potion: Resource) -> void:
	potion = new_potion
	if potion and has_method("get_potion_color"):
		modulate = potion.get_potion_color()

func _on_body_entered(body: Node):
	# apply potion effects
	if body.has_node("EffectManager") and potion:
		var effect_manager = body.get_node("EffectManager")
		effect_manager.apply_potion(potion)
	
	# simple area effect
	if explosion_radius > 0:
		var bodies = get_tree().get_nodes_in_group("affected_by_potions")
		for target in bodies:
			if target == body:
				continue
			if target.global_position.distance_to(global_position) <= explosion_radius:
				if target.has_node("EffectManager") and potion:
					target.get_node("EffectManager").apply_potion(potion)
	
	# destroy projectile
	queue_free()
