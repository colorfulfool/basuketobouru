extends RigidBody3D

@export var speed = 14
@export var jump_impulse = 5
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var start_position: Vector3
var start_rotation: Basis

func _ready() -> void:
	start_position = global_position
	start_rotation = global_transform.basis

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		global_position = start_position
		global_transform.basis = start_rotation
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		target_velocity = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x -= 1
	if Input.is_action_pressed("move_left"):
		direction.x += 1
	if Input.is_action_pressed("move_back"):
		direction.z -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z += 1
	if Input.is_action_just_released("jump"):
		linear_velocity.y = jump_impulse
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	# direction = global_transform.basis * direction
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	angular_velocity = target_velocity
