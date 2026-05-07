extends Node

signal fish_added(fish_data: Dictionary)
signal derby_started
signal derby_ended

var player_name: String = "Angler"
var derby_duration: float = 300.0   # seconds; 120 or 300
var is_derby_active: bool = false

var fish_caught: Array = []

func start_derby() -> void:
	is_derby_active = true
	emit_signal("derby_started")

func end_derby() -> void:
	is_derby_active = false
	emit_signal("derby_ended")

func reset() -> void:
	fish_caught.clear()

func add_fish(fish: Node) -> void:
	var snapshot := {
		"species": fish.species,
		"length": float(fish.length),
		"weight": float(fish.weight),
		"is_trophy": fish.is_trophy,
		"trophy_name": fish.trophy_name,
	}
	fish_caught.append(snapshot)
	emit_signal("fish_added", snapshot)

func get_fish_count() -> int:
	return fish_caught.size()

func get_score() -> int:
	if fish_caught.is_empty():
		return 0
	var score: int = fish_caught.size()
	score += 1  # longest bonus
	score += 1  # shortest bonus
	score += 1  # heaviest bonus
	if has_trophy_catch():
		score += 3
	return score

func has_trophy_catch() -> bool:
	for f in fish_caught:
		if f["is_trophy"]:
			return true
	return false

func get_trophy_name() -> String:
	for f in fish_caught:
		if f["is_trophy"]:
			return f["trophy_name"]
	return ""

func get_longest() -> float:
	var m := 0.0
	for f in fish_caught:
		if f["length"] > m:
			m = f["length"]
	return m

func get_shortest() -> float:
	if fish_caught.is_empty():
		return 0.0
	var m: float = fish_caught[0]["length"]
	for f in fish_caught:
		if f["length"] < m:
			m = f["length"]
	return m

func get_heaviest() -> float:
	var m := 0.0
	for f in fish_caught:
		if f["weight"] > m:
			m = f["weight"]
	return m
