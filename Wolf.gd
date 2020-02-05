extends KinematicBody

var gravity = 0.98

export var health = 100
export var speed = 10
export var acceleration = 10
export var dmg = 10

onready var player = get_node("/root/World/Player/")
onready var health_bar = $HealthBar3D
var velocity = Vector3()
var dir

var canAttack = true


func _ready():
	dir = Vector3(1,0,0)


func set_position(pos):
	#print('translation.x = %s' % translation.x)
	translation = pos 


func _physics_process(delta):
	aim(delta)
	velocity = velocity.linear_interpolate(dir.normalized()*speed, acceleration*delta)		
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)


func aim(delta):
	var t = get_transform()
	var rotTransform = t.looking_at(get_transform().origin+dir, Vector3.UP)
	var thisRotation = (Quat(rotTransform.basis).slerp(rotTransform.basis, 3*delta))
	set_transform(Transform(thisRotation, t.origin))


func _on_LookForPlayer_timeout():
	if is_instance_valid(player):
		var player_pos = player.get("translation")
		var direction = player_pos - translation 
		var distance = sqrt(direction.x*direction.x+direction.y*direction.y+direction.z*direction.z)
		
	#	dir = direction
	#	dir.y = 0
	#	if canAttack:
	#		player.damage(dmg)
	#		canAttack = false
		dir = direction
		dir.y = 0
		
		if distance < 5:
			if canAttack:
				player.damage(dmg)
				canAttack = false


func _on_ChangeDirection_timeout():
	dir = Vector3(randf()*20-10, -0.670, randf()*20-10)


func damage(dmg):
	health -= dmg
	speed += 5
	health_bar.update(health)
	if health <= 0:
		emit_signal("killed")
		queue_free()

func _on_AttackTimer_timeout(): #enemy can attack once per 1 second
	canAttack = true
