extends InteractableObject
class_name Lock

@export var unlocked_texture: Texture2D

@onready var room_manager = get_node("/root/Main/RoomManager")
@onready var dialogue_box = get_node("/root/Main/UI/DialogueBox")

var is_unlocked: bool = false

func _ready() -> void:
	super._ready()

	is_unlocked = GameManager.get_flag("lock_unlocked")

	if is_unlocked and unlocked_texture:
		change_sprite(unlocked_texture)

func receive_item(item: InteractableObject) -> bool:
	if is_unlocked:
		return false

	if not item is Key:
		return false

	print("Door unlocked!")

	is_unlocked = true
	GameManager.set_flag("lock_unlocked")
	
	if unlocked_texture:
		change_sprite(unlocked_texture)

	var dialogue: Array[Dictionary] = [
		{"speaker": "narrator", "text": "The lock has been opened."},
		{"speaker": "player", "text": "chuj mnie to xd"}
	]
	dialogue_box.start_dialogue(dialogue)

	return true
