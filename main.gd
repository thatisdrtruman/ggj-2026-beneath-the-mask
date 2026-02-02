extends Node3D


#var level: int = 1
#var current_level_root:Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GameState.gameplay_state:
		0:
			print("gamestate 0")
			GameState.gameplay_state = 1
			_load_level(GameState.current_level)
		1:
			print("gamestate 1")
			_load_level(GameState.current_level)
		2:
			print("gamestate 2")
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _load_level(level_number:int):
	print('room change to ',level_number)
	if GameState.current_level_root:
		GameState.current_level_root.queue_free()
	var level_path = "res://Levels/level_%s.tscn" % level_number
	print(level_path)
	GameState.current_level_root = load(level_path).instantiate()
	add_child(GameState.current_level_root)
	GameState.current_level_root.name = "Level_root"
	_setup_level(GameState.current_level_root)


func _setup_level(level_root:Node):
	var exit = level_root.get_node_or_null("Level_exit")
	if exit:
		print('level has exit')
		exit.body_entered.connect(_on_exit_body_entered)


func _on_exit_body_entered(body):
	print(body)
	GameState.current_level += 1
	get_tree().change_scene_to_file("res://scenes/dialogue.tscn")
	# _load_level(GameState.current_level)
