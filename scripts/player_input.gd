extends Node3D

class_name PlayerInput

var move_direction : Vector2
var sprinting : bool

signal interact_pressed()

func _process(delta: float) -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	sprinting = Input.is_action_pressed("sprint")
	if(Input.is_action_just_pressed("interact")):
		interact_pressed.emit()
