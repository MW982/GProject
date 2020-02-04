extends Spatial

onready var Wolf = preload("res://Wolf.tscn")
onready var Obj = preload("res://PickableObj.tscn")
onready var lampObj = preload("res://Lamp.tscn")
onready var Cloud = preload("res://Cloud.tscn")

onready var Player = get_node("Player")

var cloudsObjects = [load("res://assets/Low poly clouds/Cloud_1.obj"),
				load("res://assets/Low poly clouds/Cloud_2.obj"),
				 load("res://assets/Low poly clouds/Cloud_3.obj"),
				  load("res://assets/Low poly clouds/Cloud_4.obj")]

var pos = Vector3()

func _ready():
	var lamp = load("res://assets/lantern.obj")
	var lion = load("res://assets/Lion.obj")
	
#	for i in range(0,20):
#		var newobj = Wolf.instance()
#		pos = Vector3(randf()*202-101, 0, randf()*202-101)
#		newobj.set_position(pos)
#		add_child(newobj)
		
	for i in range(0,50):
		var cloud = Cloud.instance()
		cloud.setObject(cloudsObjects[randi()%4])
		cloud.setPosition(randi()%1000-500,100,randi()%1000-500)
		cloud.connect("cloudFreed",self,"addNewCloud")
		add_child(cloud)

	for i in range(0,15):
		var newobj = lampObj.instance()
		pos = Vector3(randf()*10, -2, randf()*10)
		newobj.setup("Lamp", Player, pos, lamp)
		add_child(newobj)
	
	

func addNewCloud():
	var cloud = Cloud.instance()
	cloud.setObject(cloudsObjects[randi()%4])
	cloud.setPosition(450,100,randi()%1000-500)
	add_child(cloud)
