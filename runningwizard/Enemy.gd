extends Node
class_name Enemy

enum AI_TYPE { GROUNDED, FLYER }

@export var enemy_name: String
@export var enemy_region: Region
@export var enemy_ai_type: AI_TYPE
