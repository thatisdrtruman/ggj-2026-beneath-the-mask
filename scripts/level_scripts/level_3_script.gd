extends Node3D

var audio_manager: AudioManager = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_manager = AudioManager.new()
	
	
	var door_opening: AudioManagerPlus = AudioManagerPlus.new()
	door_opening.stream = preload("res://assets/sounds/Level_3_Door_02.wav")
	
	add_child(audio_manager)
	audio_manager.add_plus("door_opening", door_opening)
	
	

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
	else:
		$"level 1 masked desk".hide()
		$"level 1 desk".show()
		$"level 1 desk/Desk/StaticBody3D/CollisionShape3D".disabled = false


func _on_collision_shape_3d_pressed() -> void:
	$DOOR/AnimationPlayer.play("gear_turn")
	audio_manager.play_plus("door_opening")
	print("Animation Played!")
