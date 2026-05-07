extends CanvasLayer

@onready var player_label: Label = $ScorePanel/VBox/PlayerLabel
@onready var fish_count_label: Label = $ScorePanel/VBox/FishCountLabel
@onready var modifiers_label: Label = $ScorePanel/VBox/ModifiersLabel
@onready var score_label: Label = $ScorePanel/VBox/ScoreLabel
@onready var awards_label: Label = $ScorePanel/VBox/AwardsLabel
@onready var next_derby_label: Label = $ScorePanel/VBox/NextDerbyLabel
@onready var dismiss_button: Button = $ScorePanel/VBox/DismissButton

func _ready() -> void:
	player_label.text = GameState.player_name
	fish_count_label.text = "Caught: %d fish" % GameState.get_fish_count()

	# Score modifiers
	var mod_lines: Array = []
	if GameState.get_fish_count() > 0:
		mod_lines.append("Longest catch: %.1f in  (+1)" % GameState.get_longest())
		mod_lines.append("Shortest catch: %.1f in  (+1)" % GameState.get_shortest())
		mod_lines.append("Heaviest catch: %.2f lb  (+1)" % GameState.get_heaviest())
	if GameState.has_trophy_catch():
		mod_lines.append("Trophy — %s  (+3)" % GameState.get_trophy_name())
	modifiers_label.text = "\n".join(mod_lines)

	score_label.text = "SCORE: %d" % GameState.get_score()

	# Awards
	var award_lines: Array = []
	if GameState.get_fish_count() > 0:
		award_lines.append("★  Most Fish — Gold Star")
		award_lines.append("★  Biggest Catch — Blue Ribbon")
	if GameState.has_trophy_catch():
		award_lines.append("★  Trophy Catch — Trophy")
	if award_lines.is_empty():
		awards_label.text = "(no awards this derby)"
	else:
		awards_label.text = "\n".join(award_lines)

	dismiss_button.pressed.connect(dismiss)

# Called every frame by main.gd during POST_DERBY.
func update_countdown(seconds_left: float) -> void:
	var mins: int = int(seconds_left) / 60
	var secs: int = int(seconds_left) % 60
	next_derby_label.text = "Next derby in: %02d:%02d" % [mins, secs]

func dismiss() -> void:
	queue_free()
