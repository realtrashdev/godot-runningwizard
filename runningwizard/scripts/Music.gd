extends AudioStreamPlayer2D

var volume: float = 0
var pitch: float = 1

func speed_update(new_speed: float):
	if new_speed > 0:
		update_pitch(0.9 + (new_speed / 10))

func update_pitch(new_pitch: float):
	if not SaveManager.do_pitch_change: return
	
	var tween = create_tween()
	tween.tween_property(self, "pitch_scale", new_pitch, 1.0).set_ease(Tween.EASE_IN)
