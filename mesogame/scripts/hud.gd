extends CanvasLayer


const char_qouta: PackedScene = preload("res://scenes/character_quota.tscn")

@onready var vbox: VBoxContainer = $VBox


func create_character(char_name: String, score: int, quota: int, likes: Array, dislikes: Array) -> void:
	var q = char_qouta.instantiate()
	q.char_name = char_name
	q.score = score
	q.quota = quota
	q.likes.append_array(likes)
	q.dislikes.append_array(dislikes)
	vbox.add_child(q)
