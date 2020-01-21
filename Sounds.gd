extends HSlider


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), self.value)


func _on_Sounds_value_changed(value):
	print(self.value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), self.value)