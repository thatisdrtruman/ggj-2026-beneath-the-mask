extends CollisionShape3D

var audio_manager: AudioManager = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_manager = AudioManager.new()
	
	
	var door_opening: AudioManagerPlus = AudioManagerPlus.new()
	door_opening.stream = preload("res://assets/sounds/Level_3_Door_02.wav")
	door_opening.volume_db = -10.0
	
	add_child(audio_manager)
	audio_manager.add_plus("door_opening", door_opening)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		audio_manager.play_plus("door_opening")
		$"../../../../../AnimationPlayer".play("gear_turn")
