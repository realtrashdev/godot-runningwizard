extends Node2D

var region: Region
var floor_node: Node2D
var floor_pieces: Array[Sprite2D]
var floor_bg: Sprite2D

# Scroll management
var current_speed: float = 1.0
var scroll_distance: float = 0.0

func _ready() -> void:
	array_setup()

func _process(delta: float):
	# Accumulate scroll distance based on current speed
	scroll_distance += current_speed * delta
	update_scroll_offset()

func array_setup():
	# assign vars for parent node of floor pieces and bg piece
	for child in get_children():
		if child.name == "Floor Pieces":
			floor_node = child
		if child.name == "Background":
			floor_bg = child
	
	# assign floor pieces to array
	for child in floor_node.get_children():
		if child is Sprite2D:
			floor_pieces.append(child)

func update_scroll_offset():
	# Update scroll_offset for any piece (since they share materials, updating one updates all)
	if floor_pieces.size() > 0:
		var material = floor_pieces[0].get_material() as ShaderMaterial
		if material:
			material.set_shader_parameter("scroll_offset", scroll_distance)

func region_change(new_region: Region):
	region = new_region
	
	# tween color to match new region colors - create separate tween for each piece
	for i in range(floor_pieces.size()):
		var piece_tween = create_tween()
		piece_tween.tween_property(floor_pieces[i], "modulate", region.colors[i], 1.0)
	
	var bg_tween = create_tween()
	bg_tween.tween_property(floor_bg, "modulate", region.colors[3], 1.0)

func speed_change(new_speed: float):
	var target_speed = new_speed / 7.5
	
	# Smooth speed transition with fixed duration
	var tween = create_tween()
	tween.tween_method(set_scroll_speed, current_speed, target_speed, 1.0).set_ease(Tween.EASE_OUT)  # 1 second duration

func set_scroll_speed(speed: float):
	current_speed = speed
