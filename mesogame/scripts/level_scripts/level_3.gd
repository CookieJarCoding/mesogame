extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$HUD.create_character("Joanne", 0, 9,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	$HUD.create_character("Jay & Ethan", 0, 10,
		[Globals.item_types.TOYS, Globals.item_types.CONSUMABLES],
		[Globals.item_types.APPAREL],
		"res://assets/characters/jay_ethan.png"
	)
