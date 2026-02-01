extends Control

var audio_manager: AudioManager = null
var res = "res://assets/dialogues/dialogue_%s.dialogue" % state.current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_manager = AudioManager.new()
	var dialogue_theme: AudioManagerPlus = AudioManagerPlus.new()
	dialogue_theme.stream = preload("res://assets/sounds/msc_dialogue.ogg")
	dialogue_theme.volume_db = -6.0
	dialogue_theme.loop = true
	
	add_child(audio_manager)
	audio_manager.add_plus("dialogue", dialogue_theme)
	audio_manager.play_plus("dialogue")
	
	DialogueManager.show_dialogue_balloon(load(res), "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dialogue_ended(res):
	get_tree().change_scene_to_file("res://main.tscn")
	
