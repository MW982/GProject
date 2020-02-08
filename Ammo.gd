extends Spatial

export var ammo = 0


func _ready():
	ammo = randi() % 10


func _on_Area_body_entered(body):
	body.ammo(ammo)
	queue_free()
