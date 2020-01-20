extends Spatial

onready var Wolf = preload("res://Wolf.tscn")
onready var Obj = preload("res://PickableObj.tscn")
onready var lampObj = preload("res://Lamp.tscn")

onready var Player = get_node("Player")

var pos = Vector3()

func _ready():
	var lamp = load("res://assets/lantern.obj")
	var lion = load("res://assets/Lion.obj")
	
	for i in range(0,20):
		var newobj = Wolf.instance()
		pos = Vector3(randf()*202-101, 0, randf()*202-101)
		newobj.set_position(pos)
		add_child(newobj)
	
#	for i in range(0,15):
#		var newobj = lampObj.instance()
#		pos = Vector3(randf()*202-101, -2, randf()*202-101)
#		newobj.setup("Lamp", Player, pos, lamp)
#		add_child(newobj)
