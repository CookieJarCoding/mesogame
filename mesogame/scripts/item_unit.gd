extends Node2D

var draggable = false
var is_inside_dropable = false
var is_animating: bool = false
var body_ref
var prev_body_ref
var offset: Vector2
var initialPos: Vector2
var area_group: Node
var areas = []
var last_area_touched


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialPos = global_position
	area_group = $AreaGroup
	areas = area_group.get_children()
	for area in areas:
		if area is Area2D:
			area.area_entered.connect(_on_tile_area_entered.bind(area))
			area.area_exited.connect(_on_tile_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if body_ref:
		#print(body_ref.global_position)
	
	#is_inside_dropable = false
	#
	#for area in areas:
		#if area is Area2D:
			#if area.has_overlapping_areas():
				#print("Yes")
				#var overlap = area.get_overlapping_areas()
				#if overlap.size() > 0:
					#var drop_space = null
					#for o in overlap:
						#if o is DropSpace:
							#if not o.occupied:
								#drop_space = o
					#body_ref = drop_space
					#is_inside_dropable = true
					#last_area_touched = area
	
	draggable = false
	scale = Vector2(1, 1)
	
	for area in areas:
		if area is TileCollision and area.hovered_over:
			draggable = true
			scale = Vector2(1.05, 1.05)
	
	#if ($Area/Collision.global_position.x - $Area/Collision.shape.size.x/2 < get_global_mouse_position().x and get_global_mouse_position().x < $Area/Collision.global_position.x + $Area/Collision.shape.size.x/2) and ($Area/Collision.global_position.y - $Area/Collision.shape.size.y/2 < get_global_mouse_position().y and get_global_mouse_position().y < $Area/Collision.global_position.y + $Area/Collision.shape.size.y/2):
		#if not Globals.is_dragging:
			#draggable = true
			#scale = Vector2(1.05, 1.05)
	#else:
		#if not Globals.is_dragging:
			#draggable = false
			#scale = Vector2(1, 1)
	#print(get_global_mouse_position(), " ", $Area/Collision.shape.size.x, " ", $Area/Collision.global_position)
	if draggable:
		if Input.is_action_just_pressed("click"):
			if body_ref:
				initialPos = body_ref.global_position
			else:
				initialPos = global_position
			offset = get_global_mouse_position() - global_position
			#print("Press")
			Globals.is_dragging = true
		if Input.is_action_pressed("click") and Globals.is_dragging:
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Globals.is_dragging = false
			#is_animating = true
			#print("Release")
			if is_inside_dropable and body_ref:
				global_position = body_ref.global_position - last_area_touched.position
			else:
				global_position = initialPos
				if prev_body_ref:
					body_ref = prev_body_ref
					#body_ref.occupied = true


func _physics_process(_delta: float) -> void:
	pass
		# print(body_ref.position)


#func finish_snap() -> void:
	#is_animating = false


"""
func _on_area_2d_mouse_exited() -> void:
	if not Globals.is_dragging:
		draggable = false
		scale = Vector2(1, 1)


func _on_area_2d_mouse_entered() -> void:
	if not Globals.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)
"""


func _on_tile_area_entered(area: Area2D, id) -> void:
	if area.is_in_group("dropable") and area is DropSpace:
		if not area.occupied:
			is_inside_dropable = true
			area.modulate = Color(Color.REBECCA_PURPLE, 1)
			body_ref = area
			last_area_touched = id
			print(area.position, ": ", last_area_touched)


func _on_tile_area_exited(area: Area2D) -> void:
	if area.is_in_group("dropable") and area is DropSpace:
		is_inside_dropable = false
		area.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
		prev_body_ref = body_ref
		body_ref = null
