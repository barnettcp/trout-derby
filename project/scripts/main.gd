extends Node

enum DerbyPhase { MENU, PRE_COUNTDOWN, ACTIVE, POST_DERBY }

const _scoreboard_scene := preload("res://scenes/ui/scoreboard.tscn")
const _main_menu_scene := preload("res://scenes/ui/main_menu.tscn")

var _phase: DerbyPhase = DerbyPhase.MENU
var _water_polygon: PackedVector2Array = []
var _hud: Node = null
var _scoreboard: Node = null
var _auto_closed_scoreboard: bool = false

@onready var fish_spawner: Node = $FishSpawner
@onready var pre_countdown_timer: Timer = $PreCountdownTimer
@onready var derby_timer: Timer = $DerbyTimer
@onready var between_timer: Timer = $BetweenTimer
@onready var countdown_overlay: CanvasLayer = $CountdownOverlay
@onready var countdown_label: Label = $CountdownOverlay/CountdownLabel

func _ready() -> void:
	var water := get_tree().get_first_node_in_group("water")
	if water == null:
		push_error("main.gd: No node in group 'water' found.")
		return
	_water_polygon = water.polygon
	_hud = get_tree().get_first_node_in_group("hud")

	fish_spawner.spawn_all(_water_polygon)
	countdown_overlay.visible = false

	pre_countdown_timer.timeout.connect(_on_pre_countdown_timeout)
	derby_timer.timeout.connect(_on_derby_timeout)
	between_timer.timeout.connect(_on_between_timeout)

	var menu := _main_menu_scene.instantiate()
	add_child(menu)
	menu.join_confirmed.connect(func() -> void:
		menu.queue_free()
		_enter_pre_countdown()
	)

func _process(_delta: float) -> void:
	match _phase:
		DerbyPhase.PRE_COUNTDOWN:
			countdown_label.text = "Derby starts in: %d" % ceili(pre_countdown_timer.time_left)

		DerbyPhase.ACTIVE:
			if _hud:
				_hud.update_timer(derby_timer.time_left)

		DerbyPhase.POST_DERBY:
			var t := between_timer.time_left
			if _scoreboard and is_instance_valid(_scoreboard):
				_scoreboard.update_countdown(t)
			if t <= 10.0 and not _auto_closed_scoreboard:
				_auto_closed_scoreboard = true
				if _scoreboard and is_instance_valid(_scoreboard):
					_scoreboard.dismiss()
					_scoreboard = null
				countdown_overlay.visible = true
			if _auto_closed_scoreboard:
				countdown_label.text = "Derby starts in: %d" % ceili(t)

# --- Phase transitions ---

func _enter_pre_countdown() -> void:
	_phase = DerbyPhase.PRE_COUNTDOWN
	countdown_overlay.visible = true
	pre_countdown_timer.start()

func _on_pre_countdown_timeout() -> void:
	countdown_overlay.visible = false
	_start_derby()

func _start_derby() -> void:
	_phase = DerbyPhase.ACTIVE
	GameState.reset()
	GameState.start_derby()
	derby_timer.wait_time = GameState.derby_duration
	derby_timer.start()
	if _hud:
		_hud.reset_score()
		_hud.update_timer(GameState.derby_duration)

func _on_derby_timeout() -> void:
	_phase = DerbyPhase.POST_DERBY
	GameState.end_derby()
	_auto_closed_scoreboard = false
	_scoreboard = _scoreboard_scene.instantiate()
	add_child(_scoreboard)
	between_timer.start()

func _on_between_timeout() -> void:
	countdown_overlay.visible = false
	if _scoreboard and is_instance_valid(_scoreboard):
		_scoreboard.dismiss()
		_scoreboard = null
	fish_spawner.despawn_all()
	fish_spawner.spawn_all(_water_polygon)
	_start_derby()

# --- Debug ---

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F1:
			fish_spawner.debug_mode = !fish_spawner.debug_mode
