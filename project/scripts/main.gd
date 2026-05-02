extends Node

@onready var fish_spawner: Node = $FishSpawner

func _ready() -> void:
	var water := get_tree().get_first_node_in_group("water")
	if water == null:
		push_error("main.gd: No node in group 'water' found.")
		return
	fish_spawner.spawn_all(water.polygon)

func _unhandled_input(event: InputEvent) -> void:
	# Toggle debug mode with F1
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F1:
			fish_spawner.debug_mode = !fish_spawner.debug_mode
