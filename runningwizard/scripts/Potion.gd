extends Resource
class_name Potion

@export var effects: Array[PotionEffect] = []
@export var custom_name: String = ""

func get_potion_name() -> String:
	if custom_name != "":
		return custom_name
	
	if effects.is_empty():
		return "Empty Potion"
	
	# sort effects by priority (lower number = higher)
	var sorted_effects = effects.duplicate()
	sorted_effects.sort_custom(func(a, b): return a.naming_priority < b.naming_priority)
	
	# primary effect determines base name
	var primary_effect = sorted_effects[0]
	var secondary_effects = sorted_effects.slice(1)
	
	# build name with adjectives taken from secondary effects
	var adjectives = []
	for effect in secondary_effects:
		if adjectives.has(effect.get_adjective()):
			print("Duplicate potion adjective thrown away")
		else:
			adjectives.append(effect.get_adjective())
	
	# combine adjectives and base name
	if adjectives.is_empty():
		return "Potion of " + primary_effect.get_base_name()
	else:
		return "Potion of " + " ".join(adjectives) + " " + primary_effect.get_base_name()

func get_potion_color() -> Color:
	if effects.is_empty():
		return Color.GRAY
	
	# blend colors based on effect intensity
	var total_intensity = 0.0
	var blended_color = Color.BLACK
	
	for effect in effects:
		var effect_color = effect.get_effect_color()
		blended_color += effect_color * effect.intensity
		total_intensity += effect.intensity
	
	if total_intensity > 0:
		blended_color /= total_intensity
	
	return blended_color

func apply_to_target(target) -> void:
	for effect in effects:
		effect.apply_effect(target)

func get_description() -> String:
	var desc = get_potion_name() + "\n\nEffects:\n"
	for effect in effects:
		desc += "• " + effect.get_description() + "\n"
	return desc

func print_information():
	get_potion_name()
	print(custom_name + "\n" + str(effects))
