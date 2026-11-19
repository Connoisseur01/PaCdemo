extends InteractableObject
class_name Lock

@export var unlocked_texture: Texture2D

@onready var room_manager = get_node("/root/Main/RoomManager")

var is_unlocked: bool = false


func receive_item(item: InteractableObject) -> bool:
	if is_unlocked:
		return false

	if not item is Key:
		return false

	print("Door unlocked!")

	is_unlocked = true

	if unlocked_texture:
		change_sprite(unlocked_texture)

	var destination_path = hotspot.destination_room_path

	if destination_path != "":
		var room_scene = load(destination_path) as PackedScene

		if room_scene:
			room_manager.change_room(room_scene)
		else:
			push_error("Could not load room: " + destination_path)

	return true
