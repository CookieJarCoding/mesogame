extends VBoxContainer

class_name CharacterQuota

static var characters = []

var char_name: String = ""
var score: int = 0
var quota: int = 0
var likes = []
var dislikes = []

@onready var score_label = $HBox/Score

func _ready() -> void:
	characters.append(self)

	$HBox/Name.text = char_name
	
	if likes.size() == 1:
		$Likes.text = "Likes: " + ets(likes[0])
	elif likes.size() == 2:
		$Likes.text = "Likes: " + ets(likes[0]) + ", " + ets(likes[1])
	else:
		$Likes.text = "Likes: "
	
	if dislikes.size() == 1:
		$Dislikes.text = "Dislikes: " + ets(dislikes[0])
	elif dislikes.size() == 2:
		$Dislikes.text = "Dislikes: " + ets(dislikes[0]) + ", " + ets(dislikes[1])
	else:
		$Dislikes.text = "Dislikes: "
	
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
	score_label.text = str(score) + "/ " + str(quota)
