extends Camera3D

#nodes
@export_group("Nodes")

#Character root node.
@export var character : CharacterBody3D

#Head node.
@export var head : Node3D

@export var player_movement : PlayerMovement

#Settings.
@export_group("Settings")

@export var head_bob_speed : float = 1

#Mouse settings.
@export_subgroup("Mouse settings")

#mouse sensitivity.
@export_range(1, 100, 1) var mouse_sensitivity: int = 50

#pitch clamp settings.
@export_subgroup("Clamp settings")

#max pitch in degrees.
@export var max_pitch : float = 89

#min pitch in degrees.
@export var min_pitch : float = -89



func _ready():
	$AnimationPlayer.play("head_bob")
	Input.set_use_accumulated_input(false)

func _process(delta: float) -> void:
	$AnimationPlayer.speed_scale = player_movement.get_velocity_magnitude() * head_bob_speed

func _unhandled_input(event)->void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		if event is InputEventKey:
			if event.is_action_pressed("ui_cancel"):
				get_tree().quit()
		 
		if event is InputEventMouseButton:
			if event.button_index == 1:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		return
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		return
	
	if event is InputEventMouseMotion:
		aim_look(event)


#Handles aim look with the mouse.
func aim_look(event: InputEventMouseMotion)-> void:
	var viewport_transform: Transform2D = get_tree().root.get_final_transform()
	var motion: Vector2 = event.xformed_by(viewport_transform).relative
	var degrees_per_unit: float = 0.001
	
	motion *= mouse_sensitivity
	motion *= degrees_per_unit
	
	add_yaw(motion.x)
	add_pitch(motion.y)
	clamp_pitch()


#Rotates the character around the local Y axis by a given amount (In degrees) to achieve yaw.
func add_yaw(amount)->void:
	if is_zero_approx(amount):
		return
	character.rotate_object_local(Vector3.DOWN, deg_to_rad(amount))
	character.orthonormalize()


#Rotates the head around the local x axis by a given amount (In degrees) to achieve pitch.
func add_pitch(amount)->void:
	if is_zero_approx(amount):
		return
	
	head.rotate_object_local(Vector3.LEFT, deg_to_rad(amount))
	head.orthonormalize()


#Clamps the pitch between min_pitch and max_pitch.
func clamp_pitch()->void:
	if head.rotation.x > deg_to_rad(min_pitch) and head.rotation.x < deg_to_rad(max_pitch):
		return
	
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(min_pitch), deg_to_rad(max_pitch))
	head.orthonormalize()
