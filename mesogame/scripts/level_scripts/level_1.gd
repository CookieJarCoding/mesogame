extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$HUD.create_character("Joanne", 0, 8,
		[Globals.item_types.APPAREL],
		[],
		"res://assets/characters/joanne.png"
	)
	Globals.level_counter = 1
