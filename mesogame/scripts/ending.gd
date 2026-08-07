extends Node2D


var texts: Array[String] = [
	"""After taking way too long to pack, I finally headed out to the airport. I couldn't wait to see their faces!
	""",
	"I boarded the plane.",
	"While I flew, my home waited.",
	"...",
	"...",
	"...",
	"Three hours have since passed. I arrived! Hello, Philippines!",
	"Here's my bag.",
	"Over there, the boxes.",
	"For the family.",
	"For Tito Albert, Tita Kara, and Mikey.",
	"If they aren't here yet, maybe I can—"
]


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##AudioLibrary.play_music(AudioLibrary.music.TITLE)
	##$Timer.start()


func _on_quit_to_menu_button_pressed() -> void:
	Globals.level_counter = 0
	Globals.tutorials_seen = [
		false,
		false,
		false
	]
	Globals.has_finished = true
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	get_tree().change_scene_to_file("res:///scenes/mainmenu.tscn")
	


func _on_timer_timeout() -> void:
	$QuitToMenuButton.visible = true


func scroll_text(text_index: int, duration: float) -> void:
	var scroll = $CanvasLayer/Caption
	scroll.text = texts[text_index]
	scroll.visible_characters = 0
	var tween = get_tree().create_tween()
	tween.tween_property(scroll, "visible_characters", scroll.get_total_character_count(), duration)


func fade_in_picture() -> void:
	AudioLibrary.play_music(AudioLibrary.music.TITLE)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($CanvasLayer/Transition, "color", Color("#93c6db00"), 5.0)
	tween.tween_property($CanvasLayer/Caption, "self_modulate", Color(1, 1, 1, 0), 5.0)
	#$CanvasLayer/Transition.color = Color("#93c6db00")
	
