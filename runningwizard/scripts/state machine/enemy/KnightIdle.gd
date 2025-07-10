extends State
class_name KnightIdle

@export var knight: CharacterBody2D
@export var anim: AnimatedSprite2D

func enter():
	anim.speed_scale = knight.game_speed

func physics_update(delta: float) -> void:
	movement(delta)
	gravity(delta)

func movement(delta: float):
	if knight.position.x < -150:
		knight.position.x = 150
		knight.reset_physics_interpolation()

	knight.velocity.x = -knight.game_speed * knight.speed
	knight.move_and_slide()

func gravity(delta: float):
	knight.velocity += knight.get_gravity() * delta
