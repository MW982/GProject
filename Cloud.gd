extends KinematicBody

var xVelocity = 80
signal cloudFreed

func setObject(obj):
	$MeshInstance.mesh = obj
	
func setPosition(x,y,z):
	translate(Vector3(x,y,z))
	
func _ready():
	self.set_scale(Vector3(10,10,10))
	
func _process(delta):
	move_and_slide(-global_transform.basis.x * xVelocity * delta)

func _on_Timer_timeout(): #every 7 seconds check if cloud is too far away to see
	if global_transform.origin.x < -500:
		emit_signal("cloudFreed")
		queue_free()

