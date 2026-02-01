extends Node3D

var level: int = 1
var current_level_root:Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level_root= get_node("Level_root")
	_setup_level(current_level_root)
	#_load_level(level)


	
func _setup_level(level_root:Node):
	var exit = level_root.get_node_or_null("Level_exit")
	if exit:
		print('level has exit')
		exit.body_entered.connect(_on_exit_body_entered)

func _on_exit_body_entered(body):
	print(body)
	level += 1
	_load_level(level)


func _load_level(level_number:int):
	print('room change to ',level_number)
	if current_level_root:
		current_level_root.queue_free()
	var level_path = "res://Levels/level_%s.tscn" % level_number
	print(level_path)
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "Level_root"
	_setup_level(current_level_root)
	
