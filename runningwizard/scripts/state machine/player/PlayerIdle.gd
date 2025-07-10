extends State
class_name PlayerIdle

@export var player: CharacterBody2D

var speed: float

var air: bool
var jump_timer: float = 0.0

func enter():
	speed = player.player_speed
	air = not player.is_on_floor()
	jump_timer = 0

func update(delta: float) -> void:
	if jump_timer > 0: jump_timer -= delta
	
	check_transitions()

func physics_update(delta: float) -> void:
	# left/right movement
	movement(delta)
	
	if !player.is_on_floor():
		gravity(delta)

func movement(_delta: float):
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		player.velocity.x = direction * speed
		
		# speed up/slow down animator slightly if moving forward/backward
		if player.is_on_floor():
			player.anim.speed_scale += direction * 0.1
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
		if player.is_on_floor():
			player.anim.speed_scale = player.game_speed
		else:
			player.anim.speed_scale = 1.0

	# clamp speed scale to prevent it from going nutzo insane mode levels of epic fast speed
	if player.is_on_floor():
		player.anim.speed_scale = clampf(player.anim.speed_scale, player.game_speed - 0.3, player.game_speed + 0.3)
	
	player.move_and_slide()

func gravity(delta: float):
	player.velocity += player.get_gravity() * delta

func check_transitions():
	# jump
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			Transitioned.emit(self, "jump")
		
		jump_timer = 0.2
	
	# throw
	if Input.is_action_just_pressed("throw"):
		Transitioned.emit(self, "throw")
	
	# landing
	if air and player.is_on_floor():
		if jump_timer > 0:
			Transitioned.emit(self, "jump")
		else:
			Transitioned.emit(self, "land")
