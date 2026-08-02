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
var levels: Array[PackedScene] = [preload("res:///scenes/main.tscn"),
preload("res:///scenes/levels/debug_room.tscn"),
#preload("res:///scenes/levels/level1.tscn"),
#preload("res:///scenes/levels/level2.tscn"),
#preload("res:///scenes/levels/level3.tscn"),
#preload("res:///scenes/levels/level4.tscn"),
#preload("res:///scenes/levels/level5.tscn"),
#preload("res:///scenes/levels/level6.tscn"),
#preload("res:///scenes/levels/level7.tscn"),
#preload("res:///scenes/levels/level8.tscn"),
#preload("res:///scenes/levels/level9.tscn"),
#preload("res:///scenes/levels/level10.tscn"),
#preload("res:///scenes/levels/level11.tscn"),
#preload("res:///scenes/ending.tscn")
]
#

## NOTE: for debugging purposes
func _ready() -> void:
	if OS.is_debug_build():
		level_counter = 0
