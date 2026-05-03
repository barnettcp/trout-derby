extends CanvasLayer

const POPUP_DURATION := 2.0

var _portrait_textures := {}
var _popup_tween: Tween

@onready var catch_popup: Panel = $CatchPopup
@onready var portrait: TextureRect = $CatchPopup/Portrait
@onready var species_label: Label = $CatchPopup/SpeciesLabel
@onready var stats_label: Label = $CatchPopup/StatsLabel
@onready var trophy_badge: Panel = $CatchPopup/TrophyBadge

func _ready() -> void:
	_preload_portraits()
	catch_popup.visible = false

func _preload_portraits() -> void:
	_portrait_textures["rainbow_trout"] = load("res://assets/ui/icon_rainbow_trout.png")
	_portrait_textures["scruffy"] = load("res://assets/ui/icon_trophy_scruffy.png")
	_portrait_textures["sally"] = load("res://assets/ui/icon_trophy_sally.png")
	_portrait_textures["smokey"] = load("res://assets/ui/icon_trophy_smokey.png")

func show_catch(fish: Node) -> void:
	# Portrait — use trophy portrait if applicable, else species portrait
	if fish.is_trophy and _portrait_textures.has(fish.trophy_name.to_lower()):
		portrait.texture = _portrait_textures[fish.trophy_name.to_lower()]
	elif _portrait_textures.has(fish.species):
		portrait.texture = _portrait_textures[fish.species]

	species_label.text = fish.species.replace("_", " ").capitalize()
	stats_label.text = "%.1f in  •  %.2f lb\n%d rounds since caught" % [
		fish.length, fish.weight, fish.get("rounds_since_last_caught") if "rounds_since_last_caught" in fish else 0
	]
	trophy_badge.visible = fish.is_trophy

	catch_popup.modulate.a = 1.0
	catch_popup.visible = true

	if _popup_tween:
		_popup_tween.kill()
	_popup_tween = create_tween()
	_popup_tween.tween_interval(POPUP_DURATION)
	_popup_tween.tween_property(catch_popup, "modulate:a", 0.0, 0.4)
	_popup_tween.tween_callback(func() -> void: catch_popup.visible = false)
