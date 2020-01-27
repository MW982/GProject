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
onready var animationPlayer = $HeadX/HeadY/Arms/AnimationPlayer

onready var TP = $TP
onready var cameraTP = $TP/CameraTP

onready var health_bar = get_node("../GUI/HealthBar")

onready var Weapon = $Weapon

var positionStatus = 1 # 1 - standing
					   # 2 - crouching
					   # 3 - crawling
onready var armsTranslation = $HeadX/HeadY/Arms.translation

var inventory = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var gui = get_node("../GUI");
	gui.updateInventory(inventory);
	get_node("../GUI/HealthBar")._on_max_health_updated(100)
	

func handlePositionChange(input):
	if positionStatus == 1 && input.is_key_pressed(KEY_C):
		positionStatus = 2
		return
	elif positionStatus == 1 && input.is_key_pressed(KEY_X):
		positionStatus = 3
		return
		
	if positionStatus == 2 && (input.is_key_pressed(KEY_C) || input.is_key_pressed(KEY_SPACE)):
		positionStatus = 1
		return
	elif positionStatus == 2 && input.is_key_pressed(KEY_X):
		positionStatus = 3
		return
		
	if positionStatus == 3 && input.is_key_pressed(KEY_X):
		positionStatus = 1
		return
	elif positionStatus == 3 && input.is_key_pressed(KEY_SPACE):
		positionStatus = 1
		return
	elif positionStatus == 3 && input.is_key_pressed(KEY_C):
		positionStatus = 2
		return
	

func _input(event):
#	if event.is_action_pressed("camera"): #za ustawienie C na kamere powinno być 10 lat łagru
#		camera.set_current(not camera.current)
#		print("Change view FP: %s, TP: %s" % [camera.current, cameraTP.current])
	
	if Input.is_key_pressed(KEY_SPACE) || Input.is_key_pressed(KEY_C) || Input.is_key_pressed(KEY_X):
		handlePositionChange(Input)

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
		get_node("HeadX/HeadY/Arms/Armature001/Skeleton/BulletEmitter").emit_bullet()

	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _physics_process(delta):
	var direction = Vector3()
	var head_basis = headX.get_global_transform().basis
	
	match(positionStatus):
		1:
			$CollisionShape.scale = Vector3(1,1,1)
			$HeadX/HeadY/Camera.translation = Vector3(0,0,-0.584)
			$HeadX/HeadY/Arms.translation = armsTranslation
		2:
			$CollisionShape.scale = Vector3(1.15,1.15,0.66)
			$HeadX/HeadY/Camera.translation = Vector3(0,0,-0.419)
			$HeadX/HeadY/Arms.translation = armsTranslation - Vector3(0,0,-0.584+0.419)
		3:
			$CollisionShape.scale = Vector3(3,1.5,0.5)
			$HeadX/HeadY/Camera.translation = Vector3(0,-0.427,-1.075)
			$HeadX/HeadY/Arms.translation = armsTranslation - Vector3(0,0.427,1.075-0.419)
	
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
		
	if Input.is_action_just_pressed("jump") && (positionStatus == 1): #and is_on_floor()
		velocity.y += jump_power 
		
	direction = direction.normalized()
	
	if Input.is_key_pressed(KEY_SHIFT) && Input.is_action_pressed("move_f"):
		velocity = velocity.linear_interpolate(direction*speed*2, acceleration*delta) #running only forward
	else:
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
			if inventory.size() >= 9:
				return
			inventory.append(body.duplicate())
			var gui = get_node("../GUI")
			gui.updateInventory(inventory)
			return


func damage(dmg):
	health -= dmg
	health_bar._on_health_updated(health)
	if health <= 0:
		print("end")
		#queue_free()


func heal(hp):
	health += hp
	if health > 100:
		health = 100
	health_bar._on_health_updated(health)