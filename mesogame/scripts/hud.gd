extends CanvasLayer


const char_quota: PackedScene = preload("res://scenes/character_quota.tscn")

@onready var vbox: VBoxContainer = $Panel/VBoxContainer/MarginContainer/ScrollContainer/VBox
@onready var anim = $Anim


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
