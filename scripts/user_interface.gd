extends CanvasLayer

func show_interactable_item(interactable : Interactable) -> void:
	$InteractionArea/InteractionAreaText.text = get_interactable_text(interactable)
	$InteractionArea.show()

func hide_interactable_menu() -> void:
	$InteractionArea.hide()

func get_interactable_text(interactable : Interactable) -> String:
	if(interactable is PickupableItem):
		return "E" + Lang.UI_PLAYER_PICKUP_ITEM
	if(interactable is InteractableDoor):
		var open_or_close : String = Lang.UI_PLAYER_DOOR_OPEN
		if(interactable.door_opened == true):
			open_or_close = Lang.UI_PLAYER_DOOR_CLOSE
		return "E" + open_or_close 
	return "E to not handled."

func _on_player_interact_area_hud_show_text(text: String) -> void:
	$InteractionArea/InteractionAreaText.text = text
	$InteractionArea.show()
