extends Node

# player stats
var high_score: int = 0

# settings
var do_pitch_change: bool = true 

const SAVE_PATH = "user://savegame.cfg"

func _ready() -> void:
	var potion_test = Potion.new()
	potion_test.effects.append(PotionHealing.new())
	potion_test.effects.append(PotionHealing.new())
	potion_test.effects.append(PotionHealing.new())
	print(potion_test.get_potion_name())
