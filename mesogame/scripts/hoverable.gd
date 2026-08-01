extends TextureButton


var starting_scale


func _ready() -> void:
	starting_scale = scale
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	scale = starting_scale * 1.05


func _on_mouse_exited() -> void:
	scale = starting_scale
