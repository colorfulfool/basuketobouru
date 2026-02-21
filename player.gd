extends RigidBody3D

@export var speed = 14
@export var jump_impulse = 5
@export var fall_acceleration = 75
@export var min_scale = 0.5

var target_velocity = Vector3.ZERO
var start_position: Vector3
var start_rotation: Basis
var start_scale: Vector3
var _reset_requested = false

func _ready() -> void:
	start_position = global_position
	start_rotation = global_transform.basis
	start_scale = $Pivot/GeoSphere014.scale

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		_reset_requested = true

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if _reset_requested:
		state.transform = Transform3D(start_rotation, start_position)
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
		target_velocity = Vector3.ZERO
		_reset_requested = false

func get_input_direction() -> Vector3:
	var joy_input = Input.get_vector("move_right", "move_left", "move_back", "move_forward")
	if joy_input != Vector2.ZERO:
		return Vector3(joy_input.x, 0, joy_input.y)
	
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x -= 1
	if Input.is_action_pressed("move_left"):
		direction.x += 1
	if Input.is_action_pressed("move_back"):
		direction.z -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z += 1
	return direction

func _physics_process(_delta: float) -> void:
	var direction = get_input_direction()
	
	if Input.is_action_pressed("jump"):
		if $Pivot/GeoSphere014.scale.z > min_scale:
			$Pivot/GeoSphere014.scale -= Vector3(0.05,0.05,0.05)
	if Input.is_action_just_released("jump"):
		$Pivot/GeoSphere014.scale = start_scale
		linear_velocity.y = jump_impulse
		
	var input_strength = direction.length()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	target_velocity.x = direction.x * speed * input_strength
	target_velocity.z = direction.z * speed * input_strength
	
	angular_velocity = target_velocity
