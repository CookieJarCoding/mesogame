extends Level

func _ready() -> void:
	super()
	if OS.is_debug_build():
		$HUD.create_character("Mikey", 0, 0,
			[Globals.item_types.TOYS, Globals.item_types.TECHNOLOGY],
			[Globals.item_types.CONSUMABLES],
			"res://assets/characters/mikey.png"
		)
		$HUD.create_character("Tita Kara", 0, 0,
			[Globals.item_types.LUXURY, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.CONSUMABLES, Globals.item_types.TOYS],
			"res://assets/characters/kara.png"
		)
		$HUD.create_character("Tito Albert", 0, 0,
			[Globals.item_types.APPAREL, Globals.item_types.TOYS],
			[Globals.item_types.LUXURY],
			"res://assets/characters/alfred.png"
		)
	else:
		$HUD.create_character("Mikey", 0, 21,
			[Globals.item_types.TOYS, Globals.item_types.TECHNOLOGY],
			[Globals.item_types.CONSUMABLES],
			"res://assets/characters/mikey.png"
		)
		$HUD.create_character("Tita Kara", 0, 18,
			[Globals.item_types.LUXURY, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.CONSUMABLES, Globals.item_types.TOYS],
			"res://assets/characters/kara.png"
		)
		$HUD.create_character("Tito Albert", 0, 23,
			[Globals.item_types.APPAREL, Globals.item_types.TOYS],
			[Globals.item_types.LUXURY],
			"res://assets/characters/alfred.png"
		)
	
	set_handle_with_care()
	
	Globals.level_counter = 13
	
	tally_scores()
