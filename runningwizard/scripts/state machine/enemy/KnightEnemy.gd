extends Enemy

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $"State Machine"

@export var default_speed: float = 51.0
# not applied to character. can be modified by outside sources.
var move_speed: float = 51.0

var speed: float

var game_speed: float = 1.0

func _ready() -> void:
	move_speed = default_speed * game_speed
	speed = move_speed
	get_parent().connect("SpeedUpdate", speed_update)

func _process(_delta: float) -> void:
	if anim.animation == "attack" and not anim.is_playing():
		anim.play("run")
	
	match anim.animation:
		"run":
			anim.speed_scale = game_speed
		_:
			anim.speed_scale = 1.0

func _physics_process(delta: float) -> void:
	get_move_speed()

# attacking
func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if anim.animation == "damage": return
	
	if area.has_method("damage") and area.is_in_group("Player") and area.attackable:
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.attack_force = knockback
		attack.freeze_time = 0
		
		area.damage(attack)
		anim.speed_scale = 1.0
		anim.play("attack")

func anim_update(state_name: String) -> void:
	match state_name:
		"idle":
			anim.play("run")
		"damaged":
			anim.play("damage")

func enemy_damaged(_damage_amount: float, knockback_power: Vector2) -> void:
	state_machine.get_node("Damaged").knockback_force = knockback_power
	state_machine.manual_state_transition("damaged")

func get_move_speed():
	var modifier: float = 1
	
	if anim.animation == "attack":
		modifier = 1.5
	
	if move_speed != 0:
		speed = move_speed / modifier

func speed_update(new_speed: float):
	var tween = create_tween()
	tween.tween_property(self, "game_speed", new_speed, 1.0).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(anim, "speed_scale", new_speed, 1.0).set_ease(Tween.EASE_OUT)
