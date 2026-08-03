extends Node2D

var save_path = "user://save_file.save"

var is_dragging = false

var show_tiles: bool = false

enum item_types {
	LUXURY,
	CONSUMABLES,
	TOYS,
	HANDICRAFTS,
	PRACTICAL,
	APPAREL,
	TECHNOLOGY
}
var level_counter: int = 0
var has_finished: bool = false
var levels: Array[PackedScene] = [load("res:///scenes/main.tscn"),
load("res:///scenes/levels/level1.tscn"),
load("res:///scenes/levels/level2.tscn"),
load("res:///scenes/levels/level3.tscn"),
load("res:///scenes/levels/level4.tscn"),
load("res:///scenes/levels/level5.tscn"),
load("res:///scenes/levels/level6.tscn"),
load("res:///scenes/levels/level7.tscn"),
load("res:///scenes/levels/level8.tscn"),
load("res:///scenes/levels/level9.tscn"),
load("res:///scenes/levels/level10.tscn"),
load("res:///scenes/levels/level11.tscn"),
load("res:///scenes/levels/level12.tscn"),
load("res://scenes/levels/levelend.tscn"), # NOTE: ending level
load("res:///scenes/ending.tscn") # NOTE: ending scene
]
#

## NOTE: for debugging purposes
func _ready() -> void:
	if OS.is_debug_build():
		level_counter = 0

func save() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(level_counter)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		level_counter = file.get_var(level_counter)
	else:
		level_counter = 11
