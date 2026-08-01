extends MarginContainer
var letters: Array[String] = ["fill",
"""Dear Toni,

Hi! It’s your nanang again. I’m so happy you get to come back here to Batangas! Jay and Ethan have gotten so tall while you were away. Do you remember in 1971, they were only up to your stomach? Now they’re probably up to your shoulder already! Ang saya, ‘di ba? Maybe you could pack some toys and sweets for them in your balikbayan box? Promise, ‘di ko hahayaang kunin ulit ng Tita Kara mo yung mga padala mo. Alam mo naman kung paano siya, e.



Lovelove, Nanang""",
"""Dear Toni,

I don’t know how, but your Tita Kara already knows you’re coming back. Siguro sinabi sa kanya ni Jay. O napagtanto niya nung inaayos ko ang kwarto mo. Anyway, she asked me if you were bringing back perfume and that one luxury bag brand she always wants more of even if she has a lot already. Manghiram ka kaya sa collection niya. Joanne misses you. Nahiya pa siyang humingi ng damit sa’yo. Sana magkasya lahat ng gusto nila! Yung akin, pag-isipan ko pa.



Lovelove, Nanang
""",
"""Dear Toni,

‘Sup. Si Joanne ‘to. Mikey called me, told me to ask you about getting that new model of instacam. Grabe siya kung makahingi, ‘no? Don’t forget about Tito Albert. He’s all about the polo brands. Although it’s been a while since I saw him with a new piece, so who knows? Alam mo naman na siguro yung akin. Doesn’t have to be masyadong japorms. Nanang says hi and asks for food and woodwork stuff. Miss ka na nila Jay at Ethan.



Bagets mo, Joj
""",
"""Dear Toni,

It’s your nanang. Everything’s arranged. We’ll wait for you at the airport. Everyone’s gonna be so happy. Lalo na ako. It’s been so long without you, and we have a lot to catch up on. I want to know everything. Kwentuhan tayo every day hanggang umalis ka, ha? You’re still the little girl who would always tell me about your day on my lap, and that barely changed even when you moved away. No matter how long you’re gone next time, we’ll still be here. We’ll always wait for you.



See you soon, Nanang
"""]
@onready var labelB = $VBoxContainer/Letter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_text(labelB)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.level_counter < 5:
		labelB.text = letters[Globals.level_counter]
	else:
		get_tree().quit()

func scroll_text(scroll) -> void:
	scroll.visible_characters = 0
	var tween = get_tree().create_tween()
	tween.tween_property(scroll, "visible_characters", scroll.get_total_character_count(), 5)
	
		
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_start_button_pressed() -> void:
	CharacterQuota.characters.clear()
	get_tree().change_scene_to_file("res:///scenes/main.tscn")
