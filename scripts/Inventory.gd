extends Node

signal items_changed(indexes)

var cols: int = 6
var rows: int = 6
var slots: int = cols * rows
var items: Array = [] # список словарей предметов | список предметов

func _ready():
	for i in range(slots):
		items.append({})
		
	# TEST
	items[0] = Global.get_item_by_key("rock")
	items[1] = Global.get_item_by_key("rock")
	items[2] = Global.get_item_by_key("rock")
	items[3] = Global.get_item_by_key("stick")
	items[4] = Global.get_item_by_key("stick")
	items[5] = Global.get_item_by_key("stick")
	items[6] = Global.get_item_by_key("stick")
	items[7] = Global.get_item_by_key("potion_to_cast_finding_all_selected_resource")
	items[8] = Global.get_item_by_key("potion_to_cast_finding_all_selected_resource")

# получает индекс списка предметов и словарь предмета
# return: возвращает предыдущий предмет на индексе index
# функция для установления предмета в ячейки инвенторя
func set_item(index, item): 
	var previos_item = items[index]
	items[index] = item
	items_changed.emit([index])
	return previos_item
	

# получает индекс предмета из списка предметов
# return: возвращает дубликат удаленного предмета
# функция удаляет предмет из списка предметов по индексу index 
func remove_item(index):
	var previos_item = items[index].duplicate()
	items[index].clear()
	items_changed.emit([index])
	return previos_item
	

# return: ничего не возвращает null
# функция получает индекс index предмета из списка предметов 
# и кол-во amount на которое нужно увеличить св-во quantity предмета 
# если сумма amount и quantity предмета меньше или равна нулю, 
# то этот предмет удаляется из инвенторя 
func set_item_quantity(index, amount):
	items[index].quantity += amount
	if items[index].quantity <= 0:
		remove_item(index)
	else:
		items_changed.emit([index])
	
