extends StaticBody3D

class_name Interactable

signal pressed

var audio_manager: AudioManager = null

func _ready() -> void:
	audio_manager = AudioManager.new()
	var button_pressed: AudioManagerPlus = AudioManagerPlus.new()
	button_pressed.stream = preload("res://assets/sounds/Button_Press_Scifi(STEREO).wav")
	button_pressed.volume_db = -20.0
	
	add_child(audio_manager)
	audio_manager.add_plus("button_pressed", button_pressed)

func get_interaction_text():
	return "interact"
	
func interact():
	print("interacted with %s" %name)
	audio_manager.play_plus("button_pressed")
	emit_signal("pressed")
	
