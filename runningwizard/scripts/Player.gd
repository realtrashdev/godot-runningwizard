extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $"State Machine"

@export var player_speed: float = 50.0

var game_speed: float

func _physics_process(delta: float) -> void:
	if $BounceRayCast2D.is_colliding():
		check_bounce()

func anim_update(state_name: String) -> void:
	anim.speed_scale = 1.0
	match state_name:
		"idle":
			if not is_on_floor():
				anim.play("fall")
			else:
				anim.play("run")
		"jump":
			anim.play("jump")
		"land":
			anim.play("land")
		"damaged":
			anim.play("damage")
		"throw":
			anim.play("throw")

func update_speed(new_speed: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "game_speed", new_speed, 1.0).set_ease(Tween.EASE_OUT)

func player_damaged(_damage_amount: float, knockback_power: Vector2) -> void:
	state_machine.get_node("Damaged").knockback_force = knockback_power
	state_machine.manual_state_transition("damaged")

func check_bounce() -> void:
	if anim.animation == "damage": return
	
	var area = $BounceRayCast2D.get_collider()
	
	if area.has_method("damage") and velocity.y > 0:
		print("bouncing")
		var attack = Attack.new()
		attack.attack_damage = 0
		attack.attack_force = Vector2(150, -200)
		
		area.damage(attack)
		state_machine.manual_state_transition("jump")
