extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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


func _on_pause_button_pressed() -> void:
	if not self.visible:
		self.visible = true
	else:
		self.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
