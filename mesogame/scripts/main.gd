extends Node


const TILE_WIDTH: int = 128
const TILE_HEIGHT: int = 128
const DROP_SPACE: PackedScene = preload("res://scenes/drop_space.tscn")
const TEST_ITEM: PackedScene = preload("res://scenes/item_unit.tscn")

@export var box_width: int = 5
@export var box_height: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(box_height):
		for j in range(box_width):
			var box_instance = DROP_SPACE.instantiate()
			box_instance.position = $BoxTopLeftCorner.position + Vector2(i * (TILE_WIDTH + 10), j * (TILE_HEIGHT + 10))
			add_child(box_instance)
	var ran_x = randf_range(0, 900)
	var ran_y = randf_range(900, 1000)
	var test_instance = TEST_ITEM.instantiate()
	test_instance.global_position = Vector2(ran_x, ran_y)
	add_child(test_instance)

func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true;