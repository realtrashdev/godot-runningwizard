extends State
class_name KnightDamaged

@export var character: CharacterBody2D
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
	
	if _damage_time <= 0 and character.is_on_floor():
		character.get_node("AnimatedSprite2D").flip_h = false
		Transitioned.emit(self, "idle")

func physics_update(delta: float):
	character.velocity.x = move_toward(character.velocity.x, 0, delta * 5)
	
	gravity(delta)
	character.move_and_slide()
	
	if character.is_on_floor():
		character.velocity.y = _bounce_power + bounces
		bounces += 30
	
	if character.is_on_wall():
		character.velocity.x = -x_velocity
		character.get_node("AnimatedSprite2D").flip_h = !character.get_node("AnimatedSprite2D").flip_h
	
	x_velocity = character.velocity.x

func gravity(delta: float):
	character.velocity += character.get_gravity() * delta

func setup(knockback_power: Vector2):
	_damage_time = damage_time
	_bounce_power = bounce_power
	character.velocity = Vector2.ZERO
	character.velocity = knockback_power
	bounces = 0
