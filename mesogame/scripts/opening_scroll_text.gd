extends MarginContainer

@onready var labelB = $VBoxContainer/Letter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_text(labelB)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scroll_text(scroll) -> void:
	scroll.visible_characters = 0
	var tween = get_tree().create_tween()
	tween.tween_property(scroll, "visible_characters", scroll.get_total_character_count(), 5)
	
		
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res:///scenes/main.tscn")
