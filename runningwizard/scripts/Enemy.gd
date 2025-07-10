extends Node
class_name Enemy

enum AI_TYPE { GROUNDED, FLYER }

@export var enemy_name: String
@export var enemy_region: Region
@export var enemy_ai_type: AI_TYPE

@export_category("Stats")
@export var damage: float = 1
@export var knockback: Vector2 = Vector2(-150, -100)
