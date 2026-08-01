extends Node


const TILE_WIDTH: int = 128
const TILE_HEIGHT: int = 128
const DROP_SPACE: PackedScene = preload("res://scenes/drop_space.tscn")
const TEST_ITEM: PackedScene = preload("res://scenes/item_unit.tscn")
const BOX_DEFAULT_SCALE: Vector2 = Vector2(0.94, 1.0)

@export var box_width: int = 5
@export var box_height: int = 5

var items_in_grid = []

@onready var next_level_btn = $NextButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Box.scale = BOX_DEFAULT_SCALE * box_width / 5.0
	$TileBg.visible = true
	
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
	
	# func create_character(char_name: String, score: int, quota: int, likes: Array, dislikes: Array)
	## NOTE: Max two likes/dislikes
	$HUD.create_character("Joanne", 0, 10,
		[Globals.item_types.APPAREL],
		[]
	)
	#$HUD.create_character("Jay and Ethan", 0, 10,
		#[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		#[Globals.item_types.APPAREL]
	#)
	#$HUD.create_character("TEST", 0, 10,
		#[],
		#[]
	#)


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
	tally_scores()

func _on_item_removed(item: Node2D) -> void:
	items_in_grid.erase(item)
	tally_scores()

func tally_scores() -> void:
	for character in CharacterQuota.characters:
		character.score = 0
		for item in items_in_grid:
			if item.type in character.likes:
				character.score += 2
			elif item.type not in character.dislikes:
				character.score += 1
		character.update_score()

func check_win() -> bool:
	# TODO: Loop across the items_in_grid array, to check if the fragile and liquid risks are satisfied
	var winning = true
	for character in CharacterQuota.characters:
		if character.score < character.quota:
			winning = false
	return winning
		


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res:///scenes/interstitial_letter.tscn")
	Globals.level_counter +=1
	print(Globals.level_counter)
