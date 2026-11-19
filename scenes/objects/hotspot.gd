extends Area2D
class_name Hotspot

signal clicked(hotspot: Hotspot)
signal hovered(hotspot: Hotspot)
signal unhovered(hotspot: Hotspot)


@export var object_name: String = "Unknown object"
@export_multiline var description: String = ""

@export_group("Room Transition")
@export_file("*.tscn") var destination_room_path: String = ""

signal dropped_on(target: Hotspot)

@export_group("Drag and Drop")
@export var draggable: bool = false

var is_dragging: bool = false
var original_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	original_position = global_position
	
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if draggable:
				is_dragging = true
				original_position = global_position
			else:
				clicked.emit(self)
				print("Clicked: ", object_name)
				print(description)
			
func _on_mouse_entered() -> void:
	hovered.emit(self)

func _on_mouse_exited() -> void:
	unhovered.emit(self)
	
func _input(event: InputEvent) -> void:
	if not draggable or not is_dragging:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			finish_dragging()


func finish_dragging() -> void:
	is_dragging = false

	# Check whether we dropped the object on another hotspot.
	for area in get_overlapping_areas():
		if area is Hotspot:
			dropped_on.emit(area)
			return

	# Nothing was underneath the object, so return it.
	global_position = original_position
