extends Node2D

# --- Fish data (set by spawner) ---
var fish_id: int = 0
var species: String = ""
var length: float = 0.0
var weight: float = 0.0
var is_trophy: bool = false
var trophy_name: String = ""
var trophy_title: String = ""
var move_interval: float = 10.0
var bite_interval: float = 5.0

# --- Movement state ---
const PIXELS_PER_METER := 15.0
const MOVE_DIST_MIN := 0.3 * PIXELS_PER_METER
const MOVE_DIST_MAX := 1.0 * PIXELS_PER_METER
const TURN_ANGLE_MAX := deg_to_rad(110.0)
const REPULSION_RADIUS := 2.0 * PIXELS_PER_METER
const REPULSION_STRENGTH := 0.5

var _heading: float = 0.0  # radians
var _pond_polygon: PackedVector2Array = []
var _all_fish: Array = []  # filled by spawner for anti-crowding

# --- Bite state ---
var _bobber: Node2D = null  # set by player when cast lands

@onready var move_timer: Timer = $MoveTimer
@onready var bite_timer: Timer = $BiteTimer
@onready var debug_dot: Sprite2D = $DebugDot

signal bite_triggered(fish: Node2D)

func setup(data: Dictionary, pond_polygon: PackedVector2Array, all_fish: Array) -> void:
	fish_id = data["id"]
	species = data["species"]
	length = data["length"]
	weight = data["weight"]
	is_trophy = data["is_trophy"]
	
	var raw_name = data.get("trophy_name")
	trophy_name = raw_name if raw_name != null else ""
	
	var raw_title = data.get("trophy_title")
	trophy_title = raw_title if raw_title != null else ""
	
	move_interval = data["movement_tick_interval"]
	bite_interval = data["bite_check_interval"]
	_pond_polygon = pond_polygon
	_all_fish = all_fish
	_heading = randf() * TAU

	move_timer.wait_time = move_interval
	move_timer.start()
	bite_timer.wait_time = bite_interval
	bite_timer.start()

	_update_debug_color()

func _ready() -> void:
	move_timer.timeout.connect(_on_move_tick)
	bite_timer.timeout.connect(_on_bite_tick)

# --- Movement ---

func _on_move_tick() -> void:
	var repulsion := _calc_repulsion()
	var turn: float = randf_range(-TURN_ANGLE_MAX, TURN_ANGLE_MAX)
	_heading += turn

	var move_vec := Vector2.RIGHT.rotated(_heading)
	if repulsion.length() > 0.01:
		move_vec = (move_vec + repulsion * REPULSION_STRENGTH).normalized()
		_heading = move_vec.angle()

	var dist: float = randf_range(MOVE_DIST_MIN, MOVE_DIST_MAX)
	var candidate: Vector2 = global_position + move_vec * dist

	if Geometry2D.is_point_in_polygon(candidate, _pond_polygon):
		global_position = candidate
	else:
		# Reflect — try the opposite heading
		_heading += PI
		var reflected: Vector2 = global_position + Vector2.RIGHT.rotated(_heading) * dist
		if Geometry2D.is_point_in_polygon(reflected, _pond_polygon):
			global_position = reflected
		# If both fail (very edge case), stay put this tick

func _calc_repulsion() -> Vector2:
	var force := Vector2.ZERO
	for fish in _all_fish:
		if fish == self:
			continue
		if not is_instance_valid(fish):
			continue
		var diff: Vector2 = global_position - fish.global_position
		var d: float = diff.length()
		if d < REPULSION_RADIUS and d > 0.01:
			force += diff.normalized() * (1.0 - d / REPULSION_RADIUS)
	return force

# --- Bite ---

func set_bobber(b: Node2D) -> void:
	_bobber = b

func clear_bobber() -> void:
	_bobber = null

func _on_bite_tick() -> void:
	if _bobber == null:
		return
	var dist: float = global_position.distance_to(_bobber.global_position)
	var bite_radius := 1.0 * PIXELS_PER_METER  # 15px
	if dist > bite_radius:
		return
	# Chance scales 100% at 0.2m (3px) down to 20% at full radius
	var near_threshold := 0.2 * PIXELS_PER_METER
	var chance: float
	if dist <= near_threshold:
		chance = 1.0
	else:
		chance = lerpf(1.0, 0.2, (dist - near_threshold) / (bite_radius - near_threshold))
	if randf() <= chance:
		emit_signal("bite_triggered", self)

# --- Debug ---

func set_debug_visible(enabled: bool) -> void:
	debug_dot.visible = enabled

func _update_debug_color() -> void:
	# Draw a small colored circle as the debug dot using a one-pixel image
	var img := Image.create(6, 6, false, Image.FORMAT_RGBA8)
	var col := Color("#DC1717") if is_trophy else Color("#FFFFFF")
	# Fill a rough circle
	for x in range(6):
		for y in range(6):
			if Vector2(x - 2.5, y - 2.5).length() <= 2.5:
				img.set_pixel(x, y, col)
	var tex := ImageTexture.create_from_image(img)
	debug_dot.texture = tex
