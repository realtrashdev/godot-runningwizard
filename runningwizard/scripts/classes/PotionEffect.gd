extends Resource
class_name PotionEffect

# lower = higher priority
@export var naming_priority: int = 0
# base intensity of effect (0-100)
@export var intensity: float = 50.0

# virtual methods
func get_effect_color() -> Color:
	return Color.WHITE

func get_base_name() -> String:
	return "Unknown Effect"

func get_adjective() -> String:
	return "Strange"

func apply_effect(target, delta: float = 0.0) -> void:
	push_error("apply_effect must be overridden")

func get_description() -> String:
	return "No description"
