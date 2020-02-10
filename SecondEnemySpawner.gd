extends Spatial

onready var player = get_node("/root/World/Player/")
onready var gui = get_node("/root/World/GUI")
onready var enemy = preload("res://SecondEnemy.tscn")
onready var globals = get_node("/root/global")


func _on_Timer_timeout():
	if not gui.rest and globals.enemy <= 100:
		var newobj = enemy.instance()
		var pos = get_translation()
		newobj.set_position(pos)
		get_tree().get_root().add_child(newobj)
		globals.enemy += 1 
