extends Spatial


onready var lampObj = preload("res://Lamp.tscn")
onready var Cloud = preload("res://Cloud.tscn")

onready var Player = get_node("Player")

var cloudsObjects = [load("res://assets/Low poly clouds/Cloud_1.obj"),
				load("res://assets/Low poly clouds/Cloud_2.obj"),
				 load("res://assets/Low poly clouds/Cloud_3.obj"),
				  load("res://assets/Low poly clouds/Cloud_4.obj")]

var pos = Vector3()
var game_time = 0
var score = 0 

func _ready():
	var lamp = load("res://assets/lantern.obj")
	Player.connect("end",self,"gameover")
	
	for i in range(0,30):
		var cloud = Cloud.instance()
		cloud.setObject(cloudsObjects[randi()%4])
		cloud.setPosition(randi()%1000-500,250,randi()%1000-500)
		cloud.connect("cloudFreed",self,"addNewCloud")
		add_child(cloud)

#	for i in range(0,15):
#		var newobj = lampObj.instance()
#		pos = Vector3(randf()*10, -2, randf()*10)
#		newobj.setup("Lamp", Player, pos, lamp)
#		add_child(newobj)
	

func save_score(nick, wave, time, score):
	var file = File.new()
	var csv = "%s,%s,%s,%s" % [nick, wave, time, score] 
	file.open("res://scoreboard.dat", File.READ_WRITE)
	file.seek_end()
	file.store_line(csv)
	file.close()


func gameover():
	var wave = get_node("GUI/Wave").text
	var nick = "Bolek" 
	save_score(nick, wave, game_time, score)
	queue_free()
	get_tree().change_scene("res://Scoreboard.tscn")


func addNewCloud():
	var cloud = Cloud.instance()
	cloud.setObject(cloudsObjects[randi()%4])
	cloud.setPosition(450,250,randi()%1000-500)
	add_child(cloud)


func _on_Timer_timeout():
	game_time += 1


func score_up():
	score += 100
