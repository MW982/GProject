extends Spatial

#onready var pObj = preload("res://PickableObj.tscn")
#onready var Player = get_node("/root/World/Player")


func setup(name_, player_, pos_, asset_):
	translation = pos_
	var pObj = get_node("PickableObj")
	pObj.connect("item", player_, "update_inventory")
	pObj.connect("item", self, "clear")
	pObj.setup(name_, Vector3(), asset_)

func clear(items_name):
	queue_free()
