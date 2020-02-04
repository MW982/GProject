extends Spatial


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
		
	for i in range(0,30):
		var cloud = Cloud.instance()
		cloud.setObject(cloudsObjects[randi()%4])
		cloud.setPosition(randi()%1000-500,250,randi()%1000-500)
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
	cloud.setPosition(450,250,randi()%1000-500)
	add_child(cloud)
