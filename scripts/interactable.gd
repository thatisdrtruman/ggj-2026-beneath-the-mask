extends StaticBody3D

class_name Interactable

signal pressed

func get_interaction_text():
	return "interact"
	
func interact():
	print("interacted with %s" %name)
	emit_signal("pressed")
