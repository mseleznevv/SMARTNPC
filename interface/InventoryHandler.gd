extends Control

@onready var drag_preview = $InventoryContainer/DragPreview

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		# не даем закрыть инвентарь пока взят предмет
		if visible && drag_preview.dragged_item: return
		
		visible = !visible
		if visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _ready():
	for item_slot in get_tree().get_nodes_in_group("items_slot"):
		var index = item_slot.get_index()
		item_slot.connect("gui_input", _on_ItemSlot_gui_input.bind(index))
		

func _on_ItemSlot_gui_input(event, index):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.pressed:
			if visible:
				drag_item(index)
				

func drag_item(index):
	var inventory_item = Inventory.items[index]
	var dragged_item = drag_preview.dragged_item
	
	print(dragged_item)
	
	# взять предмет
	if inventory_item && !dragged_item:
		drag_preview.dragged_item = Inventory.remove_item(index)
	# бросить предмет
	if !inventory_item && dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
	# свапнуть предмет
	if inventory_item && dragged_item:
		drag_preview.dragged_item = Inventory.set_item(index, dragged_item)
