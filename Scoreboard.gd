extends Control

onready var grid = get_node("Panel/GridContainer")


func _ready():
	read_scoreboardfile()


func read_scoreboardfile():
	var file = File.new()
	var line 
	file.open("res://scoreboard.dat", File.READ)
	while !file.eof_reached():
		line = file.get_csv_line()
		for i in range(line.size()):
			add_score(str(line[i]))
	file.close()


func add_score(text):
	var label = Label.new()
	label.text = text
	grid.add_child(label)


func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")
