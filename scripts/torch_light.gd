extends OmniLight3D

var player : Node3D

@export var max_distance : float = 16

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	var light_pos = global_position
	light_pos.y = 0
	var player_pos = player.global_position
	player_pos.y = 0
	if(light_pos.distance_to(player_pos) > max_distance):
		visible = false
	else:
		visible = true
