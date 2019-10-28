extends KinematicBody

export var speed = 20
export var acceleration = 7 
export var gravity = 0.98
export var jump_power = 30 
export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera

onready var TP = $TP
onready var cameraTP = $TP/CameraTP

var velocity = Vector3()
var camera_x_rotation = 0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action_pressed("camera"):
		camera.set_current(not camera.current)
		print('Change view FP: %s, TP: %s' % [camera.current, cameraTP.current])
	
	if event is InputEventMouseMotion:
		if camera.is_current():
			head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
			
			var x_delta = event.relative.y*mouse_sensitivity
			if camera_x_rotation + x_delta > -70 and camera_x_rotation + x_delta < 70: 
				camera.rotate_x(deg2rad(-x_delta))
				camera_x_rotation += x_delta
		else:
			#var l = sqrt(TP.translation.y*TP.translation.y + TP.translation.z*TP.translation.z)
			#cameraTP.rotate_x(deg2rad(-1))
			print('Position: %s %s %s' % [TP.translation.x, TP.translation.y, TP.translation.z])
			

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _physics_process(delta):
	var direction = Vector3()
	var head_basis = head.get_global_transform().basis
	
	if Input.is_action_pressed("move_f"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_b"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_r"):
		direction += head_basis.x
	elif Input.is_action_pressed("move_l"):
		direction -= head_basis.x
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power 
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction*speed, acceleration*delta)
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)
