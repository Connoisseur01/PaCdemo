extends InteractableObject
class_name Key

var is_dragging: bool = false
var starting_position: Vector2


func _ready() -> void:
	super._ready()
	if GameManager.get_flag("lock_unlocked"):
		queue_free()
		return
	starting_position = global_position


func _on_clicked(_hotspot: Hotspot) -> void:
	print("KEY CLICKED!")
	is_dragging = true


func _process(_delta: float) -> void:
	if is_dragging:
		print("DRAGGING: ", get_global_mouse_position())
		global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if not is_dragging:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			finish_dragging()

func finish_dragging() -> void:
	is_dragging = false

	# Check which areas the key overlaps.
	for area in hotspot.get_overlapping_areas():

		var target = area.get_parent()

		if target is InteractableObject:
			if target.receive_item(self):
				queue_free()
				return

	# No object accepted the key.
	global_position = starting_position
