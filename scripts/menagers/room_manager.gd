extends Node

@export var starting_room: PackedScene

@onready var room_container: Node2D = $"../RoomContainer"

var current_room: Node2D = null


func _ready() -> void:
	if starting_room:
		change_room(starting_room)

func change_room(room_scene: PackedScene) -> void:
	
	if current_room:
		current_room.queue_free()

	current_room = room_scene.instantiate()
	
	room_container.add_child(current_room)
