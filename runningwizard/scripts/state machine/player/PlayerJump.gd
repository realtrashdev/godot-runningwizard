extends State
class_name PlayerJump

@export var player: CharacterBody2D
@export var jump_velocity: float

var speed: float

func enter():
	speed = player.player_speed
	player.velocity.y = jump_velocity

func update(delta: float):
	if player.velocity.y >= 0:
		Transitioned.emit(self, "idle")
	
	if Input.is_action_just_pressed("throw"):
		Transitioned.emit(self, "throw")

func physics_update(delta: float):
	# jump gravity handling
	gravity(delta)

	# left/right movement
	movement()

func gravity(delta: float) -> void:
	if delta <= 0: return
	
	if Input.is_action_pressed("jump"):
		player.velocity += player.get_gravity() / 2 * delta
	else:
		player.velocity += player.get_gravity() * delta

func movement():
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()
