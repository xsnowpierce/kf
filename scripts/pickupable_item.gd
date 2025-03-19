extends Interactable

class_name PickupableItem

@export var _item_held : Item
@export var _item_amount : int

func get_item() -> Item:
	return _item_held

func get_item_amount() -> int:
	return _item_amount

func interacted(from_global_position : Vector3) -> void:
	queue_free()
