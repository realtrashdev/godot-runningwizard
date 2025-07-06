extends State
class_name PlayerJump

@export var player: CharacterBody2D
@export var speed: float
@export var jump_velocity: float

func enter():
	player.velocity.y = jump_velocity

func physics_update(delta: float):
	# jump gravity handling
	gravity(delta)

	# left/right movement
	movement()

func gravity(delta: float) -> void:
	if player.velocity.y < 0:
		if Input.is_action_pressed("jump"):
			player.velocity += player.get_gravity() / 2 * delta
		else:
			player.velocity += player.get_gravity() * delta
 
	elif player.velocity.y >= 0:
		Transitioned.emit(self, "idle")

func movement():
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()
