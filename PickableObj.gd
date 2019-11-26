extends Spatial

export var items_name = "Base Item"
onready var prompt = $Prompt/Label

onready var sbody = get_node('StaticBody')
onready var player = get_node('/root/World/Player/')
onready var player_hand = get_node('/root/World/Player/Head/Weapon/RayCast')

var obj

signal item(items_name)

func setup(items_name_, pos_):
	items_name = items_name_
	set_position(pos_)

func set_position(pos):
	translation = pos

func _ready():
	prompt.text = "Click E to pick up %s" % items_name
	prompt.visible = false
	
func _process(delta):
	var player_pos = player.get('translation')
	var direction = player_pos - translation
	var dist = sqrt(direction.x*direction.x + direction.y*direction.y + direction.z*direction.z)
	if dist < 5 and player_hand.is_colliding():
		obj = player_hand.get_collider()
		prompt.visible = true
	else:
		prompt.visible = false

func _input(event):
	if event.is_action_pressed("pick_up") and prompt.visible and sbody.get_instance_id() == obj.get_instance_id():
		#print("Pick Up")
		emit_signal("item", items_name)
		queue_free()
