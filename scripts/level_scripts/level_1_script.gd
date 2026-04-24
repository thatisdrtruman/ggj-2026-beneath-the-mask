extends Node3D

var audio_manager: AudioManager = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_manager = AudioManager.new()
	
	
	var waiting_room_ambience: AudioManagerPlus = AudioManagerPlus.new()
	waiting_room_ambience.stream = preload("res://assets/sounds/Post_Office_Ambience.ogg")
	waiting_room_ambience.volume_db = -10.0
	waiting_room_ambience.loop = true
	
	var mask_drone: AudioManagerPlus = AudioManagerPlus.new()
	mask_drone.stream = preload("res://assets/sounds/1 room drone.ogg")
	mask_drone.volume_db = -20.0
	mask_drone.loop = true
	

	add_child(audio_manager)
	audio_manager.add_plus("waiting_room_ambience", waiting_room_ambience)
	audio_manager.add_plus("mask_drone", mask_drone)
	audio_manager.play_plus("waiting_room_ambience")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_outside_body_entered(body: Node3D) -> void:
	print('goodbye')
	get_tree().quit()
	
#func _on_level_exit_body_entered(body: Node3D) -> void:
	#print('next level')


func _on_player_mask_state_change(masked):
	print('the mask state has changed')
	if masked:
		$"level 1 masked desk".show()
		$"level 1 desk".hide()
		$"level 1 desk/Desk/StaticBody3D/CollisionShape3D".disabled = true
		audio_manager.play_plus("mask_drone")
	else:
		$"level 1 masked desk".hide()
		$"level 1 desk".show()
		$"level 1 desk/Desk/StaticBody3D/CollisionShape3D".disabled = false
		audio_manager.stop_plus("mask_drone")
