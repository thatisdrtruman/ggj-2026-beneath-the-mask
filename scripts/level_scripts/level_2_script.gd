extends Node3D

@onready var button_a = $Button_A/StaticBody3D
#@onready var door_1 = $Door_1

#@onready var button_b = $Button_B/StaticBody3D
@onready var door_2 = $Door_2

@onready var player := $Player

var audio_manager: AudioManager = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#button_a.pressed.connect(door_1.toggle)
	button_a.pressed.connect(door_2.toggle)
	
	#player.mask_state_change.connect(_on_mask_state_change)
	player.mask_state_change.connect(_on_player_mask_state_change)
	
	audio_manager = AudioManager.new()
	
	
	var office_ambience: AudioManagerPlus = AudioManagerPlus.new()
	office_ambience.stream = preload("res://assets/sounds/General_Ambience_01(vorbis).ogg")
	office_ambience.volume_db = -20.0
	office_ambience.loop = true
	
	var computer_ambience: AudioManagerPlus = AudioManagerPlus.new()
	computer_ambience.stream = preload("res://assets/sounds/Level_3_DataRoom_Amb (1).ogg")
	computer_ambience.volume_db = -25.0
	computer_ambience.loop = true
	
	var mask_drone: AudioManagerPlus = AudioManagerPlus.new()
	mask_drone.stream = preload("res://assets/sounds/2nd room drone.ogg")
	mask_drone.volume_db = -20.0
	mask_drone.loop = true
	
	
	

	add_child(audio_manager)
	audio_manager.add_plus("office_ambience", office_ambience)
	audio_manager.add_plus("computer_ambience", computer_ambience)
	audio_manager.add_plus("mask_drone", mask_drone)
	audio_manager.play_plus("office_ambience")
	audio_manager.play_plus("computer_ambience")

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
		get_node("Door_1").hide()
		$Door_1/StaticBody3D/CollisionShape3D.disabled = true
		get_node("Button_A").show()
		$Button_A/StaticBody3D/CollisionShape3D.disabled = false
		audio_manager.play_plus("mask_drone")
	else:
		get_node("Door_1").show()
		$Door_1/StaticBody3D/CollisionShape3D.disabled = false
		get_node("Button_A").hide()
		$Button_A/StaticBody3D/CollisionShape3D.disabled = true
		audio_manager.stop_plus("mask_drone")
