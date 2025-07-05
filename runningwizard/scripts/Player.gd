extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

var game_speed: float

func anim_update(state_name: String) -> void:
	anim.speed_scale = 1.0
	
	match state_name:
		"idle":
			if not is_on_floor():
				anim.play("fall")
			else:
				anim.speed_scale = game_speed
				anim.play("run")
		"jump":
			anim.play("jump")
		"land":
			anim.play("land")
		"damaged":
			anim.play("damage")

func update_speed(new_speed: float):
	game_speed = new_speed

func player_damaged(damage_amount: float, knockback_power: Vector2):
	$"State Machine/Damaged".knockback_force = knockback_power
	$"State Machine".manual_state_transition("damaged")
