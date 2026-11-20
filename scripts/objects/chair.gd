extends InteractableObject
class_name Chair

@onready var dialogue_box = get_node("/root/Main/UI/DialogueBox")

func _on_clicked(_hotspot: Hotspot) -> void:

	if GameManager.get_flag("lock_unlocked") and not GameManager.get_flag("chair_jumpscare_seen"):

		GameManager.set_flag("chair_jumpscare_seen")
		dialogue_box.show_text("player", "Something's not right...")
		await dialogue_box.dialogue_finished
		dialogue_box.show_jumpscare(
            "You shouldn't have done that."
		)

	else:
		if not GameManager.get_flag("chair_jumpscare_seen"):
			dialogue_box.show_text("player", "Just an ordinary chair...")
		else:
			dialogue_box.show_text("player", "what the hell was that?")
