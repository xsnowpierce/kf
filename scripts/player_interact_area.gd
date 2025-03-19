extends Area3D

var current_interactable_items : Dictionary[Interactable, bool]
var parent : Player

func _ready() -> void:
	parent = get_parent().get_parent().get_parent()

func _process(delta: float) -> void:
	for interactable in current_interactable_items.keys():
		current_interactable_items[interactable] = interactable.currently_interactable
	update_hud_visibility()

func _on_area_entered(area: Area3D) -> void:
	if(area is Interactable):
		var interactable : Interactable = area
		current_interactable_items[interactable] = interactable.currently_interactable
		update_hud_visibility()

func _on_area_exited(area: Area3D) -> void:
	if(area is Interactable):
		var interactable : Interactable = area
		if(current_interactable_items.has(interactable)):
			current_interactable_items.erase(interactable)
			update_hud_visibility()

func update_hud_visibility() -> void:
	if(!current_interactable_items or current_interactable_items.is_empty()):
		parent.interact_area_hud_hide.emit()
		return
	var interactable_items : Array[Interactable] = get_interactable_items()
	if(!interactable_items or interactable_items.is_empty()):
		parent.interact_area_hud_hide.emit()
		return
	else:
		parent.interact_area_hud_show_interactable.emit(interactable_items[0])

func get_interactable_items() -> Array[Interactable]:
	var array : Array[Interactable]
	for key in current_interactable_items.keys():
		if(key.currently_interactable):
			array.append(key)
	return array

func _on_player_interact_pressed() -> void:
	if(!current_interactable_items or current_interactable_items.is_empty()):
		return
	handle_interaction(get_interactable_items()[0])

func handle_interaction(interactable : Interactable) -> void:
	if(interactable is PickupableItem):
		print(interactable.get_item().get_item_name())
	if(interactable is InteractableDoor):
		if(interactable.door_locked):
			parent.interact_area_hud_show_text.emit(Lang.UI_PLAYER_DOOR_LOCKED)
	interactable.interacted(parent.global_position)
