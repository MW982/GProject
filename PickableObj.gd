extends Spatial

export var items_name = "Base Item"
export var asset_path = ""
export var item_icon = "res://assets/lamp.png"

onready var prompt = get_node("Prompt/Label")
onready var sbody = get_node("../MeshInstance/StaticBody")
onready var player = get_node("/root/World/Player/")
onready var player_hand = get_node("/root/World/Player/HeadX/HeadY/Weapon/RayCast")

var obj

signal item(items_name)


func setup(items_name_, pos_, asset_=asset_path):
	items_name = items_name_
	set_position(pos_)


func set_position(pos):
	translation = pos


func _ready():
	prompt.text = "Click E to pick up %s" % items_name
	prompt.visible = false
	
	
func _process(delta):
	var player_pos = player.get("translation")
	var direction
	if translation == Vector3():
		direction = player_pos - get_node("..").translation
	else:
		direction = player_pos - translation
	var dist = sqrt(direction.x*direction.x + direction.y*direction.y + direction.z*direction.z)
	#print(dist, player_hand.is_colliding())
	if dist < 5 and player_hand.is_colliding():
		obj = player_hand.get_collider()
		prompt.visible = true
	else:
		prompt.visible = false


func _input(event):
	if event.is_action_pressed("pick_up") and prompt.visible and sbody.get_instance_id() == obj.get_instance_id():
		#print("Pick Up")
		emit_signal("item", self)
		queue_free()
