extends InteractableObject
class_name InspectableObject

var inspection_dialogue: Array[Dictionary]

@onready var dialogue_box = get_node("/root/Main/UI/DialogueBox")

func _on_clicked(_hotspot: Hotspot) -> void:
	if inspection_dialogue == null:
		push_warning("No inspection dialogue assigned to " + name)
		return

	start_inspection()

func start_inspection() -> void:
	dialogue_box.start_inspection(
		sprite.texture,
		inspection_dialogue
	)
