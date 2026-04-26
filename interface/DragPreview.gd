extends Control

@onready var item_icon = $Item/ItemIcon
@onready var item_quantity = $Item/LabelQuantity

var dragged_item = {} : set = set_dragged_item

func _process(delta: float) -> void:
	if dragged_item:
		position = get_global_mouse_position()
		

func set_dragged_item(item):
	dragged_item = item
	if dragged_item:
		item_icon.texture = load("res://%s" % dragged_item.icon)
		item_quantity.text = str(item.quantity) if dragged_item.stackable else ""
