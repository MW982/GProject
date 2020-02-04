extends CheckBox


func _on_CheckBox_toggled(button_pressed):
	OS.set_window_fullscreen(not OS.is_window_fullscreen())
