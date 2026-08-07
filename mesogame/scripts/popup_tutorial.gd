extends CanvasLayer

@onready var popup = $Popup
@export var tutorial_index: int = 0

func _ready() -> void:
	if not Globals.tutorials_seen[tutorial_index]:
		show_tutorial()
	else:
		visible = false

func _on_continue_pressed() -> void:
	Globals.tutorials_seen[tutorial_index] = true
	visible = false

func show_tutorial() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	visible = true
	popup.scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(popup, "scale", Vector2(1.0, 1.0), 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
