extends Label3D

var has_moved = false
var has_jumped = false
var has_reset = false
var using_gamepad = false

func _ready() -> void:
	text = calculate_text()

func calculate_text():
	if using_gamepad:
		if !has_moved:
			return "Left Stick to move"
		if !has_jumped:
			return "A to jump"
		if !has_reset:
			return "B to reset"
		return ""
	else:
		if !has_moved:
			return "WASD to move"
		if !has_jumped:
			return "SPACE to jump"
		if !has_reset:
			return "R to reset"
		return ""

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if !using_gamepad:
			using_gamepad = true
			text = calculate_text()
	elif event is InputEventKey or event is InputEventMouseButton or event is InputEventMouseMotion:
		if using_gamepad:
			using_gamepad = false
			text = calculate_text()

	if Input.is_action_just_pressed("move_forward") || Input.is_action_just_pressed("move_back") || Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
		has_moved = true
	if Input.is_action_just_pressed("jump"):
		has_jumped = true
	if Input.is_action_just_pressed("reset"):
		has_reset = true

	text = calculate_text()
