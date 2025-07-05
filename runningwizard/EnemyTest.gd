extends Enemy

@onready var anim: AnimatedSprite2D = $bluezone_knight

func _process(delta: float) -> void:
	if anim.animation == "attack" and not anim.is_playing():
		anim.play("run")

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.has_method("damage") and area.is_in_group("Player"):
		var attack = Attack.new()
		attack.attack_damage = 1
		attack.attack_force = Vector2(-250, -100)
		attack.freeze_time = 0
		
		area.damage(attack)
		anim.play("attack")
