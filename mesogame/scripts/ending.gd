extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_to_menu_button_pressed() -> void:
	Globals.level_counter = 1
	Globals.has_finished = true
	get_tree().change_scene_to_file("res:///scenes/mainmenu.tscn")
	
