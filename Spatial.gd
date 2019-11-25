extends Spatial


func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_MIDDLE):
			if event.relative.x >= 0:
				rotate_y(0.01)
			else:
				rotate_y(-0.01)
			if event.relative.y >= 0:
				get_node("GimbalX").rotate_x(0.01)
			else:
				get_node("GimbalX").rotate_x(-0.01)


func _ready():
	set_process_input(true)
