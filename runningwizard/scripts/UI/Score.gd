extends PanelContainer


@onready var label: Label = $MarginContainer/Label

var score: float
var display_score: float

var game_speed: float = 1
var region: Region


func _process(delta: float) -> void:
	score += (delta * 5) * (game_speed * game_speed)
	display_score = lerpf(display_score, score, 10 * delta)
	update_score_label()

func update_score_label():
	label.text = str(roundi(display_score))

func add_score(added_score: int):
	score += added_score

func update_speed(new_speed: float) -> void:
	game_speed = new_speed

func update_region(new_region: Region) -> void:
	region = new_region
	
	# set font color to match environment
	var tween = create_tween()
	tween.tween_property(label, "theme_override_colors/font_color", region.colors[0], 1)
