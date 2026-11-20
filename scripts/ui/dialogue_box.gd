extends Control

signal dialogue_finished
signal jumpscare_finished

@onready var speaker_label: Label = $Panel/MarginContainer/VBoxContainer/SpeakerName
@onready var dialogue_label: RichTextLabel = $Panel/MarginContainer/VBoxContainer/DialogueText
@onready var dimmer: ColorRect = $Dimmer
@onready var inspection_image: TextureRect = $InspectionImage
@onready var jumpscare_overlay: ColorRect = $JumpscareOverlay
@onready var jumpscare_text: Label = $JumpscareOverlay/JumpscareText

var jumpscare_active: bool = false
var inspection_active: bool = false
var dialogue_lines: Array[Dictionary] = []
var current_line: int = 0
var dialogue_active: bool = false


func _ready() -> void:
	hide()
	dimmer.hide()
	inspection_image.hide()
	jumpscare_overlay.hide()
	
	dialogue_label.fit_content = true
	dialogue_label.scroll_active = false


func start_dialogue(lines: Array[Dictionary]) -> void:
	if lines.is_empty():
		return

	dialogue_lines = lines.duplicate()
	current_line = 0
	dialogue_active = true

	show_current_line()
	show()

func show_current_line() -> void:
	var line = dialogue_lines[current_line]

	speaker_label.text = line.get("speaker", "")
	dialogue_label.text = line.get("text", "")


func advance_dialogue() -> void:
	if not dialogue_active:
		return

	current_line += 1

	if current_line >= dialogue_lines.size():
		end_dialogue()
	else:
		show_current_line()


func end_dialogue() -> void:
	dialogue_active = false
	dialogue_lines.clear()
	current_line = 0

	if inspection_active:
		inspection_active = false
		dimmer.hide()
		inspection_image.hide()

	hide()
	dialogue_finished.emit()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if dialogue_active:
				advance_dialogue()
				accept_event()


func show_text(title: String, message: String) -> void:
	start_dialogue([
		{"speaker": title, "text": message}
	])


func show_description(hotspot: Hotspot) -> void:
	start_dialogue([
		{"speaker": hotspot.object_name, "text": hotspot.description}
	])
	
func start_inspection(texture: Texture2D, dialogue: Array[Dictionary]) -> void:
	if texture == null or dialogue == null:
		return

	inspection_active = true
	inspection_image.texture = texture
	dimmer.show()
	inspection_image.show()

	start_dialogue(dialogue)
	
func show_jumpscare(message: String, time: float = 1.0) -> void:
	jumpscare_active = true
	jumpscare_text.text = message
	jumpscare_overlay.show()
	show()
	await get_tree().create_timer(time).timeout
	
	jumpscare_active = false
	jumpscare_overlay.hide()
	hide()
	jumpscare_finished.emit()
	
