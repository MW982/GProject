extends Spatial

onready var player = get_node("/root/World/Player/")
onready var gui = get_node("/root/World/GUI")
onready var Wolf = preload("res://Enemy.tscn")
onready var globals = get_node("/root/global")

func _on_SpawnEvery2s_timeout():	
	if not gui.rest and globals.enemy <= 100:
		var newobj = Wolf.instance()
		var pos = get_translation()
		newobj.set_position(pos)
		get_tree().get_root().add_child(newobj)
		globals.enemy += 1 