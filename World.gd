extends Spatial

onready var Wolf = preload("res://Wolf.tscn")

const chunkSize = 64
const chunkAmount = 16

var pos = Vector3()

var noise
var chunks = {}
var unreadyChunks = {}
var thread

func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 6
	noise.period = 80
	
	thread = Thread.new()
	
	for i in range(0,20):
		var newobj = Wolf.instance()
		pos = Vector3(randf()*202-101, 0, randf()*202-101)
		newobj.set_position(pos)
		add_child(newobj)

func add_chunk(x, z):
	var key = str(x) + "," + str(z)
	if chunks.has(key) or unreadyChunks.has(key):
		return
		
	if not thread.is_active():
		thread.start(self, "load_chunk",[thread, x, z])
		unreadyChunks[key] = 1
	
func load_chunk(array):
	var thread = array[0]
	var x = array[1]
	var z = array[2]
	
	var chunk = Chunk.new(noise, x * chunkSize, z * chunkSize, chunkSize)
	chunk.translation = Vector3(x * chunkSize, 0, z * chunkSize)
	
	call_deferred("load_done", chunk, thread)
	
func load_done(chunk, thread):
	add_child(chunk)
	var key = str(chunk.x / chunkSize) + "," + str(chunk.z / chunkSize)
	chunks[key] = chunk
	unreadyChunks.erase(key)
	thread.wait_to_finish()
	
func get_chunk(x, z):
	var key = str(x) + "," + str(z)
	if chunks.has(key):
		return chunks.get(key)
		
	return null

func _process(delta):
	update_chunks()
	clean_up_chunks()
	reset_chunks()
	
func update_chunks():
	var playerTranslation = $Player.translation
	var p_x = int(playerTranslation.x) / chunkSize
	var p_z = int(playerTranslation.z) / chunkSize
	
	for x in range(p_x - chunkAmount * 0.5, p_x + chunkAmount * 0.5):
		for z in range(p_z - chunkAmount * 0.5, p_z + chunkAmount * 0.5):
			add_chunk(x,z)
			var chunk = get_chunk(x, z)
			if chunk != null:
					chunk.shouldRemove = false
	pass
	
func clean_up_chunks():
	for key in chunks:
		var chunk = chunks[key]
		if chunk.shouldRemove:
			chunk.queue_free()
			chunks.erase(key)
	
func reset_chunks():
	for key in chunks:
		chunks[key].shouldRemove = true
	

	
	