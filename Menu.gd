extends Control


func _ready():
	$Start_Menu/Button_Start.connect("pressed", self, "start_menu_pressed", ["start"])
	$Start_Menu/Button_Score.connect("pressed", self, "start_menu_pressed", ["scoreboard"])
	$Start_Menu/Button_Settings.connect("pressed", self, "start_menu_pressed", ["settings"])
	$Start_Menu/Button_Quit.connect("pressed", self, "start_menu_pressed", ["quit"])


func start_menu_pressed(button_name):
	if button_name == "start":
		get_tree().change_scene("res://World.tscn")
	elif button_name == "settings":
		if $Panel.is_visible():
			$Panel.visible = false
		else:
			$Panel.visible = true
	elif button_name == "scoreboard":
		get_tree().change_scene("res://Scoreboard.tscn")
	elif button_name == "quit":
		get_tree().quit()


func _on_Nickname_text_changed(new_text):
	get_node("/root/global").nickname = new_text
