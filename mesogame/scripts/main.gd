extends Node


const TILE_WIDTH: int = 128
const TILE_HEIGHT: int = 128
const DROP_SPACE: PackedScene = preload("res://scenes/drop_space.tscn")

@export var box_width: int = 5
@export var box_height: int = 5



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(box_height):
		for j in range(box_width):
			var drop_instance = DROP_SPACE.instantiate()
			drop_instance.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
			drop_instance.position = $InvTopLeftCorner.position + Vector2(i * (TILE_WIDTH + 10), j * (TILE_HEIGHT + 10))
			add_child(drop_instance)
	for i in range(box_height):
		for j in range(box_width):
			var box_instance = DROP_SPACE.instantiate()
			box_instance.position = $BoxTopLeftCorner.position + Vector2(i * (TILE_WIDTH + 10), j * (TILE_HEIGHT + 10))
			add_child(box_instance)
