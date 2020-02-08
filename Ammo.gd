extends Spatial

export var ammo = 0


func _ready():
	ammo = randi() % 10

func set_position(pos_):
	translation = pos_

func _on_Area_body_entered(body):
	if body.name == "Player":
		body.ammo(ammo)
	queue_free()
