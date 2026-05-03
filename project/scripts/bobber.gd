extends Area2D

signal hook_set
signal hook_missed

const HOOK_WINDOW := 1.0

var _biting_fish: Node = null
var _waiting_for_hook := false

@onready var bite_alert: Sprite2D = $BiteAlert
@onready var hook_timer: Timer = $HookTimer

func _ready() -> void:
	hook_timer.timeout.connect(_on_hook_window_expired)

func notify_bite(fish: Node) -> void:
	if _waiting_for_hook:
		return
	_biting_fish = fish
	_waiting_for_hook = true
	bite_alert.visible = true
	bite_alert.modulate.a = 1.0
	hook_timer.start()
	# TODO Phase 11: play bite sound here

func try_set_hook() -> bool:
	if not _waiting_for_hook:
		return false
	hook_timer.stop()
	_waiting_for_hook = false
	bite_alert.visible = false
	emit_signal("hook_set", _biting_fish)
	_biting_fish = null
	return true

func _on_hook_window_expired() -> void:
	_waiting_for_hook = false
	_biting_fish = null
	# Fade the alert out
	var tween := create_tween()
	tween.tween_property(bite_alert, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func() -> void: bite_alert.visible = false)
	emit_signal("hook_missed")

func clear_bite() -> void:
	hook_timer.stop()
	_waiting_for_hook = false
	_biting_fish = null
	bite_alert.visible = false
