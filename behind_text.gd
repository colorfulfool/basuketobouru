extends Label3D

var has_moved = false
var has_jumped = false
var has_reset = false

func _ready() -> void:
	text = calculate_text()
	
func calculate_text():
	if !has_moved:
		return "WASD to move"
	if !has_jumped:
		return "SPACE to jump"
	if !has_reset:
		return "R to reset"
	return ""

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_forward") || Input.is_action_just_pressed("move_back") || Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
		has_moved = true
	if Input.is_action_just_pressed("jump"):
		has_jumped = true
	if Input.is_action_just_pressed("reset"):
		has_reset = true
		
	text = calculate_text()
