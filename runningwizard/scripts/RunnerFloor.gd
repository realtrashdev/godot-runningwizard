extends Node2D

var region: Region

var floor_node: Node2D
var floor_pieces: Array[Sprite2D]
var floor_bg: Sprite2D

func _ready() -> void:
	array_setup()

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

func region_change(new_region: Region):
	region = new_region
	
	# tween color to match new region colors
	var tween: Tween
	for i in range(floor_pieces.size()):
		tween = create_tween()
		tween.tween_property(floor_pieces[i], "modulate", region.colors[i], 1)
	tween = create_tween()
	tween.tween_property(floor_bg, "modulate", region.colors[3], 1)

func speed_change(new_speed: float):
	floor_pieces[0].get_material().set_shader_parameter("speed", new_speed / 5)
