extends Node2D

signal SpeedUpdate(float)
signal RegionUpdate(Region)

@export var default_speed: float
@export var default_region: Region

var regions: Array[Region] = []

var game_speed: float = 1.0
var game_region: Region = null

const REGIONS: Array[Region] = [
	preload("res://scenes/resources/regions/CastleHalls.tres"),
	preload("res://scenes/resources/regions/Catacombs.tres"),
	preload("res://scenes/resources/regions/Dancefloor.tres")
]

func _ready() -> void:
	randomize()
	regions = get_regions()
	
	call_deferred("update_speed", default_speed)
	
	if (regions.size() > 0):
		call_deferred("update_region", regions[0])
	else:
		print("no regions in region array")

func _process(_delta: float) -> void:
	# DO NOT SHIP!!!!
	debug_stuffs()

func update_speed(new_speed: float):
	print("updating speed")
	game_speed = new_speed
	game_speed = clampf(game_speed, 1, 5)
	SpeedUpdate.emit(game_speed)
	print("Speed updated to " + str(game_speed))

func update_region(new_region: Region):
	print("updating region")
	game_region = new_region
	RegionUpdate.emit(game_region)
	print("Region updated to " + game_region.name)

func get_regions() -> Array[Region]:
	var arr: Array[Region] = []
	
	for region in REGIONS:
		if region is Region:
			arr.append(region)
			print(region.name)
	
	return arr

func debug_stuffs():
	if Input.is_key_pressed(KEY_0):
		update_region(regions[0])
	if Input.is_key_pressed(KEY_1):
		update_region(regions[1])
	if Input.is_key_pressed(KEY_2):
		update_region(regions[2])
	if Input.is_key_label_pressed(KEY_3):
		update_speed(1)
	if Input.is_key_pressed(KEY_4):
		update_speed(2)
	if Input.is_key_pressed(KEY_5):
		update_speed(3)
