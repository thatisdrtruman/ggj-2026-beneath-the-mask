extends Control

var audio_manager: AudioManager = null
var res = load("res://assets/dialogues/dialogue_one.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_manager = AudioManager.new()
	var dialogue_theme: AudioManagerPlus = AudioManagerPlus.new()
	dialogue_theme.stream = preload("res://assets/sounds/msc_dialogue.ogg")
	dialogue_theme.volume_db = -6.0
	dialogue_theme.loop = true
	
	var dialogue_typing_sfx: AudioManagerPlus = AudioManagerPlus.new()
	dialogue_typing_sfx.stream = preload("res://assets/sounds/sfx_Dialogue_Typing.wav")
	
	add_child(audio_manager)
	audio_manager.add_plus("dialogue", dialogue_theme)
	audio_manager.add_plus("dialogue_typing", dialogue_typing_sfx)
	audio_manager.play_plus("dialogue")
	
	DialogueManager.show_dialogue_balloon(res, "start")
	DialogueManager.got_dialogue.connect(_on_got_dialogue)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_got_dialogue(line):
	audio_manager.play_plus("dialogue_typing")


func _on_dialogue_ended(res):
	get_tree().change_scene_to_file("res://main.tscn")
	# change to first level scene
	
