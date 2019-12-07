extends Control

onready var itemList = get_node("Panel/ItemList")

func updateInventory(inventory):
	print(inventory)
	for item in inventory:
		if !item.has("item_icon"):
			return
		var icon = ResourceLoader.load(item.item_icon)
		itemList.add_item("",icon,true)

func _ready():
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(40,40))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
	pass