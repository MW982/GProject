extends KinematicBody

var gravity = 0.98
var speed = 10


onready var bole = get_node('/root/World/Player/').get('translation')
var velocity = Vector3()
var acceleration = 10

var direction = Vector3()

func set_position(pos):
	#print('bolek %s' % translation.x)
	translation = pos 

func _physics_process(delta):
	bole = get_node('/root/World/Player/').get('translation')
	#print('bole: %s' % bole)
	var direction = bole - translation
	var l = sqrt(direction.x*direction.x+direction.y*direction.y+direction.z*direction.z)
	#print(l)
	if l < 20:
		#print('Player is close')
		velocity = velocity.linear_interpolate(direction.normalized()*speed, acceleration*delta)
		velocity.y -= gravity
		velocity = move_and_slide(velocity, Vector3.UP)	
	
	#velocity = velocity.linear_interpolate(direction.normalized()*speed, acceleration*delta)
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)

