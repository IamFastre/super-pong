class_name BallNode extends CharacterBody2D

@export var speed_multiplier:float = 500
## Initial direction of the ball, leave (0, 0) for random.
@export var initial_direction:Vector2 = Vector2.ZERO

@onready var wait_timer:Timer = $WaitTime

var direction:Vector2 = Vector2.ZERO

func random_direction() -> Vector2:
	var x = [-1, 1].pick_random()
	var y = randf_range(-1, 1)
	return Vector2(x, y).normalized()

func reflect(contact_direction:Vector2) -> Vector2:
	# v' = v - 2 * (v ∙ p) * p
	var reflection := direction - 2 * direction.dot(contact_direction) * contact_direction
	return reflection.normalized()

func handle_collision(collision:KinematicCollision2D) -> void:
	var contact_direction := (collision.get_position() - position).normalized()
	direction = reflect(contact_direction)

#=====================================================================#

func _on_wait_timeout() -> void:
	if initial_direction.length() == 0.0:
		direction = random_direction()
	else:
		direction = initial_direction

#=====================================================================#

func _physics_process(delta:float) -> void:
	var collision := move_and_collide(direction * speed_multiplier * delta)

	if collision:
		handle_collision(collision)
