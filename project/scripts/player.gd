extends CharacterBody2D

const SPEED = 55.0  # px/s  (1.1 m/s × 15 px/m)

var facing := Vector2.UP  # starts facing up, toward the pond

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_dir.length() > 0.1:
		# Snap to the dominant cardinal direction
		if abs(input_dir.x) >= abs(input_dir.y):
			facing = Vector2(sign(input_dir.x), 0)
		else:
			facing = Vector2(0, sign(input_dir.y))

		velocity = facing * SPEED
		# Rotate the whole node so the sprite and (later) the rod face the right way
		# + PI/2 offset because the sprite is drawn pointing up at rotation 0
		rotation = facing.angle() + PI / 2.0
	else:
		velocity = Vector2.ZERO

	move_and_slide()
