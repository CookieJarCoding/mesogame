extends Level

func _ready() -> void:
	super()
	$HUD.create_character("Mikey", 0, 22,
		[Globals.item_types.TOYS, Globals.item_types.TECHNOLOGY],
		[Globals.item_types.CONSUMABLES],
		"res://assets/characters/mikey.png"
	)
	$HUD.create_character("Tita Kara", 0, 21,
		[Globals.item_types.LUXURY, Globals.item_types.HANDICRAFTS],
		[Globals.item_types.CONSUMABLES, Globals.item_types.TOYS],
		"res://assets/characters/kara.png"
	)
	$HUD.create_character("Tito Albert", 0, 24,
		[Globals.item_types.APPAREL, Globals.item_types.TOYS],
		[Globals.item_types.LUXURY],
		"res://assets/characters/alfred.png"
	)
