extends PanelContainer


@onready var label_container: VBoxContainer = $VBoxContainer
@onready var anim: AnimationPlayer = $AnimationPlayer

var labels: Array[RichTextLabel] = []

var region: Region

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in label_container.get_children():
		if child is RichTextLabel:
			print("got label")
			labels.append(child)

#func update_region(new_region: Region) -> void:
#	region = new_region
#	
#	if region.colors.is_empty():
#		print("colors[] is empty for this region!")
#		return
#	
#	for label in labels:
#		print(label)
#		var tween = create_tween()
#		tween.tween_property(label, "modulate", region.colors[0], 1)

func update_region(new_region: Region) -> void:
	region = new_region
	
	if region.colors.is_empty():
		print("colors[] is empty for this region!")
		return
	
	for label in labels:
		# Validate the label is still valid and in the scene tree
		if not is_instance_valid(label) or not label.is_inside_tree():
			continue
		
		var tween = create_tween()
		tween.tween_property(label, "modulate", region.colors[0], 1.0)
		
		$VBoxContainer/RegionLabel.text = "- " + region.name + " -"
	
	anim.play("display")
