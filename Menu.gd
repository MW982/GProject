extends Control


func _ready():
	$Start_Menu/Button_Start.connect("pressed", self, "start_menu_pressed", ["start"])
	$Start_Menu/Button_Online.connect("pressed", self, "start_menu_pressed", ["online"])
	$Start_Menu/Button_Quit.connect("pressed", self, "start_menu_pressed", ["quit"])

func start_menu_pressed(button_name):
	if button_name == "start":
		print("Start Game!")
		get_tree().change_scene("res://World.tscn")
	elif button_name == "online":
		print("Online Game!")
	elif button_name == "quit":
		get_tree().quit()