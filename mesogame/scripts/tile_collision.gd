extends Area2D


class_name TileCollision


var hovered_over: bool = false
var draggable: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ($Collision.global_position.x - $Collision.shape.size.x/2 < get_global_mouse_position().x and get_global_mouse_position().x < $Collision.global_position.x + $Collision.shape.size.x/2) and ($Collision.global_position.y - $Collision.shape.size.y/2 < get_global_mouse_position().y and get_global_mouse_position().y < $Collision.global_position.y + $Collision.shape.size.y/2):
		if not Globals.is_dragging:
			hovered_over = true
			#draggable = true
			#scale = Vector2(1.05, 1.05)
	else:
		if not Globals.is_dragging:
			hovered_over = false
			#draggable = false
			#scale = Vector2(1, 1)
