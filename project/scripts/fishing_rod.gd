extends Node2D

const ARC_HALF_ANGLE := PI * 75.0 / 180.0  # 75° in radians

var cast_direction := Vector2.UP  # exposed so player.gd can read it

func update_rotation(player_facing: Vector2, cursor_world: Vector2) -> void:
	var facing_angle := player_facing.angle()
	var to_cursor := cursor_world - global_position

	if to_cursor.length() < 1.0:
		cast_direction = player_facing
	else:
		var cursor_angle := to_cursor.angle()
		var delta := angle_difference(facing_angle, cursor_angle)
		var clamped : float = clamp(delta, -ARC_HALF_ANGLE, ARC_HALF_ANGLE)
		cast_direction = Vector2.RIGHT.rotated(facing_angle + clamped)

	# + PI/2 because the rod sprite points up at rotation 0
	global_rotation = cast_direction.angle() + PI / 2.0

func get_tip_position() -> Vector2:
	return $RodTip.global_position
