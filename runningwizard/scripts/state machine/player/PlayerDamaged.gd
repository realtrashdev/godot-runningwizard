extends State
class_name PlayerDamaged

signal Damaged

@export var player: CharacterBody2D
@export var damage_time: float
@export var bounce_power: float

var _damage_time: float
var _bounce_power: float
var bounces: int

func enter():
	Damaged.emit()
	setup()

func update(delta: float):
	_damage_time -= delta
	
	if _damage_time <= 0 and player.is_on_floor():
		Transitioned.emit(self, "land")

func physics_update(delta: float):
	if player.velocity.x > 0:
		player.velocity.x = -100
	
	player.velocity.x += 50 * delta
	
	gravity(delta)
	player.move_and_slide()
	
	if player.is_on_floor():
		player.velocity.y = _bounce_power + bounces
		bounces += 30

func gravity(delta: float):
	player.velocity += player.get_gravity() * delta

func setup():
	_damage_time = damage_time
	_bounce_power = bounce_power
	player.velocity = Vector2.ZERO
	player.velocity.x = -100
	player.velocity.y = -150
	bounces = 0
