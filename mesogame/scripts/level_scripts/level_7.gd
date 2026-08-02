extends Level


func _ready() -> void:
	super()
	$HUD.create_character("Tita Kara", 0, 10,
		[Globals.item_types.LUXURY, Globals.item_types.HANDICRAFTS],
		[Globals.item_types.CONSUMABLES, Globals.item_types.TOYS],
		"res://assets/characters/kara.png"
	)
	$HUD.create_character("Jay & Ethan", 0, 10,
		[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		[Globals.item_types.APPAREL],
		"res://assets/characters/jay_ethan.png"
	)
