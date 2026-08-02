extends VBoxContainer

class_name CharacterQuota

static var characters = []

var char_name: String = ""
var score: int = 0
var quota: int = 0
var likes = []
var dislikes = []
var portrait

@onready var score_label = $M/HBox/Score
@onready var likes_label = $MarginContainer/Likes
@onready var dislikes_label = $MarginContainer2/Dislikes

func _ready() -> void:
	characters.append(self)

	$M/HBox/Name.text = char_name
	$Portrait.texture = portrait
	
	if likes.size() == 1:
		likes_label.text = "Likes: " + ets(likes[0])
	elif likes.size() == 2:
		likes_label.text = "Likes: " + ets(likes[0]) + ", " + ets(likes[1])
	else:
		likes_label.text = "Likes: "
	
	if dislikes.size() == 1:
		dislikes_label.text = "Dislikes: " + ets(dislikes[0])
	elif dislikes.size() == 2:
		dislikes_label.text = "Dislikes: " + ets(dislikes[0]) + ", " + ets(dislikes[1])
	else:
		dislikes_label.text = "Dislikes: "
	
	update_score()


## NOTE: Enum To String
func ets(enum_val) -> String:
	if enum_val == Globals.item_types.LUXURY:
		return "Luxury"
	elif enum_val == Globals.item_types.CONSUMABLES:
		return "Consumables"
	elif enum_val == Globals.item_types.TOYS:
		return "Toys"
	elif enum_val == Globals.item_types.HANDICRAFTS:
		return "Handicrafts"
	elif enum_val == Globals.item_types.PRACTICAL:
		return "Practical"
	elif enum_val == Globals.item_types.APPAREL:
		return "Apparel"
	elif enum_val == Globals.item_types.TECHNOLOGY:
		return "Technology"
	
	return ""


func update_score() -> void:
	score_label.text = str(score) + " / " + str(quota)
