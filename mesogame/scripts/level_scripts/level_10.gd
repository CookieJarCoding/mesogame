extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$HUD.create_character("Joanne", 0, 15,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	$HUD.create_character("Nanang", 0, 12,
			[Globals.item_types.CONSUMABLES, Globals.item_types.HANDICRAFTS],
			[Globals.item_types.TOYS],
			"res://assets/characters/ange.png"
	)
	
	set_handle_with_care()
