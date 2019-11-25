extends Spatial

onready var Wolf = preload("res://Wolf.tscn")

var pos = Vector3()

func _ready():
	for i in range(0,20):
		var newobj = Wolf.instance()
		pos = Vector3(randf()*202-101, 0, randf()*202-101)
		newobj.set_position(pos)
		add_child(newobj)
