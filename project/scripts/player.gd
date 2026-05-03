extends CharacterBody2D

const SPEED := 55.0
const CHARGE_DURATION := 1.0
const MIN_CAST_DIST := 75.0
const MAX_CAST_DIST := 270.0
const CAST_TRAVEL_TIME := 0.5
const RECALL_COOLDOWN := 0.5
const POWER_BAR_OFFSET := Vector2(0, -26)  # screen-up above player center

enum State { IDLE, CHARGING, BOBBER_OUT, REELING }

var facing := Vector2.UP
var state := State.IDLE
var charge_time := 0.0
var recall_timer := 0.0
var bobber: Node2D = null
var cast_tween: Tween = null

var _water_polygon: PackedVector2Array = []
var _bobber_scene := preload("res://scenes/bobber.tscn")
var _biting_fish: Node = null
var _hud: Node = null

@onready var rod: Node2D = $FishingRod
@onready var fishing_line: Line2D = $FishingLine
@onready var power_bar: Node2D = $PowerBar
@onready var power_fill: ColorRect = $PowerBar/Fill

func _ready() -> void:
	# Grab the pond polygon for water validation
	var water_node = get_tree().get_first_node_in_group("water")
	if water_node:
		_water_polygon = water_node.polygon
		
	_hud = get_tree().get_first_node_in_group("hud")

func _physics_process(_delta: float) -> void:
	if state == State.IDLE:
		_handle_movement()
	else:
		velocity = Vector2.ZERO
	move_and_slide()

	if state == State.BOBBER_OUT and bobber != null:
		fishing_line.points = PackedVector2Array([
			rod.get_tip_position(),
			bobber.global_position
		])

func _process(delta: float) -> void:
	rod.update_rotation(facing, get_global_mouse_position())

	# Keep top-level nodes positioned above the player in screen space
	power_bar.global_position = global_position + POWER_BAR_OFFSET + Vector2(-32, 0)

	match state:
		State.IDLE:
			if Input.is_action_just_pressed("cast_action"):
				_start_charging()

		State.CHARGING:
			charge_time = minf(charge_time + delta, CHARGE_DURATION)
			_update_power_bar()
			if Input.is_action_just_released("cast_action"):
				_fire_cast()

		State.BOBBER_OUT:
			if recall_timer > 0.0:
				recall_timer -= delta
			elif Input.is_action_just_pressed("cast_action"):
				if bobber and bobber.try_set_hook():
					pass  # hook_set signal handles the rest
				else:
					_recall_bobber()

func _handle_movement() -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_dir.length() > 0.1:
		if abs(input_dir.x) >= abs(input_dir.y):
			facing = Vector2(sign(input_dir.x), 0)
		else:
			facing = Vector2(0, sign(input_dir.y))
		velocity = facing * SPEED
		rotation = facing.angle() + PI / 2.0
	else:
		velocity = Vector2.ZERO

func _start_charging() -> void:
	state = State.CHARGING
	charge_time = 0.0
	power_bar.visible = true

func _update_power_bar() -> void:
	var power := charge_time / CHARGE_DURATION
	power_fill.size.x = 60.0 * power
	if power < 0.33:
		power_fill.color = Color("#35A300")
	elif power < 0.66:
		power_fill.color = Color("#F3DB34")
	else:
		power_fill.color = Color("#DC1717")

func _fire_cast() -> void:
	power_bar.visible = false
	var power := charge_time / CHARGE_DURATION
	var dist := MIN_CAST_DIST + power * (MAX_CAST_DIST - MIN_CAST_DIST)
	var landing: Vector2 = global_position + rod.cast_direction * dist

	if not _is_in_water(landing):
		state = State.IDLE
		return

	# Instantiate First - bobber must exist before any access to it below
	bobber = _bobber_scene.instantiate()
	get_parent().add_child(bobber)
	bobber.global_position = rod.get_tip_position()

	state = State.BOBBER_OUT
	recall_timer = CAST_TRAVEL_TIME + RECALL_COOLDOWN
	fishing_line.visible = true
	
	# Wire fish after bobber exists
	for fish in get_tree().get_nodes_in_group("fish"):
		fish.set_bobber(bobber)
		if not fish.bite_triggered.is_connected(bobber.notify_bite):
			fish.bite_triggered.connect(bobber.notify_bite)
	
	# Connect bobber signals
	bobber.hook_set.connect(_on_hook_set)
	bobber.hook_missed.connect(_on_hook_missed)
	
	_animate_bobber(landing)

func _animate_bobber(to: Vector2) -> void:
	if cast_tween:
		cast_tween.kill()
	cast_tween = create_tween().set_parallel(true)
	cast_tween.tween_property(bobber, "global_position", to, CAST_TRAVEL_TIME)
	cast_tween.tween_method(
		func(t: float) -> void:
			if bobber:
				bobber.scale = Vector2.ONE * (1.0 + 0.5 * sin(t * PI)),
		0.0, 1.0, CAST_TRAVEL_TIME
	)

func _recall_bobber() -> void:
	if cast_tween:
		cast_tween.kill()
		
	if bobber:
		for fish in get_tree().get_nodes_in_group("fish"):
			fish.clear_bobber()
			if fish.bite_triggered.is_connected(bobber.notify_bite):
				fish.bite_triggered.disconnect(bobber.notify_bite)
		bobber.queue_free()
		bobber = null
		
	fishing_line.visible = false
	_biting_fish = null
	state = State.IDLE

func _is_in_water(point: Vector2) -> bool:
	if _water_polygon.is_empty():
		return false
	return Geometry2D.is_point_in_polygon(point, _water_polygon)

func _on_hook_set(fish: Node) -> void:
	_biting_fish = fish
	for f in get_tree().get_nodes_in_group("fish"):
		f.clear_bobber()
		if bobber and f.bite_triggered.is_connected(bobber.notify_bite):
			f.bite_triggered.disconnect(bobber.notify_bite)
	_reel_in()

func _on_hook_missed() -> void:
	_biting_fish = null

func _reel_in() -> void:
	state = State.REELING
	if cast_tween:
		cast_tween.kill()
	fishing_line.visible = false
	# Auto-reel: tween bobber back to rod tip over 2s, then catch
	cast_tween = create_tween()
	cast_tween.tween_property(bobber, "global_position", rod.get_tip_position(), 2.0)
	cast_tween.tween_callback(_on_reel_complete)

func _on_reel_complete() -> void:
	if _biting_fish and is_instance_valid(_biting_fish):
		if _hud:
			_hud.show_catch(_biting_fish)
		# TODO Phase 10: GameState.add_fish(_biting_fish)
		# TODO Phase 11: play catch sound here
		var spawner := get_tree().get_first_node_in_group("fish_spawner")
		if spawner:
			spawner.remove_fish(_biting_fish)
		_biting_fish.queue_free()
	_biting_fish = null
	if bobber:
		bobber.queue_free()
		bobber = null
	state = State.IDLE
