extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	## NOTE: Debug
	if OS.is_debug_build():
		$HUD.create_character("Nanang", 0, 1,
			[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.TOYS],
			"res://assets/characters/ange.png"
		)
		$HUD.create_character("Jay & Ethan", 0, 1,
			[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
			[Globals.item_types.APPAREL],
			"res://assets/characters/jay_ethan.png"
		)
	## NOTE: Normal
	else:
		$HUD.create_character("Nanang", 0, 14,
			[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.TOYS],
			"res://assets/characters/ange.png"
		)
		$HUD.create_character("Jay & Ethan", 0, 18,
			[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
			[Globals.item_types.APPAREL],
			"res://assets/characters/jay_ethan.png"
		)
	
	Globals.level_counter = 5
