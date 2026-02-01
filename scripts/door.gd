extends MeshInstance3D
class_name Door

var is_open := false

func toggle():
	is_open = !is_open
	print(name, "open:", is_open)

	if is_open:
		material_override = load("res://assets/textures/unlocked.tres")
	else:
		material_override = load("res://assets/textures/locked.tres")
