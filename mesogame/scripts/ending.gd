extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioLibrary.play_music(AudioLibrary.music.TITLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_to_menu_button_pressed() -> void:
	Globals.level_counter = 1
	Globals.has_finished = true
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	get_tree().change_scene_to_file("res:///scenes/mainmenu.tscn")
	
