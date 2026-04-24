extends CharacterBody3D

@export var speed = 7
@export var gravity = 9.8
@export var mouse_sensitivity = 0.002

var direction = transform.basis

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	if input_dir != Vector2.ZERO:
		direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y)
		direction = direction.normalized()
	
		print(transform.basis, " : ", input_dir, " : ", direction)
	
		#$Pivot.basis = Basis.looking_at(direction)
	
	if input_dir != Vector2.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
