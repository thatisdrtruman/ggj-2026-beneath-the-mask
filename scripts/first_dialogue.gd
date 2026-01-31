extends Control

var res = load("res://assets/dialogues/dialogue_one.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	DialogueManager.show_dialogue_balloon(res, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dialogue_ended(res):
	print("dialogue ended")
	
