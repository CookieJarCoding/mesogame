extends Level

func _ready() -> void:
	super()
	$HUD.create_character("Jay & Ethan", 0, 28,
		[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		[Globals.item_types.APPAREL],
		"res://assets/characters/jay_ethan.png"
	)
	$HUD.create_character("Joanne", 0, 27,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	$HUD.create_character("Nanang", 0, 27,
		[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
		[Globals.item_types.TOYS],
		"res://assets/characters/ange.png"
	)
	
	Globals.level_counter = 12
