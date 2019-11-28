extends Spatial
class_name Chunk

var meshInstance
var noise
var x
var z
var chunkSize
var shouldRemove = true

func _init(noise, x, z, chunkSize):
	self.noise = noise
	self.x = x
	self.z = z
	self.chunkSize = chunkSize
	
func _ready():
	generate_chunk()
	generate_water()
	
func generate_chunk():
	var planeMesh = PlaneMesh.new()
	planeMesh.size = Vector2(chunkSize,chunkSize)
	planeMesh.subdivide_depth = chunkSize * 0.5
	planeMesh.subdivide_width = chunkSize * 0.5
	
	planeMesh.material = preload("res://assets/terrain.material")
	
	var surfaceTool = SurfaceTool.new()
	var dataTool = MeshDataTool.new()
	surfaceTool.create_from(planeMesh,0)
	var arrayPlane = surfaceTool.commit()
	var error = dataTool.create_from_surface(arrayPlane,0)
	
	for i in range(dataTool.get_vertex_count()):
		var vertex = dataTool.get_vertex(i)
		
		vertex.y = noise.get_noise_3d(vertex.x + x, vertex.y, vertex.z + z) * 80
		dataTool.set_vertex(i,vertex)
		
	for s in range(arrayPlane.get_surface_count()):
		arrayPlane.surface_remove(s)
	
	dataTool.commit_to_surface(arrayPlane)
	surfaceTool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surfaceTool.create_from(arrayPlane,0)
	surfaceTool.generate_normals()
	
	meshInstance = MeshInstance.new()
	meshInstance.mesh = surfaceTool.commit()
	meshInstance.create_trimesh_collision()
	meshInstance.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_OFF
	add_child(meshInstance)
	
	
func generate_water():
	var planeMesh = PlaneMesh.new()
	planeMesh.size = Vector2(chunkSize,chunkSize)
	
	planeMesh.material = preload("res://assets/water.material")
	
	var meshInstance = MeshInstance.new()
	meshInstance.mesh = planeMesh
	
	add_child(meshInstance)
	
	
	
	
	