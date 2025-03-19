extends Resource

class_name Item

@export var _item_type : ITEM_TYPES.ITEM_TYPE
@export var _item_name : String
@export var _item_description : String

func get_item_type() -> ITEM_TYPES.ITEM_TYPE:
	return _item_type

func get_item_name() -> String:
	return _item_name

func get_item_description() -> String:
	return _item_description
