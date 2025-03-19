extends Node3D

class_name PlayerMovement

@export var character3d : CharacterBody3D
@export var player_input : PlayerInput
@export var SPEED : float = 4.0
@export var RUNNING_SPEED : float = 6
var current_speed : float 

func _process(delta: float) -> void:
	if not character3d.is_on_floor():
		character3d.velocity += character3d.get_gravity() * delta
		
	if(player_input.sprinting):
		current_speed = RUNNING_SPEED
	else:
		current_speed = SPEED
	
	var direction := (character3d.transform.basis * Vector3(player_input.move_direction.x, 0, player_input.move_direction.y)).normalized()
	if direction:
		character3d.velocity.x = direction.x * current_speed
		character3d.velocity.z = direction.z * current_speed
	else:
		character3d.velocity.x = move_toward(character3d.velocity.x, 0, current_speed)
		character3d.velocity.z = move_toward(character3d.velocity.z, 0, current_speed)

	character3d.move_and_slide()

func get_velocity_magnitude() -> float:
	var horiz_velocity = character3d.velocity
	horiz_velocity.y = 0
	return horiz_velocity.length()
