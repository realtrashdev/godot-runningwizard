extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func anim_update(state_name: String) -> void:
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
