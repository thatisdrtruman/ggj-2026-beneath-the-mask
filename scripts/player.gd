extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var look_direction: Vector2
@onready var camera = $Camera3D
var camera_sens = 50

@export var masked:bool = false

signal mask_state_change(masked)


func _ready():
	$AnimationPlayer.connect("animation_started",animation_started)
	$AnimationPlayer.connect("animation_finished",animation_finished)
	$Mask_view.hide()
	$BeneathTheMaskMask.hide()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	_rotate_camera(delta)
	move_and_slide()

func _input(event: InputEvent):
	if event is InputEventMouseMotion: look_direction = event.relative * 0.01
	
	if Input.is_action_just_pressed("mask"):
		masked = not masked
		if masked:
			$BeneathTheMaskMask.show()
			$AnimationPlayer.play("mask_on")
			
		else:
			$AnimationPlayer.play("mask_off")
			$Mask_view.hide()

func animation_finished(animationName):
	print("ended",animationName)
	$BeneathTheMaskMask.hide()
	if animationName == "mask_on":
		$Mask_view.show()
	mask_state_change.emit(masked)
		
func animation_started(animationName):
	print("started",animationName)
	#if animationName == "mask_on":
	$BeneathTheMaskMask.show()

func _rotate_camera(delta: float,sens_mod: float = 1.0):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	look_direction += input
	rotation.y -=  look_direction.x * camera_sens * delta
	camera.rotation.x = clamp(camera.rotation.x - look_direction.y * camera_sens * sens_mod * delta,-1.0,1.0)

	look_direction = Vector2.ZERO
