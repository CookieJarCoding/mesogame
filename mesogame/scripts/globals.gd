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
var levels: Array[PackedScene] = [load("res:///scenes/main.tscn"),
load("res:///scenes/levels/level1.tscn"),
load("res:///scenes/levels/level2.tscn"),
#load("res:///scenes/levels/level3.tscn"),
#load("res:///scenes/levels/level4.tscn"),
#load("res:///scenes/levels/level5.tscn"),
#load("res:///scenes/levels/level6.tscn"),
#load("res:///scenes/levels/level7.tscn"),
#load("res:///scenes/levels/level8.tscn"),
#load("res:///scenes/levels/level9.tscn"),
#load("res:///scenes/levels/level10.tscn"),
#load("res:///scenes/levels/level11.tscn"),
#load("res:///scenes/ending.tscn")
]
#

## NOTE: for debugging purposes
func _ready() -> void:
	if OS.is_debug_build():
		level_counter = 1
