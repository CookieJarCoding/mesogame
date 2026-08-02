extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$HUD.create_character("Joanne", 0, 1,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	$HUD.create_character("Jay & Ethan", 0, 1,
		[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		[Globals.item_types.APPAREL],
		"res://assets/characters/jay_ethan.png"
	)
	$HUD.create_character("Mikey", 0, 1,
		[Globals.item_types.TOYS, Globals.item_types.TECHNOLOGY],
		[Globals.item_types.CONSUMABLES],
		"res://assets/characters/mikey.png"
	)
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
	$HUD.create_character("Tita Kara", 0, 1,
		[Globals.item_types.LUXURY, Globals.item_types.HANDICRAFTS],
		[Globals.item_types.CONSUMABLES, Globals.item_types.TOYS],
		"res://assets/characters/kara.png"
	)
	$HUD.create_character("Toni", 0, 1,
		[],
		[],
		"res://assets/characters/toni_nurse.png"
	)
	
