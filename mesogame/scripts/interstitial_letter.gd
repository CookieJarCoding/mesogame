extends MarginContainer

var delta_counter = 0.0
@onready var envelope_start_pos = $Envelope.position
var salutations: Array[String] = ["fill",
	"Lovelove, Nanang.",
	"Lovelove, Nanang",
	"Bagets mo, Joj",
	"See you soon, Nanang"
]
var letters: Array[String] = ["fill",
"""Hi! It’s your nanang again. I’m so happy you get to come back here to Batangas! Jay and Ethan have gotten so tall while you were away. Do you remember in 1971, they were only up to your stomach? Now they’re probably up to your shoulder already! Ang saya, ‘di ba? Maybe you could pack some toys and sweets for them in your balikbayan box? Promise, ‘di ko hahayaang kunin ulit ng Tita Kara mo yung mga padala mo. Alam mo naman kung paano siya, e.""",
"""I don’t know how, but your Tita Kara already knows you’re coming back. Siguro sinabi sa kanya ni Jay. O napagtanto niya nung inaayos ko ang kwarto mo. Anyway, she asked me if you were bringing back perfume and that one luxury bag brand she always wants more of even if she has a lot already. Manghiram ka kaya sa collection niya. Joanne misses you. Nahiya pa siyang humingi ng damit sa’yo. Sana magkasya lahat ng gusto nila! Yung akin, pag-isipan ko pa.""",
"""‘Sup. Si Joanne ‘to. Mikey called me, told me to ask you about getting that new model of instacam. Grabe siya kung makahingi, ‘no? Don’t forget about Tito Albert. He’s all about the polo brands. Although it’s been a while since I saw him with a new piece, so who knows? Alam mo naman na siguro yung akin. Doesn’t have to be masyadong japorms. Nanang says hi and asks for food and woodwork stuff. Miss ka na nila Jay at Ethan.""",
"""It’s your nanang. Everything’s arranged. We’ll wait for you at the airport. Everyone’s gonna be so happy. Lalo na ako. It’s been so long without you, and we have a lot to catch up on. I want to know everything. Kwentuhan tayo every day hanggang umalis ka, ha? You’re still the little girl who would always tell me about your day on my lap, and that barely changed even when you moved away. No matter how long you’re gone next time, we’ll still be here. We’ll always wait for you.""",
"""Oh? I think I forgot something..."""]

@onready var intro_label = $VBoxContainer/Intro
@onready var labelB = $VBoxContainer/Letter
@onready var salutations_label = $VBoxContainer/Salutations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0,0,0))
	intro_label.visible_characters = 0
	labelB.visible_characters = 0
	salutations_label.visible_characters = 0
	
	if Globals.level_counter == 4:
		labelB.text = letters[2] # CHECK
		salutations_label.text = salutations[2]
	elif Globals.level_counter == 7:
		labelB.text = letters[3]
		salutations_label.text = salutations[3]
	elif Globals.level_counter == 10:
		labelB.text = letters[4]
		salutations_label.text = salutations[4]
	elif Globals.level_counter == 12:
		labelB.text = letters[5]
		salutations_label.text = ""
	
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property($Envelope, "modulate:a", 1, 3)
	await tween.finished
	scroll_text(intro_label, 0.3)


func _process(delta: float) -> void:
	$Envelope.position.y = envelope_start_pos.y + 5 * sin(3 * delta_counter)
	delta_counter += delta


func scroll_text(scroll, duration: float) -> void:
	scroll.visible_characters = 0
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property(scroll, "visible_characters", scroll.get_total_character_count(), duration)
	tween.tween_property($DummyNode, "position", Vector2(1,1), 1.0)
	await tween.finished
	if scroll == intro_label:
		scroll_text(labelB, 10.0)
	elif scroll == labelB:
		scroll_text(salutations_label, 0.4)
	else:
		$StartButton.visible = true


func _on_start_button_pressed() -> void:
	CharacterQuota.characters.clear()
	get_tree().change_scene_to_file("res:///scenes/main.tscn")
