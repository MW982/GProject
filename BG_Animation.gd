extends Spatial

onready var Cloud = preload("res://Cloud.tscn")

var cloudsObjects = [load("res://assets/Low poly clouds/Cloud_1.obj"),
				load("res://assets/Low poly clouds/Cloud_2.obj"),
				 load("res://assets/Low poly clouds/Cloud_3.obj"),
				  load("res://assets/Low poly clouds/Cloud_4.obj")]
				
func _ready():
	for i in range(0,15):
		var cloud = Cloud.instance()
		cloud.menuAnimationChoice(true)
		cloud.setObject(cloudsObjects[randi()%4])
		cloud.setPosition(randi()%(300+1-120)+120,randi()%(80)+40,-100)
		cloud.connect("cloudFreed",self,"addNewCloud")
		add_child(cloud)

func addNewCloud():
	var cloud = Cloud.instance()
	cloud.menuAnimationChoice(true)
	cloud.setObject(cloudsObjects[randi()%4])
	cloud.setPosition(randi()%(300+1-120)+120,randi()%(80)+60,-100)
	add_child(cloud)