extends Node2D

var draggable = false
var is_inside_dropable = false
var is_animating: bool = false
var body_ref
var prev_body_ref
var offset: Vector2
var initialPos: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(get_global_mouse_position(), " ", $Area/Collision.shape.size.x, " ", $Area/Collision.global_position)
	if draggable:
		if Input.is_action_just_pressed("click"):
			if body_ref:
				initialPos = body_ref.global_position
			else:
				initialPos = global_position
			offset = get_global_mouse_position() - global_position
			#print("Press")
			Globals.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Globals.is_dragging = false
			is_animating = true
			#print("Release")
			if is_inside_dropable:
				global_position = body_ref.global_position
			else:
				global_position = initialPos
				if prev_body_ref:
					body_ref = prev_body_ref
					#body_ref.occupied = true


func _physics_process(_delta: float) -> void:
	pass
		# print(body_ref.position)


func finish_snap() -> void:
	is_animating = false


func _on_area_2d_mouse_exited() -> void:
	if not Globals.is_dragging:
		draggable = false
		scale = Vector2(1, 1)


func _on_area_2d_mouse_entered() -> void:
	if not Globals.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_tile_area_entered(area: Area2D) -> void:
	if area.is_in_group("dropable") and area is DropSpace:
		if not area.occupied:
			is_inside_dropable = true
			area.modulate = Color(Color.REBECCA_PURPLE, 1)
			body_ref = area


func _on_tile_area_exited(area: Area2D) -> void:
	if area.is_in_group("dropable") and area is DropSpace:
		is_inside_dropable = false
		area.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
		prev_body_ref = body_ref
		body_ref = null
