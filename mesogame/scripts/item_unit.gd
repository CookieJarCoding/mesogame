extends Node2D

class_name ItemUnit

signal packed(item: ItemUnit)
signal removed(item: ItemUnit)
signal hovered(item: ItemUnit)
signal unhovered(item: ItemUnit)

const CLICK_COOLDOWN = 10

@export var item_name: String = ""
@export var item_description: String = ""
@export var fragile: bool = false
@export var locked: bool = false
@export var soft: bool = false
@export var liquid_container: bool = false
@export var liquid_risk: bool = false
@export var wrapped: bool = false
@export var type: Globals.item_types = Globals.item_types.APPAREL

var draggable = false
var is_inside_dropable = false
var is_animating: bool = false
var in_grid: bool = false
var on_table: bool = false
var body_ref
var prev_body_ref
var offset: Vector2
var initialPos: Vector2
var starting_position: Vector2
var area_group: Node
var areas = []
var last_area_touched
var clicked
var released
var is_hovered_over
@export var placeholder: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_as_relative = false
	initialPos = global_position - get_parent().position
	starting_position = global_position - get_parent().position
	area_group = $AreaGroup
	areas = area_group.get_children()
	
	if locked:
		modulate = Color(0.0, 0.4, 0.6)
	#for area in areas:
		#if area is Area2D:
			#area.area_entered.connect(_on_tile_area_entered.bind(area))
			#area.area_exited.connect(_on_tile_area_exited)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			clicked = true
		elif event.is_action_released("click"):
			released = true

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if body_ref:
		#print(body_ref.global_position)
	
	#print(draggable)
	
	if locked:
		return
	
	is_inside_dropable = false
	on_table = false
	var drop_space = null

	## NOTE: Checks for any free space
	for area in areas:
		if area.has_overlapping_areas():
			var overlap = area.get_overlapping_areas()
			for o in overlap:
				if o is DropSpace and not o.occupied:
					drop_space = o
				
				if o.is_in_group("table"):
					on_table = true
			body_ref = drop_space
			is_inside_dropable = true
			last_area_touched = area
	
	## NOTE: Nullifies if any are occupied
	for area in areas:
		if area.has_overlapping_areas():
			var overlap = area.get_overlapping_areas()
			for o in overlap:
				if o is DropSpace and o.occupied:
					drop_space = null
					body_ref = null
		else:
			drop_space = null
			body_ref = null
	
	draggable = false
	for area in areas:
		area.draggable = false
	
	is_hovered_over = false
	
	for area in areas:
		if area is TileCollision and area.hovered_over:
			draggable = true
			is_hovered_over = true
	
	#if is_hovered_over:
		#hovered.emit(self)
	#else:
		#unhovered.emit(self)
	
	if draggable:
		for area in areas:
			area.draggable = true
	
	if draggable:
		if Input.is_action_just_pressed("click"):
		#if clicked:
			#clicked = not clicked
			if body_ref:
				initialPos = body_ref.global_position - last_area_touched.position
			else:
				initialPos = global_position
			offset = get_global_mouse_position() - global_position
			#print("Press")
			AudioLibrary.play_sfx(AudioLibrary.sfx.PLOP_PLOP)
			Globals.is_dragging = true
			removed.emit(self)
			#print("boop0")
		if Input.is_action_pressed("click") and Globals.is_dragging:
			global_position = get_global_mouse_position() - offset
			#print(global_position)
		elif Input.is_action_just_released("click"):
		#elif released:
			#released = not released
			AudioLibrary.play_sfx(AudioLibrary.sfx.PLOP_FLAT)
			Globals.is_dragging = false
			#print("Release")
			if is_inside_dropable and body_ref:
				#print(body_ref.global_position)
				#print(last_area_touched.position)
				#print(get_global_mouse_position())
				global_position = body_ref.global_position - last_area_touched.position
				var fully_inside = true
				var main = self.get_parent().get_parent()
				var box_top_left = main.get_child(4).get_child(0).global_position
				var grid_width = main.box_width*128+10*(main.box_width-1)
				var bounds = [box_top_left.x, box_top_left.x + grid_width, box_top_left.y, box_top_left.y + grid_width]
				for area in areas:
					if area.global_position.x < bounds[0] or area.global_position.x > bounds[1] or area.global_position.y < bounds[2] or area.global_position.y > bounds[3]:
						print("NO! BAD!")
						fully_inside = false
				if not fully_inside:
					global_position = initialPos
				else:
					packed.emit(self)
					print("boop2")
					in_grid = true
			elif on_table:
				global_position = get_parent().position + starting_position
				in_grid = false
				#print(get_parent().position, ", ", starting_position, ", ", global_position)
			else:
				global_position = initialPos
				if prev_body_ref:
					body_ref = prev_body_ref
				if in_grid:
					packed.emit(self)
					print("boop3")
					#print("boop2")


func _physics_process(_delta: float) -> void:
	var item_sprite = get_child(0)
	if item_sprite is Sprite2D:
		var rect: Rect2 = item_sprite.get_rect() * Transform2D(0, item_sprite.scale, 0, Vector2())
		rect.position += item_sprite.position
		if rect.has_point(to_local(get_global_mouse_position())):
			hovered.emit(self)
		else:
			unhovered.emit(self)
	#print(is_valid_liquid())
	#print(is_valid_fragile())

# call these either when the player is submitting or as a limitation when trying to place
func is_valid_liquid() -> bool:
	for area in areas:
		var collisions = area.collide()
		for opposite_item in collisions:
			if opposite_item != null and opposite_item is ItemUnit:
				if (self.liquid_risk and not self.wrapped and opposite_item.liquid_container) or (opposite_item.liquid_risk and not opposite_item.wrapped and self.liquid_container):
					#print(self.name,": ", "liquid risk!")
					return false
				else:
					pass
					# print(self.name,": ", "you're fine for now!")
		# print(self.name,": ", "not at risk of liquid!")
	return true

func is_valid_fragile() -> bool:
	if self.fragile and not self.wrapped:
		var surroundings = []
		for area in areas:
			var collisions = area.collide()
			for opposite_item in collisions:
				if opposite_item != null and opposite_item is ItemUnit:
					surroundings.append(opposite_item) 
					# NOTE: this is a note
					# WARNING: not optimized since this double counts, but yeah
				else:
					#print(self.name,": ","one of the surrounding cells is empty, so not all surroundings are soft")
					return false
		for item in surroundings:
			if not item.soft and item != self:
				#print(self.name,": ","one of the surrounding items is not soft, so invalid")
				return false
		#print(self.name,": ", "not at risk of breakage!")
	return true
