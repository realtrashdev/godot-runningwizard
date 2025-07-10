extends PotionEffect
class_name PotionHealing

enum HealType { INSTANT, DELAYED, REGENERATION }
enum HealOperator { ADDITIVE, PERCENTAGE }

@export var heal_type: HealType = HealType.INSTANT
@export var heal_operator: HealOperator = HealOperator.ADDITIVE
@export var heal_amount: int = 20
@export var duration: float = 0.0  # only used for DELAYED / REGENERATION

# Static configuration data
const CONFIG = {
	colors = {
		HealType.INSTANT: Color.RED,
		HealType.DELAYED: Color.DARK_RED,
		HealType.REGENERATION: Color.PALE_VIOLET_RED
	},
	base_names = {
		HealType.INSTANT: "Instant Healing",
		HealType.DELAYED: "Delayed Healing",
		HealType.REGENERATION: "Health Regeneration"
	},
	adjectives = {
		HealType.INSTANT: "Healthy",
		HealType.DELAYED: "Medicinal",
		HealType.REGENERATION: "Regenerative"
	}
}

func _init():
	naming_priority = 1

func get_effect_color() -> Color:
	return CONFIG.colors[heal_type]

func get_base_name() -> String:
	return CONFIG.base_names[heal_type]

func get_adjective() -> String:
	return CONFIG.adjectives[heal_type]

func apply_effect(target, delta: float = 0.0) -> void:
	match heal_type:
		HealType.INSTANT:
			_apply_instant_heal(target)
		HealType.DELAYED:
			target.add_delayed_effect(self, duration)
		HealType.REGENERATION:
			_apply_regen_heal(target, delta)

func _apply_instant_heal(target) -> void:
	if heal_operator == HealOperator.ADDITIVE:
		target.heal(heal_amount)
	else:
		target.heal(target.max_health * heal_amount / 100.0)

func _apply_regen_heal(target, delta: float) -> void:
	var heal_per_second = heal_amount / duration
	if heal_operator == HealOperator.ADDITIVE:
		target.heal(heal_per_second * delta)
	else:
		target.heal(target.max_health * (heal_per_second / 100.0) * delta)

func get_description() -> String:
	var op_text = "HP" if heal_operator == HealOperator.ADDITIVE else "%"
	match heal_type:
		HealType.INSTANT:
			return "Instantly heals %d%s" % [heal_amount, op_text]
		HealType.DELAYED:
			return "Heals %d%s after %.1f seconds" % [heal_amount, op_text, duration]
		HealType.REGENERATION:
			return "Regenerates %d%s over %.1f seconds" % [heal_amount, op_text, duration]
	return "No description provided."
