extends Node2D

# read pond data
const POND_DATA_PATH = "res://data/pond_data.json"

@onready var water: Polygon2D = $Water
@onready var boundary_shape: CollisionPolygon2D = $PondBoundary/BoundaryShape

func _ready() -> void:
	var vertices = _load_vertices()
	if vertices.is_empty():
		push_error("pond.gd: Failed to load pond vertices from " + POND_DATA_PATH)
		return
	water.polygon = vertices
	boundary_shape.polygon = vertices

func _load_vertices() -> PackedVector2Array:
	var file = FileAccess.open(POND_DATA_PATH, FileAccess.READ)
	
	if file == null:
		return PackedVector2Array()
		
	var json = JSON.new()
	var err = json.parse(file.get_as_text())
	file.close()
	
	if err != OK:
		return PackedVector2Array()
		
	var raw: Array = json.get_data()["vertices"]
	var result := PackedVector2Array()
	
	for v in raw:
		result.append(Vector2(v[0], v[1]))
		
	return result
