extends MeshInstance3D
class_name Door

var is_open := false

func toggle():
	is_open = !is_open
	print(name, "open:", is_open)
	
	var door_ref = get_node("../%s" % name)
	
	
	if is_open:
		door_ref.hide()
		door_ref.get_node("StaticBody3D/CollisionShape3D").disabled = true
		#material_override = load("res://assets/textures/unlocked.tres")
	else:
		door_ref.show()
		door_ref.get_node("StaticBody3D/CollisionShape3D").disabled = false
		#material_override = load("res://assets/textures/locked.tres")
