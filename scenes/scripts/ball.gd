class_name BallNode extends CharacterBody2D

## Initial direction of the ball, leave (0, 0) for random.
@export var initial_direction:Vector2 = Vector2.ZERO
@export_group("Speed", "speed_")
@export var speed_min:float = 500
@export var speed_max:float = 2000
@export var speed_multiplier:float = 750 :
	get: return speed_multiplier
	set(value): speed_multiplier = clampf(value, speed_min, speed_max)
@export var speed_hit_interval:int = 2
@export var speed_step:float = 25

@onready var wait_timer:Timer = $WaitTime

var direction:Vector2 = Vector2.ZERO
var hit_count:int = 0

func random_direction() -> Vector2:
	var x = [-1, 1].pick_random()
	var y = randf_range(-1, 1)
	return Vector2(x, y).normalized()

func reflect(contact_direction:Vector2) -> Vector2:
	# v' = v - 2 * (v ∙ p) * p
	var reflection := direction - 2 * direction.dot(contact_direction) * contact_direction
	return reflection.normalized()

func handle_collision(collision:KinematicCollision2D) -> void:
	var collider := collision.get_collider()
	var collision_pos := collision.get_position() - position
	var contact_direction := collision_pos.normalized()
	direction = reflect(contact_direction)

	if collider is PaddleNode:
		hit_count += 1
		if hit_count % speed_hit_interval == 0:
			speed_multiplier += speed_step

		var paddle := collider as PaddleNode
		var rot_dir:float = 1 if direction.x == 0.0 else direction.x / abs(direction.x)
		var strength:float = paddle.movement.velocity / paddle.movement.speed_multiplier / 2
		var angle = lerp_angle(0, PI/6 * strength, 1 - abs(direction.y)) * rot_dir
		direction = direction.rotated(angle)

	elif collider is WallNode and abs(direction.y) >= 0.9:
		var rot_dir:float = 1 if direction.x == 0.0 else -direction.x / abs(direction.x)
		var angle = PI/6 * direction.y * rot_dir
		direction = direction.rotated(angle)

#=====================================================================#

func _on_wait_timeout() -> void:
	if initial_direction.length() == 0.0:
		direction = random_direction()
	else:
		direction = initial_direction

#=====================================================================#

func _process(delta:float) -> void:
	var collision := move_and_collide(direction * speed_multiplier * delta)

	if collision:
		handle_collision(collision)
