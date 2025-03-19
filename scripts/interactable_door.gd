extends Interactable

class_name InteractableDoor

@export var door_opened : bool = false
@export var door_locked : bool = false

func interacted(from_global_position : Vector3) -> void:
	currently_interactable = false
	if(door_opened):
		$AnimationPlayer.play_backwards("door_open_animation")
	else:
		$AnimationPlayer.play("door_open_animation")
	while $AnimationPlayer.is_playing():
		await get_tree().process_frame
	door_opened = !door_opened
	currently_interactable = true
