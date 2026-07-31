extends Area2D


class_name DropSpace


var occupied: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_dragging:
		visible = true
	else:
		visible = false
	
	if get_overlapping_areas().size() > 0:
		occupied = true
		modulate = Color(0, 0, 0)
	else:
		occupied = false
		modulate = Color(Color.MEDIUM_PURPLE, 0.7)
