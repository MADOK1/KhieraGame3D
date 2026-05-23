extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var acceleration=0.15

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x,direction.x * SPEED,acceleration)
		velocity.z = lerp(velocity.z,direction.z * SPEED,acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration*0.75)
		velocity.z = move_toward(velocity.z, 0.0, acceleration*0.75)

	move_and_slide()
