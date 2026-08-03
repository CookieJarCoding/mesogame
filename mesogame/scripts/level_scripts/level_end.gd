extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$HUD.create_character("Toni", 0, 1,
		[],
		[],
		"res://assets/characters/toni_casual.png"
	)
