extends KinematicBody

var gravity = 0.98
export var speed = 10
export var acceleration = 10

onready var player_pos = get_node('/root/World/Player/').get('translation')
var velocity = Vector3()
var dir

var time = 0
var dist = 0
var delta_

func _ready():
	dir = Vector3()

func set_position(pos):
	#print('bolek %s' % translation.x)
	translation = pos 

func _physics_process(delta):
	delta_ = delta
	velocity = velocity.linear_interpolate(dir.normalized()*speed, acceleration*delta)		
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)

func _on_Timer_timeout():
	player_pos = get_node('/root/World/Player/').get('translation')
	var direction = player_pos - translation
	var l = sqrt(direction.x*direction.x+direction.y*direction.y+direction.z*direction.z)
	if l < 10:
		print("Player is close")
		dir = direction
		dir.y = 0

func _on_Timer2_timeout():
	dir = Vector3(randf()*20-10, 0, randf()*20-10)
