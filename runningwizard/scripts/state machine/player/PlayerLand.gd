extends State
class_name PlayerLand

@export var player: CharacterBody2D
@export var land_time: float

var speed: float

var _land_time: float

func enter():
	speed = player.player_speed - 20
	player.velocity.y = 0
	_land_time = land_time

func update(delta):
	_land_time -= delta
	
	if _land_time <= 0:
		Transitioned.emit(self, "idle")

func physics_update(_delta):
	# left/right movement
	movement()
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")

func movement():
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()
