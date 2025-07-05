extends State
class_name PlayerDamaged

@export var player: CharacterBody2D
@export var damage_time: float
@export var bounce_power: float

var _damage_time: float
var _bounce_power: float
var bounces: int
var knockback_force: Vector2

var x_velocity: float

func enter():
	setup(knockback_force)

func update(delta: float):
	_damage_time -= delta
	
	if _damage_time <= 0 and player.is_on_floor():
		player.get_node("AnimatedSprite2D").flip_h = false
		Transitioned.emit(self, "land")

func physics_update(delta: float):
	player.velocity.x = move_toward(player.velocity.x, 0, delta * 5)
	
	gravity(delta)
	player.move_and_slide()
	
	if player.is_on_floor():
		player.velocity.y = _bounce_power + bounces
		bounces += 30
	
	if player.is_on_wall():
		player.velocity.x = -x_velocity
		player.get_node("AnimatedSprite2D").flip_h = !player.get_node("AnimatedSprite2D").flip_h
	
	x_velocity = player.velocity.x

func gravity(delta: float):
	player.velocity += player.get_gravity() * delta

func setup(knockback_power: Vector2):
	print("setup")
	_damage_time = damage_time
	_bounce_power = bounce_power
	player.velocity = Vector2.ZERO
	player.velocity = knockback_power
	bounces = 0
