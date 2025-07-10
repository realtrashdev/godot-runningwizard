extends State
class_name PlayerThrow

@export var player: CharacterBody2D
@export var throw_timer: float = 1
@export var potion_scene: PackedScene
@export var throw_offset: Vector2 = Vector2(20, 0)
@export var min_throw_force: float = 200.0
@export var max_throw_force: float = 600.0
@export var throw_angle: float = 45.0

var speed: float
var air: bool
var jump_timer: float = 0.0
var throw_timer_current: float

func enter():
	print("throw!")
	
	speed = player.player_speed - 40
	throw_timer_current = throw_timer
	jump_timer = 0
	player.velocity = Vector2.ZERO
	
	get_mouse_pos()
	
	air = not player.is_on_floor()

func update(delta: float) -> void:
	if throw_timer_current > 0: 
		throw_timer_current -= delta
	
	if Input.is_action_just_pressed("jump"):
		jump_timer = 0.2
		
	# don't transition until throw is complete
	if throw_timer_current > 0: 
		return
		
	# handle transitions after throw is done
	if jump_timer > 0 and player.is_on_floor():
		Transitioned.emit(self, "jump")
	elif player.is_on_floor() and air:
		Transitioned.emit(self, "land")
	else:
		Transitioned.emit(self, "idle")

func physics_update(delta: float) -> void:
	# left/right movement
	movement(delta)
	
	if !player.is_on_floor():
		gravity(delta)

func exit():
	player.get_node("AnimatedSprite2D").flip_h = false

func movement(delta: float):
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * speed, 50)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
	player.move_and_slide()

func gravity(delta: float):
	player.velocity += player.get_gravity() * (0.1 * delta)

func get_mouse_pos():
	var mouse_pos = player.get_global_mouse_position()
	var character_pos = player.global_position
	
	if mouse_pos.x < character_pos.x:
		player.get_node("AnimatedSprite2D").flip_h = true
		pass
	elif mouse_pos.x > character_pos.x:
		player.get_node("AnimatedSprite2D").flip_h = false
		pass
