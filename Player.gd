extends KinematicBody

export var health = 100
export var speed = 60
export var velocity = Vector3()
export var acceleration = 7
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3

var camera_x_rotation = 0

onready var headX = $HeadX
onready var camera = $HeadX/HeadY/Camera
onready var headY = $HeadX/HeadY
onready var animationPlayer = $HeadX/HeadY/Weapon/Hands/AnimationPlayer

onready var TP = $TP
onready var cameraTP = $TP/CameraTP

onready var Weapon = $Weapon

onready var Bullet = preload("res://Bullet.tscn")

var inventory = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var gui = get_node("../GUI");
	gui.updateInventory(inventory);


func _input(event):
	if event.is_action_pressed("camera"):
		camera.set_current(not camera.current)
		print("Change view FP: %s, TP: %s" % [camera.current, cameraTP.current])
	
	if event is InputEventMouseMotion:
		if camera.is_current():
			headX.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
			
			var x_delta = event.relative.y*mouse_sensitivity
			if camera_x_rotation + x_delta > -70 and camera_x_rotation + x_delta < 70: 
				headY.rotate_x(deg2rad(-x_delta))
				camera_x_rotation += x_delta
		else:
			if Input.is_mouse_button_pressed(BUTTON_MIDDLE):
				TP.rotate_x(event.relative.x*mouse_sensitivity)
	
	if event.is_action_pressed("shot"):
		animationPlayer.play("shooting")
		get_node("HeadX/HeadY/Weapon/Hands/Armature001/Skeleton/BulletEmitter").emit_bullet()
	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _physics_process(delta):
	var direction = Vector3()
	var head_basis = headX.get_global_transform().basis
	
	if Input.is_action_pressed("move_f"):
		direction -= head_basis.z
		if not animationPlayer.is_playing():
			animationPlayer.play("walkin")
	elif Input.is_action_pressed("move_b"):
		direction += head_basis.z
		if not animationPlayer.is_playing():
			animationPlayer.play("walkin")
	
	if Input.is_action_pressed("move_r"):
		direction += head_basis.x
		if not animationPlayer.is_playing():
			animationPlayer.play("walkin")

			
	elif Input.is_action_pressed("move_l"):
		direction -= head_basis.x
		if not animationPlayer.is_playing():
			animationPlayer.play("walkin")
		
	if Input.is_action_just_pressed("jump"): #and is_on_floor()
		velocity.y += jump_power 
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction*speed, acceleration*delta)
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)


func update_inventory(body):
	var inventoryLenght = inventory.size()
	if inventoryLenght == 0:
		inventory.append(body.duplicate())
		var gui = get_node("../GUI")
		gui.updateInventory(inventory)
		return
	
	for i in inventoryLenght:
		if inventory[i].name == body.items_name:
			print("item already in inventory!")
		else:
			inventory.append(body.duplicate())
			var gui = get_node("../GUI")
			gui.updateInventory(inventory)
			return


func damage(dmg):
	health -= dmg
	if health <= 0:
		print("end")
		queue_free()
