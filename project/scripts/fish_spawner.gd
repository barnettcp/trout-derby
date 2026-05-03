extends Node

const FISH_DATA_PATH := "res://data/fish_data.json"
const PIXELS_PER_METER := 15.0

var _fish_scene := preload("res://scenes/fish.tscn")
var _active_fish: Array = []

var debug_mode: bool = false :
	set(value):
		debug_mode = value
		for fish in _active_fish:
			if is_instance_valid(fish):
				fish.set_debug_visible(value)

func spawn_all(pond_polygon: PackedVector2Array, limit: int = 0) -> void:
	var data_list := _load_fish_data()
	if data_list.is_empty():
		push_error("FishSpawner: No fish data loaded.")
		return

	# Separate trophies from standard fish
	var standard: Array = []
	var trophies: Array = []
	for data in data_list:
		if data["is_trophy"]:
			trophies.append(data)
		else:
			standard.append(data)

	# Pick one random trophy
	var spawn_list: Array = standard.duplicate()
	if not trophies.is_empty():
		spawn_list.append(trophies[randi() % trophies.size()])

	if limit > 0:
		spawn_list = spawn_list.slice(0, limit)

	for data in spawn_list:
		var fish: Node2D = _fish_scene.instantiate()
		get_parent().add_child(fish)
		fish.global_position = _random_point_in_polygon(pond_polygon)
		fish.setup(data, pond_polygon, _active_fish)
		fish.set_debug_visible(debug_mode)
		_active_fish.append(fish)

func get_fish() -> Array:
	return _active_fish

func remove_fish(fish: Node) -> void:
	_active_fish.erase(fish)

func _load_fish_data() -> Array:
	var file := FileAccess.open(FISH_DATA_PATH, FileAccess.READ)
	if file == null:
		return []
	var json := JSON.new()
	var err := json.parse(file.get_as_text())
	file.close()
	if err != OK:
		return []
	return json.get_data()

func _random_point_in_polygon(polygon: PackedVector2Array) -> Vector2:
	# Rejection sample within the bounding box until a point lands inside
	var min_x := polygon[0].x
	var max_x := polygon[0].x
	var min_y := polygon[0].y
	var max_y := polygon[0].y
	for v in polygon:
		min_x = minf(min_x, v.x)
		max_x = maxf(max_x, v.x)
		min_y = minf(min_y, v.y)
		max_y = maxf(max_y, v.y)
	var candidate := Vector2.ZERO
	for _i in range(1000):  # safety cap; pond is concave so this always converges fast
		candidate = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
		if Geometry2D.is_point_in_polygon(candidate, polygon):
			return candidate
	return polygon[0]  # fallback
