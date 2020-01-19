extends OptionButton


func _ready():
	self.add_item("1920 x 1080", 0)
	self.add_item("1600 x 900", 1)
	self.add_item("1024 x 800", 2)
	self.select(2)
	
	
func _on_OptionButton_item_selected(ID):
	if self.selected == 0:
		OS.set_window_size(Vector2(1920, 1080))
	elif self.selected == 1:
		OS.set_window_size(Vector2(1600, 900))
	elif self.selected == 2:
		OS.set_window_size(Vector2(1024, 800))
