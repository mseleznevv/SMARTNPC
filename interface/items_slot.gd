extends ColorRect

@onready var item_icon = $ItemIcon
@onready var item_quantity = $LabelQuantity

func display_item(item):
	if item:
		print(item, " : ", item.icon, " : ", item.stackable)
		item_icon.texture = load("res://%s" % item.icon)
		item_quantity.text = str(item.quantity) if item.stackable else ""
	else:
		pass
		#item_icon.texture = null
		#item_quantity.text = ""
