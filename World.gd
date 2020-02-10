extends Spatial


onready var lampObj = preload("res://Lamp.tscn")
onready var Cloud = preload("res://Cloud.tscn")
onready var med = preload("res://Med.tscn")
onready var ammo = preload("res://Ammo.tscn")

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

	for i in range(0,20):
		var newobj = lampObj.instance()
		pos = Vector3(randf()*2000-1000, -2, randf()*2000-1000)
		newobj.setup("Lamp", Player, pos, lampObj)
		add_child(newobj)


	for i in range(0,35):
		var newobj = med.instance()
		pos = Vector3(randf()*2000-1000, -2, randf()*2000-1000)
		newobj.set_position(pos)
		add_child(newobj)

	for i in range(0,35):
		var newobj = ammo.instance()
		pos = Vector3(randf()*2000-1000, -2, randf()*2000-1000)
		newobj.set_position(pos)
		add_child(newobj)


	

func save_score(nick, wave, time, score):
	var file = File.new()
	var csv = "%s,%s,%s,%s" % [nick, wave, time, score] 
	file.open("res://scoreboard.dat", File.READ_WRITE)
	file.seek_end()
	file.store_line(csv)
	file.close()


func gameover():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var wave = get_node("GUI/Wave").text
	var nick = get_node("/root/global").nickname
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
