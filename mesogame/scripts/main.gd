extends Node2D

class_name Level

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
@export var max_table_pages: int = 1
@export var level_title: String = ""

var items_in_grid = []
var item_explained
var table_pos: int = 0
var movement_ongoing: bool = false
var finished_moving_items: bool = false

#@onready var next_level_btn = $HUD/HBoxContainer/NextButton
@onready var camera = $Camera
@onready var table = $PlaceholderTable
@onready var item_group = $ItemGroup
@onready var box = $Box
@onready var anim = $Anim
@onready var item_information = $ItemInformation
@onready var hud = $HUD


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Globals.load_data()
	if OS.is_debug_build():
		Globals.level_counter = 8
	
	
	print(Globals.level_counter)
	if Globals.level_counter >= 11:
		$Box/BoxTopLeftCorner.position = Vector2(1818 - 70 * (box_width - 5), 376 - 70 * (box_width - 5))
	else:
		$Box/BoxTopLeftCorner.position = Vector2(1818 - 70 * (box_width - 5), 316 - 70 * (box_width - 5))
	AudioLibrary.play_music(AudioLibrary.music.GAMEPLAY)
	
	finished_moving_items = false
	$Box.scale = BOX_DEFAULT_SCALE * box_width / 5.0
	$TileBG.visible = true
	$Table.visible = true
	$HUD/LevelTitle.text = level_title
	$HUD.connect("reset_level", _on_reset_button_pressed)
	$HUD.connect("next_level", _on_next_button_pressed)
	$HUD.flash_save_icon()
	
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
	
	
	for pre_placed_items in box.get_children():
		if pre_placed_items == box.get_child(0):
			continue
		items_in_grid.append(pre_placed_items)
		pre_placed_items.hovered.connect(_on_item_hovered)
		pre_placed_items.unhovered.connect(_on_item_unhovered)

	hud.set_handle_with_care_visibility(false)
	

	# func create_character(char_name: String, score: int, quota: int, likes: Array, dislikes: Array)
	### NOTE: Max two likes/dislikes
	#$HUD.create_character("Joanne", 0, 1,
		#[Globals.item_types.APPAREL],
		#[],
		#"res://assets/characters/joanne.png"
	#)
	#$HUD.create_character("Jay and Ethan", 0, 10,
		#[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		#[Globals.item_types.APPAREL]
	#)
	#$HUD.create_character("TEST", 0, 10,
		#[],
		#[]
	#)


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("ui_left") and table_pos > 0 and not Input.is_action_pressed("click"):
		#table_pos -= 1
		#move_table(table_pos)
	#if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("ui_right") and not Input.is_action_pressed("click"):
		#table_pos += 1
		#move_table(table_pos)


func _physics_process(_delta: float) -> void:
	$HUD.set_next_level(check_win())
	#print(items_in_grid)


func _on_settings_button_pressed() -> void:
	$SettingsMenu.visible = true;


func _on_item_packed(item: ItemUnit) -> void:
	if item not in items_in_grid:
		items_in_grid.append(item)
	item.reparent(box)
	
	## NOTE This code is held together by sticks and tape
	for i in range(5):
		await get_tree().process_frame
	
	if not item.is_valid_liquid():
		AudioLibrary.play_sfx(AudioLibrary.sfx.WRONG)
		$HUD.display_warning("Porous\nneeds DRY surroundings!")
	elif item.liquid_container:
		AudioLibrary.play_sfx(AudioLibrary.sfx.LIQUID)
	if not item.is_valid_fragile():
		AudioLibrary.play_sfx(AudioLibrary.sfx.WRONG)
		$HUD.display_warning("Fragile\nneeds SOFT surroundings!")
	elif item.fragile:
		AudioLibrary.play_sfx(AudioLibrary.sfx.FRAGILE)

	#for k in item_group.get_children():
		#k.top_level = false
	#for i in items_in_grid:
		#i.top_level = true
	tally_scores()

func _on_item_removed(item: ItemUnit) -> void:
	if item in items_in_grid:
		items_in_grid.erase(item)
	item.reparent(item_group)
	#for k in item_group.get_children():
		#k.top_level = false
	#for i in items_in_grid:
		#i.top_level = true
	tally_scores()

func _on_item_hovered(item: ItemUnit) -> void:
	#print("His")
	if movement_ongoing:
		return
	item_explained = item
	item_information.update(item)
	#print($ItemInformation.get_child(0).name)

	item_information.get_child(0).global_position = Vector2(
		clampf(get_global_mouse_position().x*camera.zoom.x+TOOLTIP_OFFSET.x, 0, 999999),
		clampf(get_global_mouse_position().y*camera.zoom.x+TOOLTIP_OFFSET.y, 0, 540.0 - 180.0)
		)

func _on_item_unhovered(item: ItemUnit) -> void:
	if item == item_explained:
		item_information.visible = false

func tally_scores() -> void:
	for character in CharacterQuota.characters:
		character.score = 0
		for item in items_in_grid:
			if not item.is_valid_liquid() or not item.is_valid_fragile():
				continue
			if item.type in character.likes:
				character.score += 2
			elif item.type not in character.dislikes:
				character.score += 1
		character.update_score()
		#print(character.score)

func check_win() -> bool:
	# DONE: Loop across the items_in_grid array, to check if the fragile and liquid risks are satisfied
	var winning = true
	for character in CharacterQuota.characters:
		if character.score < character.quota:
			winning = false
	for item in items_in_grid:
		if not item.is_valid_fragile() or not item.is_valid_liquid():
			winning = false

	return winning


func _on_next_button_pressed() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.QUOTA)
	anim.play("exit")
	hud.play_exit()


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
	if table_pos > 0 and finished_moving_items:
		if not movement_ongoing:
			AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
			movement_ongoing = true
			table_pos -= 1
			move_table(table_pos)
			if table_pos == 0:
				$HUD/Left.visible = false
			if table_pos < max_table_pages - 1:
				$HUD/Right.visible = true

func _on_right_pressed() -> void:
	if table_pos < max_table_pages - 1 and finished_moving_items:
		if not movement_ongoing:
			AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
			movement_ongoing = true
			table_pos += 1
			move_table(table_pos)
			if table_pos == max_table_pages - 1:
				$HUD/Right.visible = false
			if table_pos > 0:
				$HUD/Left.visible = true

func set_handle_with_care() -> void:
	hud.set_handle_with_care_visibility(true)
	for item in $ItemGroup.get_children():
		if not item.soft:
			item.fragile = true

func _on_reset_button_pressed() -> void:
	CharacterQuota.characters.clear()
	items_in_grid.clear()
	get_tree().call_deferred("reload_current_scene")


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "exit":
		Globals.level_counter += 1
		Globals.save()
		# CHECK IF THIS WORKS SUCH THAT THESE ARE SPACED OUT EVERY THREE LEVELS
		if Globals.level_counter == 1 or Globals.level_counter == 4 or Globals.level_counter == 7 or Globals.level_counter == 12 or Globals.level_counter == 14:
			get_tree().change_scene_to_file("res:///scenes/interstitial_letter.tscn")
		elif Globals.level_counter == 13:
			get_tree().change_scene_to_file("res:///scenes/ending.tscn")
		else:
			CharacterQuota.characters.clear()
			items_in_grid.clear()
			print(Globals.level_counter)
			get_tree().change_scene_to_packed(Globals.levels[Globals.level_counter])


func play_swoosh() -> void:
	AudioLibrary.play_sfx(AudioLibrary.sfx.SWOOSH)


func move_items_up() -> void:
	var tween = create_tween()
	tween.tween_property(item_group, "position:y", 0.0, 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	finished_moving_items = true



func move_items_down() -> void:
	var tween = create_tween()
	tween.tween_property(item_group, "position:y", 800.0, 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	finished_moving_items = true
