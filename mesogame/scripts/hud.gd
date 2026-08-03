extends CanvasLayer

signal reset_level
signal next_level

const char_quota: PackedScene = preload("res://scenes/character_quota.tscn")

@onready var vbox: VBoxContainer = $Panel/VBoxContainer/MarginContainer/ScrollContainer/VBox
@onready var anim = $Anim
@onready var warning_timer = $WarningTimer
@onready var handle_with_care = $Panel/HandleWithCare


func create_character(char_name: String, score: int, quota: int, likes: Array, dislikes: Array, texture_path: String) -> void:
	var q = char_quota.instantiate()
	q.char_name = char_name
	q.score = score
	q.quota = quota
	q.likes.append_array(likes)
	q.dislikes.append_array(dislikes)
	q.portrait = load(texture_path)
	
	vbox.add_child(q)


func play_exit() -> void:
	anim.play("hud_exit")


func display_warning(tx: String) -> void:
	$Panel/PopupPanel/Text.text = tx
	if warning_timer.is_stopped():
		warning_timer.start()
		var tween = create_tween()
		tween.tween_property($Panel/PopupPanel, "position:y", 268.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	else:
		warning_timer.start()


func _on_warning_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property($Panel/PopupPanel, "position:y", 198.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _on_reset_button_pressed() -> void:
	reset_level.emit()


func _on_next_button_pressed() -> void:
	next_level.emit()


func set_next_level(state: bool) -> void:
	$Panel/HBoxContainer/NextButton.visible = state
	$Panel/HBoxContainer/NextButton.disabled = not state

func set_handle_with_care_visibility(visibility: bool) -> void:
	handle_with_care.visible = visibility
