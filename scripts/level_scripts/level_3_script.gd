extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
