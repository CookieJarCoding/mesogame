extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true
	$MainMenu.visible = false

func _on_settings_close_button_pressed() -> void:
	$MainMenu.visible = true
