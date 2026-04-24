extends MeshInstance3D
class_name Door

var is_open := false


var audio_manager: AudioManager = null

func _ready() -> void:
	audio_manager = AudioManager.new()
	var unlock_door: AudioManagerPlus = AudioManagerPlus.new()
	unlock_door.stream = preload("res://assets/sounds/Door_Unlock(STEREO) (1).wav")
	unlock_door.volume_db = -20.0
	
	var lock_door: AudioManagerPlus = AudioManagerPlus.new()
	lock_door.stream = preload("res://assets/sounds/Door_Unlock(STEREO) (1).wav")
	lock_door.volume_db = -20.0
	
	add_child(audio_manager)
	audio_manager.add_plus("unlock_door", unlock_door)
	audio_manager.add_plus("lock_door", lock_door)


func toggle():
	is_open = !is_open
	print(name, "open:", is_open)
	
	var door_ref = get_node("../%s" % name)
	
	
	if is_open:
		door_ref.hide()
		door_ref.get_node("StaticBody3D/CollisionShape3D").disabled = true
		#material_override = load("res://assets/textures/unlocked.tres")
		audio_manager.play_plus("unlock_door")
	else:
		door_ref.show()
		door_ref.get_node("StaticBody3D/CollisionShape3D").disabled = false
		audio_manager.play_plus("unlock_door")
		#material_override = load("res://assets/textures/locked.tres")
