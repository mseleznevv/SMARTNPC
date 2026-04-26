extends Node

var items

func _ready():
	items = read_from_JSON("res://data/items.json")
	# зачем здесь добавляется key в словарь если св-во key теперь дублирует ключ в словаре?
	for key in items.keys():
		items[key]["key"] = key
		
	#print(get_item_by_key("potion_to_cast_finding_all_selected_resource"))

func read_from_JSON(path: StringName):
	var file
	var data
	if (FileAccess.file_exists(path)):
		file = FileAccess.open(path, FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()
		return data
	else:
		printerr("File doesn't exist")


func get_item_by_key(key):
	if items && items.has(key):
		return items[key].duplicate(true)
	else:
		printerr("Item doesn`t exist")
