extends MarginContainer

var delta_counter = 0.0
@onready var envelope_start_pos = $Envelope.position
var salutations: Array[String] = ["fill",
	"Lovelove, Nanang.",
	"Bagets mo, Joj",
	"Lovelove, Nanang",
	"See you soon, Nanang"
]
var letters: Array[String] = ["fill",
"""Hi! It’s your nanang again. Hopefully this gets sent. Joanne taught me how to write these weeks ago pero kabado pa rin ako. Can’t help it, but I’m so happy you get to come back here to Batangas! Jay and Ethan have gotten so tall and energetic while you were away. Ang saya ng mga pinadala kong litrato, ‘di ba? Maybe you could pack some toys and sweets for them in your balikbayan box? Joanne didn’t ask for anything, pero alam mo naman siya pagdating sa damit. She misses you. We all do.""",
"""‘Sup. Si Joanne ‘to. Mikey called me, told me to ask you about getting that new model of instacam. Grabe siya kung makahingi, ‘no? Don’t forget about Tito Albert. He’s all about the polo brands. Although it’s been a while since I saw him with a new piece, so who knows? Alam mo naman na siguro yung akin. Doesn’t have to be masyadong japorms. Nanang says hi and asks for food and woodwork stuff. Miss ka na nila Jay at Ethan.""",
"""Hay! ‘Yang Tita Kara mo talaga! She somehow found out you’re already coming back, and sending balikbayan boxes! Now you’ll have to get even bigger boxes, kase alam mo na ‘yan. Even if she’s picky, she’ll pester us if she gets too little. Grabe, ‘no? They say you can’t be born already being bad, but after 50 years of living with her, I wonder how we stayed close as sisters. Kaya mo na siguro ‘yan! Tiwala ako sa’yo.""",
"""It’s your nanang. Everything’s arranged. We’ll wait for you at the airport. Marami rin palang humingi sa’yo! Hope it wasn’t that hard to fit them all. Maybe get just two big boxes. One for me and your siblings, and another for your Tita Kara, Tito Albert, and Mikey. Everyone’s gonna be so happy. Lalo na ako. It’s been so long without you, and we have a lot to catch up on. I want to know everything. Kwentuhan tayo every day hanggang umalis ka, ha? I’ll be here. I’m not going anywhere. I will always have time for you.""",
"""Oh? I think I forgot something..."""]

@onready var intro_label = $VBoxContainer/Intro
@onready var labelB = $VBoxContainer/Letter
@onready var salutations_label = $VBoxContainer/Salutations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioLibrary.play_music(AudioLibrary.music.LETTER)
	RenderingServer.set_default_clear_color(Color("92c5db"))
	intro_label.visible_characters = 0
	labelB.visible_characters = 0
	salutations_label.visible_characters = 0
	
	if Globals.level_counter < 4:
		labelB.text = letters[1]
		salutations_label.text = salutations[1]
	elif Globals.level_counter == 4:
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
		intro_label.text = ""
		salutations_label.text = ""
	
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property($Envelope, "modulate:a", 1, 3)
	await tween.finished
	scroll_text(intro_label, 0.3)
	AudioLibrary.play_sfx(AudioLibrary.sfx.PEN_WRITE)


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
	AudioLibrary.play_sfx(AudioLibrary.sfx.PAGE_FLIP)
	CharacterQuota.characters.clear()
	get_tree().change_scene_to_packed(Globals.levels[Globals.level_counter])
