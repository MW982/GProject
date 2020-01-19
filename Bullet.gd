extends KinematicBody


export var speed = 4500
export var damage = 20
export var KILL_TIME = 5

var timer = 0
var gravity = 0.98


func _physics_process(delta):
	var collision = move_and_collide(-global_transform.basis.y * speed * delta)
	if collision:
		if collision.collider.has_method("damage"):
			collision.collider.damage(damage)
		queue_free()
		
	timer += delta
	if timer >= KILL_TIME:
		queue_free()