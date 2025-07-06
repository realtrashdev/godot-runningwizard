extends Node2D

signal SpeedUpdate(float)
signal RegionUpdate(Region)

@export var default_speed: float
@export var default_region: Region

var regions: Array[Region] = []

var game_speed: float = 1.0
var game_region: Region = null

const REGION_FOLDER: String = "res://scenes/resources/regions/"

func _ready() -> void:
	randomize()
	get_regions()
	
	call_deferred("update_speed", default_speed)
	call_deferred("update_region", regions[randi() % regions.size()])

func _process(_delta: float) -> void:
	# DO NOT SHIP!!!!
	debug_stuffs()

func update_speed(new_speed: float):
	game_speed = new_speed
	game_speed = clampf(game_speed, 1, 5)
	SpeedUpdate.emit(game_speed)
	print("Speed updated to " + str(game_speed))

func update_region(new_region: Region):
	game_region = new_region
	RegionUpdate.emit(game_region)
	print("Region updated to " + game_region.name)

func get_regions():
	var dir = DirAccess.open(REGION_FOLDER)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				var path = REGION_FOLDER + file_name
				var region = load(path)
				if region is Region:
					regions.append(region)
					print(region.name)
			file_name = dir.get_next()
		dir.list_dir_end()

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
