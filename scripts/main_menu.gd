extends Control

var audio_manager: AudioManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_manager = AudioManager.new()
	var main_menu_theme: AudioManagerPlus = AudioManagerPlus.new()
	main_menu_theme.stream = preload("res://assets/sounds/msc_main_menu.ogg")
	main_menu_theme.volume_db = -10.0
	main_menu_theme.loop = true
	
	var button_focus_sfx: AudioManagerPlus = AudioManagerPlus.new()
	button_focus_sfx.stream = preload("res://assets/sounds/sfx_Menu_Navigation_01.wav")
	button_focus_sfx.use_clipper = true
	button_focus_sfx.start_time = 0.0
	button_focus_sfx.end_time = 0.5
	
	var game_start_sfx: AudioManagerPlus = AudioManagerPlus.new()
	game_start_sfx.stream = preload("res://assets/sounds/sfx_Start_Game_Selection.wav")

	add_child(audio_manager)
	audio_manager.add_plus("main_menu", main_menu_theme)
	audio_manager.add_plus("button_focus", button_focus_sfx)
	audio_manager.add_plus("game_start", game_start_sfx)
	
	audio_manager.play_plus("main_menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	audio_manager.play_plus("game_start")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/first_dialogue.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_start_button_mouse_entered():
	audio_manager.play_plus("button_focus")


func _on_exit_button_mouse_entered():
	audio_manager.play_plus("button_focus")
