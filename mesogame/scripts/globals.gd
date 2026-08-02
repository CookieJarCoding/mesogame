extends Node2D

var is_dragging = false
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
#var levels: Array[PackedScene] = [preload("res:///scenes/level1.tscn"),
#preload("res:///scenes/level1.tscn"),
#preload("res:///scenes/level2.tscn"),
#preload("res:///scenes/level3.tscn"),
#preload("res:///scenes/level4.tscn"),
#preload("res:///scenes/level5.tscn"),
#preload("res:///scenes/level6.tscn"),
#preload("res:///scenes/level7.tscn"),
#preload("res:///scenes/level8.tscn"),
#preload("res:///scenes/level9.tscn"),
#preload("res:///scenes/level10.tscn"),
#preload("res:///scenes/level11.tscn"),
#preload("res:///scenes/ending.tscn")]
#

## NOTE: for debugging purposes
func _ready() -> void:
	if OS.is_debug_build():
		level_counter = 1
