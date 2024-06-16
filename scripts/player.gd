extends CharacterBody3D
@onready var head = $head

var FULL_SCREEN = true
@export var SPEED = 5.0
var RUNNING_SPEED = 8.0
var WALKING_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * MOUSE_SENS)) 
		head.rotate_x(-deg_to_rad(event.relative.y * MOUSE_SENS))
		
	if Input.is_action_just_pressed("escape"):
		if FULL_SCREEN:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			FULL_SCREEN = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			FULL_SCREEN = true

		

func _physics_process(delta):
	
	if Input.is_action_pressed("sprint"):
			SPEED = RUNNING_SPEED
	else:
		SPEED = WALKING_SPEED

	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
