extends Area2D
class_name Hotspot

signal clicked(hotspot: Hotspot)
signal hovered(hotspot: Hotspot)
signal unhovered(hotspot: Hotspot)


@export var object_name: String = "Unknown object"
@export_multiline var description: String = ""

@export_group("Room Transition")
@export_file("*.tscn") var destination_room_path: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit(self)
			
func _on_mouse_entered() -> void:
	hovered.emit(self)

func _on_mouse_exited() -> void:
	unhovered.emit(self)
	
