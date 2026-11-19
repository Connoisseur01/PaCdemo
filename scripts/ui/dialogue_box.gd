
extends Control

@onready var object_name_label: Label = $Panel/MarginContainer/VBoxContainer/ObjectName
@onready var description_label: RichTextLabel = $Panel/MarginContainer/VBoxContainer/Description

func _ready() -> void:
	hide()
	description_label.fit_content = true
	description_label.scroll_active = false

func show_description(hotspot: Hotspot) -> void:
	object_name_label.text = hotspot.object_name
	description_label.text = hotspot.description
	show()

func hide_dialogue() -> void:
	hide()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			hide_dialogue()
			accept_event()
