extends KinematicBody

var xVelocity = 80
var menuAnimation = false
signal cloudFreed

func menuAnimationChoice(choice):
	menuAnimation = choice

func setObject(obj):
	$MeshInstance.mesh = obj
	
func setPosition(x,y,z):
	translate(Vector3(x,y,z))
	
func _ready():
	self.set_scale(Vector3(10,10,10))
	
func _process(delta):
	move_and_slide(-global_transform.basis.x * xVelocity * delta)
	#print(global_transform.origin.x)

func _on_Timer_timeout(): #every 7 seconds check if cloud is too far away to see
	if menuAnimation:
		if global_transform.origin.x < -110:
			print("heh")
			emit_signal("cloudFreed")
			queue_free()
	else:
		if global_transform.origin.x < -500:
			emit_signal("cloudFreed")
			queue_free()

