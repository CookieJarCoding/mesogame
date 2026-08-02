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
var level_counter: int = 1
var level_paths: Array[String] = ["fill",
"res:///scenes/level1.tscn",
"res:///scenes/level2.tscn",
"res:///scenes/level3.tscn",
"res:///scenes/level4.tscn",
"res:///scenes/level5.tscn",
"res:///scenes/level6.tscn",
"res:///scenes/level7.tscn",
"res:///scenes/level8.tscn",
"res:///scenes/level9.tscn",
"res:///scenes/level10.tscn",
"res:///scenes/level11.tscn",
"res:///scenes/ending.tscn"]
