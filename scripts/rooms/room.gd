extends Node2D
class_name Room

@onready var room_manager = get_node("/root/Main/RoomManager")
@onready var dialogue_box = get_node("/root/Main/UI/DialogueBox")


func _ready() -> void:

	var hotspots = get_tree().get_nodes_in_group("hotspots")
	print("--- ROOM LOADED: ", scene_file_path, " ---")

	for hotspot in hotspots:
		print("Found hotspot: ", hotspot.get_path())
		print("Destination: ", hotspot.destination_room_path)
		hotspot.clicked.connect(_on_hotspot_clicked)
		hotspot.hovered.connect(_on_hotspot_hovered)
		hotspot.unhovered.connect(_on_hotspot_unhovered)


func _on_hotspot_clicked(hotspot: Hotspot) -> void:
	if hotspot.get_parent() is InteractableObject:
		return
	print("Clicked: ", hotspot.object_name)
	print("Destination: ", hotspot.destination_room_path)

	if hotspot.destination_room_path != "":
		var room_scene = load(hotspot.destination_room_path) as PackedScene

		if room_scene:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			room_manager.change_room(room_scene)
		else:
			push_error("Could not load room: " + hotspot.destination_room_path)

		return
	

	#dialogue_box.show_description(hotspot)


func _on_hotspot_hovered(hotspot: Hotspot) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_hotspot_unhovered(hotspot: Hotspot) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
