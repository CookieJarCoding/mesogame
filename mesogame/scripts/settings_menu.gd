extends Panel

signal settings_close


func _ready() -> void:
	if Globals.level_counter > 0:
		$MainGrid/QuitButton.text = "Quit To Menu"
	Globals.load_data()
	$MainGrid/MusicVolume/MusicVolumeSlider.value = Globals.music_volume
	$MainGrid/SoundVolume/SoundVolumeSlider.value = Globals.sound_volume
	$MainGrid/GridContainer/CheckButton.button_pressed = Globals.show_tiles

func _on_music_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(bus_idx, value)
	Globals.music_volume = value

func _on_sound_volume_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(bus_idx, value)
	Globals.sound_volume = value

func _on_close_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	self.visible = false
	get_tree().paused = false
	#print(self.get_parent())
	Globals.save()
	emit_signal("settings_close")

func _on_pause_button_pressed() -> void:
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)

func _on_quit_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	if Globals.level_counter > 0:
		Globals.save()
		CharacterQuota.characters.clear()
		self.get_parent().get_parent().items_in_grid.clear()
		Globals.level_counter = 0
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	else:
		get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	Globals.show_tiles = toggled_on
