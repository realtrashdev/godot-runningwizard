extends Enemy

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var game_speed: float = 1.0

func _ready() -> void:
	get_parent().connect("SpeedUpdate", speed_update)

func _process(_delta: float) -> void:
	if anim.animation == "attack" and not anim.is_playing():
		anim.play("run")

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.has_method("damage") and area.is_in_group("Player"):
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.attack_force = knockback
		attack.freeze_time = 0
		
		area.damage(attack)
		
		$"State Machine".manual_state_transition("attack")
		anim.play("attack")

func speed_update(new_speed: float):
	game_speed = new_speed
	anim.speed_scale = new_speed
