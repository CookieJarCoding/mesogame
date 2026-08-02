extends Panel

signal settings_close


func _ready() -> void:
	if Globals.level_counter > 0:
		$MainGrid/QuitButton.text = "Quit To Menu"

func _on_music_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(bus_idx, value)
	GameSettings.music_volume = value

func _on_sound_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(bus_idx, value)
	GameSettings.sound_volume = value

func _on_close_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false
	#print(self.get_parent())
	emit_signal("settings_close")

func _on_pause_button_pressed() -> void:
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible

func _on_quit_button_pressed() -> void:
	if Globals.level_counter > 0:
		Globals.level_counter = 0
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	else:
		get_tree().quit()
