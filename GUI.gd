extends Control

onready var itemList = get_node("Panel/ItemList")
var chosenItemSlot = 1

func updateInventory(inventory):
	print(inventory)
	if inventory.size() >= 9:
		return
#	for item in inventory:
#		print(item)
#		#if !item.has("item_icon"):
#		#	return
#		var icon = ResourceLoader.load(item.item_icon)
#		itemList.add_item("",icon,true)
#
	var inventoryLenght = inventory.size()
	if inventoryLenght==0:
		return
	var icon = ResourceLoader.load(inventory[inventoryLenght-1].item_icon)
	itemList.add_item("",icon,true)

func _ready():
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(40,40))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
func _input(event):
	for i in range(49,58):
		if Input.is_key_pressed(i):
			chosenItemSlot = i - 48 #ascii to int conversion
			itemList.select(chosenItemSlot-1,true)
			return
	
func _on_ItemList_item_selected(index):
	print(index)
	pass # Replace with function body.
