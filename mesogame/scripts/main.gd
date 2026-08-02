extends Node2D


const TILE_WIDTH: int = 128
const TILE_HEIGHT: int = 128
const DROP_SPACE: PackedScene = preload("res://scenes/drop_space.tscn")
const TEST_ITEM: PackedScene = preload("res://scenes/item_unit.tscn")
const BOX_DEFAULT_SCALE: Vector2 = Vector2(0.94, 1.0)
const VIEWPORT_WIDTH: float = 960
const VIEWPORT_HEIGHT: float = 540
const TOOLTIP_OFFSET: Vector2 = Vector2(20,-60)

@export var box_width: int = 5
@export var box_height: int = 5

var items_in_grid = []
var item_explained
var table_pos: int = 0
var movement_ongoing: bool = false

@onready var next_level_btn = $HUD/NextButton
@onready var camera = $Camera
@onready var table = $PlaceholderTable
@onready var item_group = $ItemGroup
@onready var box = $Box


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Box.scale = BOX_DEFAULT_SCALE * box_width / 5.0
	$TileBG.visible = true
	$Table.visible = true
	
	for i in range(box_height):
		for j in range(box_width):
			var box_instance = DROP_SPACE.instantiate()
			var drop_space_center = Vector2(64, 64)
			var offset = Vector2(5 + box_width, 5 + box_width)
			box_instance.position = $Box/BoxTopLeftCorner.global_position + drop_space_center + offset + Vector2(i * (TILE_WIDTH + 10), j * (TILE_HEIGHT + 10)) + Vector2(3,0)
			add_child(box_instance)

	for item in $ItemGroup.get_children():
		item.packed.connect(_on_item_packed)
		item.removed.connect(_on_item_removed)
		item.hovered.connect(_on_item_hovered)
		item.unhovered.connect(_on_item_unhovered)
	
	# func create_character(char_name: String, score: int, quota: int, likes: Array, dislikes: Array)
	## NOTE: Max two likes/dislikes
	$HUD.create_character("Joanne", 0, 1,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	#$HUD.create_character("Jay and Ethan", 0, 10,
		#[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		#[Globals.item_types.APPAREL]
	#)
	#$HUD.create_character("TEST", 0, 10,
		#[],
		#[]
	#)

	if Globals.level_counter == 1 or Globals.level_counter == 9 or Globals.level_counter > 10:
		set_handle_with_care()


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("ui_left") and table_pos > 0 and not Input.is_action_pressed("click"):
		#table_pos -= 1
		#move_table(table_pos)
	#if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("ui_right") and not Input.is_action_pressed("click"):
		#table_pos += 1
		#move_table(table_pos)


func _physics_process(_delta: float) -> void:
	if check_win():
		next_level_btn.visible = true
		next_level_btn.disabled = false
	else: 
		next_level_btn.visible = false
		next_level_btn.disabled = true


func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true;


func _on_item_packed(item: Node2D) -> void:
	items_in_grid.append(item)
	item.reparent(box)
	#for k in item_group.get_children():
		#k.top_level = false
	#for i in items_in_grid:
		#i.top_level = true
	tally_scores()

func _on_item_removed(item: Node2D) -> void:
	items_in_grid.erase(item)
	item.reparent(item_group)
	#for k in item_group.get_children():
		#k.top_level = false
	#for i in items_in_grid:
		#i.top_level = true
	tally_scores()

func _on_item_hovered(item: Node2D) -> void:
	item_explained = item
	$ItemInformation.update(item)
	print($ItemInformation.get_child(0).name)

	$ItemInformation.get_child(0).global_position = Vector2(get_global_mouse_position().x*0.3+TOOLTIP_OFFSET.x,get_global_mouse_position().y*0.3+TOOLTIP_OFFSET.y)

func _on_item_unhovered(item: Node2D) -> void:
	if item == item_explained:
		$ItemInformation.visible = false

func tally_scores() -> void:
	for character in CharacterQuota.characters:
		character.score = 0
		for item in items_in_grid:
			if item.type in character.likes:
				character.score += 2
			elif item.type not in character.dislikes:
				character.score += 1
		character.update_score()
		print(character.score)

func check_win() -> bool:
	# TODO: Loop across the items_in_grid array, to check if the fragile and liquid risks are satisfied
	var winning = true
	for character in CharacterQuota.characters:
		if character.score < character.quota:
			winning = false
	return winning


func _on_next_button_pressed() -> void:
	Globals.level_counter += 1
	print(Globals.level_counter)

	# CHECK IF THIS WORKS SUCH THAT THESE ARE SPACED OUT EVERY THREE LEVELS
	if Globals.level_counter % 3 == 1:
		@warning_ignore("integer_division")
		if Globals.level_counter / 3 == 4: 
			get_tree().change_scene_to_file("res:///scenes/ending.tscn")
		else:
			get_tree().change_scene_to_file("res:///scenes/interstitial_letter.tscn")


func move_table(pos: int) -> void:
	var table_tween = create_tween()
	var ADJUSTED_VW: float = VIEWPORT_WIDTH * (1 / camera.zoom.x)
	table_tween.set_parallel(true)
	table_tween.connect("finished", declare_not_moving)
	table_tween.tween_property(item_group, "position", Vector2(-pos * ADJUSTED_VW, item_group.position.y), 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	#table_tween.tween_property(table, "position", Vector2(-pos * ADJUSTED_VW, table.position.y), 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

func declare_not_moving() -> void:
	movement_ongoing = false

func _on_left_pressed() -> void:
	if table_pos > 0 and not movement_ongoing:
		movement_ongoing = true
		table_pos -= 1
		move_table(table_pos)


func _on_right_pressed() -> void:
	if not movement_ongoing:
		movement_ongoing = true
		table_pos += 1
		move_table(table_pos)

func set_handle_with_care() -> void:
	for item in $ItemGroup.get_children():
		if not item.soft:
			item.fragile = true
