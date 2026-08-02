extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if OS.is_debug_build():
		$HUD.create_character("Nanang", 0, 1,
			[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.TOYS],
			"res://assets/characters/ange.png"
		)
		$HUD.create_character("Tito Albert", 0, 1,
			[Globals.item_types.APPAREL, Globals.item_types.TOYS],
			[Globals.item_types.LUXURY],
			"res://assets/characters/alfred.png"
		)
	else:
		$HUD.create_character("Nanang", 0, 13,
			[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.TOYS],
			"res://assets/characters/ange.png"
		)
		$HUD.create_character("Tito Albert", 0, 14,
			[Globals.item_types.APPAREL, Globals.item_types.TOYS],
			[Globals.item_types.LUXURY],
			"res://assets/characters/alfred.png"
		)
