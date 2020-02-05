extends HSlider


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), self.value)


func _on_MasterAudio_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), self.value)
