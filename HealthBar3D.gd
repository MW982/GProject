extends Sprite3D

onready var bar = $Viewport/HealthBar

func _ready():
	texture = $Viewport.get_texture()

func update(value):
	bar._on_health_updated(value)