extends KinematicBody

var gravity = 0.98

export var health = 100
export var speed = 10
export var acceleration = 10
export var damage = 10

onready var player = get_node("/root/World/Player/")
var velocity = Vector3()

var dir
var delta_

func _ready():
	dir = Vector3()


func set_position(pos):
	#print('translation.x = %s' % translation.x)
	translation = pos 


func _physics_process(delta):
	delta_ = delta
	velocity = velocity.linear_interpolate(dir.normalized()*speed, acceleration*delta)		
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)


func _on_LookForPlayer_timeout():
	var player_pos = player.get("translation")
	var direction = player_pos - translation 
	var distance = sqrt(direction.x*direction.x+direction.y*direction.y+direction.z*direction.z)
	if distance < 20:
		dir = direction
		dir.y = 0
#		player.damage(damage)


func _on_ChangeDirection_timeout():
	dir = Vector3(randf()*20-10, 0, randf()*20-10)


func damage(dmg):
	health -= dmg
	speed += 5
	if health <= 0:
		queue_free()
