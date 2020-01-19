extends CheckBox


func _on_Borderless_toggled(button_pressed):
	OS.set_borderless_window(not OS.get_borderless_window())
