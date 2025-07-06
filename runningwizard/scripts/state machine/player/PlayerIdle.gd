extends State
class_name PlayerIdle

@export var player: CharacterBody2D
@export var speed: float

var air

func enter():
	air = not player.is_on_floor()

func physics_update(delta: float):
	# left/right movement
	movement(delta)
	
	if !player.is_on_floor():
		gravity(delta)

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")
	
	if air and player.is_on_floor():
		Transitioned.emit(self, "land")

func movement(delta: float):
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		player.velocity.x = direction * speed
		player.anim.speed_scale += direction * 0.1
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.anim.speed_scale = player.game_speed

	player.anim.speed_scale = clampf(player.anim.speed_scale, player.game_speed - 0.3, player.game_speed + 0.3)
	player.move_and_slide()

func gravity(delta: float):
	player.velocity += player.get_gravity() * delta
