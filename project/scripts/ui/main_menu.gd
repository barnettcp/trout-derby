extends Control

signal join_confirmed

@onready var name_input: LineEdit = $CenterContainer/VBoxContainer/NameRow/NameInput
@onready var btn_2min: Button = $CenterContainer/VBoxContainer/DurationRow/Btn2Min
@onready var btn_5min: Button = $CenterContainer/VBoxContainer/DurationRow/Btn5Min
@onready var join_button: Button = $CenterContainer/VBoxContainer/JoinButton
@onready var exit_button: Button = $CenterContainer/VBoxContainer/ExitButton

func _ready() -> void:
	# Pre-fill from GameState in case player returns to menu later
	name_input.text = GameState.player_name
	_update_duration_buttons()

	btn_2min.pressed.connect(_on_2min_pressed)
	btn_5min.pressed.connect(_on_5min_pressed)
	join_button.pressed.connect(_on_join_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_2min_pressed() -> void:
	GameState.derby_duration = 120.0
	_update_duration_buttons()

func _on_5min_pressed() -> void:
	GameState.derby_duration = 300.0
	_update_duration_buttons()

func _update_duration_buttons() -> void:
	btn_2min.disabled = GameState.derby_duration == 120.0
	btn_5min.disabled = GameState.derby_duration == 300.0

func _on_join_pressed() -> void:
	var raw_name := name_input.text.strip_edges()
	GameState.player_name = raw_name if not raw_name.is_empty() else "Angler"
	emit_signal("join_confirmed")

func _on_exit_pressed() -> void:
	get_tree().quit()
