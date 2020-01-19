extends Spatial

var bullet_scn = preload("res://Bullet.tscn")

func emit_bullet():
	var new_bullet = bullet_scn.instance()
	get_tree().get_root().add_child(new_bullet)
	new_bullet.global_transform = global_transform

