extends State
class_name KnightIdle

@export var knight: CharacterBody2D


func _physics_process(delta: float) -> void:
	knight.velocity.x = -knight.game_speed * 25
	
	movement(delta)
	gravity(delta)

func movement(delta: float):
	knight.move_and_slide()

func gravity(delta: float):
	knight.velocity += knight.get_gravity() * delta
