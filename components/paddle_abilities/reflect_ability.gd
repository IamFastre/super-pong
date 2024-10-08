class_name ReflectAbility extends PaddleAbility

@export var icon:TextureRect
@export var timer:Timer
@export var general_duration:float = 0.5

@onready var original_pos:Vector2 = icon.position

var recharging:bool = false
var target_ball:BallNode :
	get:
		game.closest_ball_to(not is_left as int)

		for ball in game.balls:
			if in_my_half(ball.position) and heading_here(ball.direction):
				return ball
		return null

#=====================================================================#

func in_my_half(pos:Vector2) -> bool:
	if is_left:
		return pos.x < Utilities.center.x
	else:
		return pos.x > Utilities.center.x

func heading_here(dir:Vector2) -> bool:
	if is_left:
		return dir.x < 0
	else:
		return dir.x > 0

func elastic_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant, custom_dur:float = 0):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, custom_dur if custom_dur else general_duration) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_ELASTIC)

func spring_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant, custom_dur:float = 0):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, custom_dur if custom_dur else general_duration) \
		.set_ease(Tween.EASE_IN) \
		.set_trans(Tween.TRANS_SPRING)

#=====================================================================#

func on_start() -> void:
	if recharging or not target_ball: return

	var ball := target_ball
	var tween1 := create_tween()
	spring_tween(tween1, icon, "position", (ball.position - paddle.position) / 2)
	spring_tween(tween1, icon, "scale", Vector2.ZERO, general_duration)
	spring_tween(tween1, icon, "rotation", (ball.position - paddle.position).angle() + PI/2, general_duration / 2)

	ball.direction.x *= -1
	ball.hit_count += 3

	recharging = true
	timer.start()
	await timer.timeout
	recharging = false

	var tween2 := create_tween()
	icon.position = original_pos
	icon.rotation = 1.5 * PI
	elastic_tween(tween2, icon, "rotation", PI/2, general_duration * 3)
	elastic_tween(tween2, icon, "scale", Vector2.ONE, general_duration * 3)

#=====================================================================#

func _process(delta:float) -> void:
	super._process(delta)
	timer.paused = not game.running
