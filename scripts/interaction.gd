extends RayCast3D

var current_collider

@onready var interaction_raycast : RayCast3D #Make sure the node reference is set correctly
@onready var interaction_label = $"../../Control/InteractionLabel"

func _ready():
	enabled = true
	#add_exception(get_parent())
	set_interaction_text("")

func _process(_delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if text == "" or text==null:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		var _action_0 = InputMap.get_actions()[0] 
		var action_0_events = InputMap.action_get_events( "interact" )
		var action_0_event_0 = action_0_events[0]
		var _interact_key = OS.get_keycode_string( action_0_event_0.keycode )
		interaction_label.set_text("Press E to Interact")
		interaction_label.set_visible(true)
