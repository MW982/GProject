extends Spatial

onready var Wolf = preload("res://Wolf.tscn")
onready var Obj = preload("res://PickableObj.tscn")
onready var Player = get_node("Player")

var pos = Vector3()

func _ready():
	for i in range(0,20):
		var newobj = Wolf.instance()
		pos = Vector3(randf()*202-101, 0, randf()*202-101)
		newobj.set_position(pos)
		add_child(newobj)
		
	for i in range(0,20):	
		var newobj = Obj.instance()
		pos = Vector3(randf()*202-101, 0, randf()*202-101)
		newobj.connect("item", Player, "update_inventory")
		newobj.setup("b1", pos)
		add_child(newobj)
