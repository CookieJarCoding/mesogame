extends Node


const BOB_SPEED: float = 4.0
const BOB_AMPLITUDE: float = 3.0
const OFFSET_DIFFERENTIAL: float = 0.7
const INTERSTITIAL: PackedScene = preload("res://scenes/interstitial_letter.tscn")
var letters: Array
var initial_positions: Array
var delta_counter = 0.0
@onready var transition_rect = $TransitionRect

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
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	$SettingsMenu.visible = true
	$MainMenu.visible = false
	$Logo.visible = false

func _on_settings_close_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	$MainMenu.visible = true
	$Logo.visible = true


func _on_play_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	var fade_tween = create_tween()
	fade_tween.tween_property($TransitionRect, "color:a", 1, 5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	## NOTE: For dummy timing purposes, don't delete
	fade_tween.tween_property($TransitionRect, "position", $TransitionRect.position, 1.5)
	fade_tween.connect("finished", complete_transition)
	#print(transition_rect.color.a)


func complete_transition() -> void:
	RenderingServer.set_default_clear_color(Color("#92c5db"))
	Globals.level_counter += 1
	get_tree().change_scene_to_packed(INTERSTITIAL)


func _on_quit_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	get_tree().quit()
