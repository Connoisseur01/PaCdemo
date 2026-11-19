extends Node2D
class_name InteractableObject

@onready var sprite: Sprite2D = $Sprite2D
@onready var hotspot: Hotspot = $Hotspot

@export_group("Audio")
@export var interaction_sound: AudioStream

var original_scale: Vector2

func _ready() -> void:
	original_scale = scale

	hotspot.clicked.connect(_on_clicked)
	hotspot.hovered.connect(_on_hovered)
	hotspot.unhovered.connect(_on_unhovered)


func _on_clicked(_hotspot: Hotspot) -> void:
	pass


func _on_hovered(_hotspot: Hotspot) -> void:
	pass


func _on_unhovered(_hotspot: Hotspot) -> void:
	pass

func change_sprite(new_texture: Texture2D) -> void:
	sprite.texture = new_texture

func receive_item(_item: InteractableObject) -> bool:
	return false

func play_interaction_sound() -> void:
	if interaction_sound:
		var audio_player = AudioStreamPlayer2D.new()
		audio_player.stream = interaction_sound
		add_child(audio_player)
		audio_player.play()
		audio_player.finished.connect(audio_player.queue_free)
