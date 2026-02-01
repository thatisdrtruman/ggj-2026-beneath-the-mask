extends CollisionShape3D

signal pressed

func get_interaction_text():
	return "interact"
	
func interact():
	print("interacted with %s" %name)
	emit_signal("pressed")
	$"../../../../../AnimationPlayer".play("gear_turn")
	
	
