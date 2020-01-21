extends Spatial

export var healPower = 20

func _on_Area_body_entered(body):
	if body.health !=  100:
		body.heal(healPower)
		queue_free()
