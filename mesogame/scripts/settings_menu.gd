extends Panel

signal settings_close

func _on_music_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(0, value)
	GameSettings.music_volume = value

func _on_sound_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(0, value)
	GameSettings.music_volume = value

func _on_close_button_pressed() -> void:
	self.visible = false
	print(self.get_parent())
	emit_signal("settings_close")

func _on_pause_button_pressed() -> void:
	self.visible = not self.visible

func _on_quit_button_pressed() -> void:
	get_tree().quit()
