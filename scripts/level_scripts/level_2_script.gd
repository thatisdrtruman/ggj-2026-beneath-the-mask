extends Node3D

@onready var button_a = $Button_A/StaticBody3D
@onready var door_1 = $Door_1

@onready var button_b = $Button_B/StaticBody3D
@onready var door_2 = $Door_2

@onready var player := $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#button_a.pressed.connect(door_1.toggle)
	button_b.pressed.connect(door_2.toggle)
	
	#player.mask_state_change.connect(_on_mask_state_change)
	player.mask_state_change.connect(_on_player_mask_state_change)


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
		get_node("Button_B").show()
		$Button_B/StaticBody3D/CollisionShape3D.disabled = false
	else:
		get_node("Door_1").show()
		$Door_1/StaticBody3D/CollisionShape3D.disabled = false
		get_node("Button_B").hide()
		$Button_B/StaticBody3D/CollisionShape3D.disabled = true
