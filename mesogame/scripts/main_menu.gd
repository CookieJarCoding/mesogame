extends Node


const BOB_SPEED: float = 4.0
const BOB_AMPLITUDE: float = 3.0
const OFFSET_DIFFERENTIAL: float = 0.7
var letters: Array
var initial_positions: Array
var delta_counter = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letters = $Logo.get_children()
	for letter in letters:
		initial_positions.append(letter.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(letters.size()):
		var letter = letters[i]
		letter.position.y = initial_positions[i].y + BOB_AMPLITUDE * sin(BOB_SPEED * delta_counter + OFFSET_DIFFERENTIAL * i)
	
	delta_counter += delta


func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true
	$MainMenu.visible = false


func _on_settings_close_button_pressed() -> void:
	$MainMenu.visible = true


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res:///scenes/opening_scroll_text.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
