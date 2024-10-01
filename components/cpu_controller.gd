class_name CPUController extends PaddleController

@export_enum("Disabled", "Easy", "Medium", "Hard") var mode:int = 0

@onready var game:GameMode = GameMode.get_instance(parent)
@onready var center:Vector2 = Utilities.screensize / 2

var ball:BallNode :
	get:
		if len(game.balls) == 0:
			return null
		elif len(game.balls) == 1:
			return game.balls[0]
		else:
			var closest:BallNode = null
			for b in game.balls:
				if closest == null:
					closest = b
					continue
				elif abs(parent.position.x - closest.position.x) > abs(parent.position.x - b.position.x):
					closest = b
			return closest

#=====================================================================#

func is_right() -> bool:
	return parent.position.x > center.x

func dif_from(vec:Vector2) -> float:
	return vec.y - parent.position.y

func direction_to(vec:Vector2) -> float:
	var dif = dif_from(vec)
	var dir = dif / abs(dif)
	return 0 if is_nan(dir) else dir

func away(vec:Vector2, steps:float) -> bool:
	var dif = dif_from(vec)
	return abs(dif) > 7.5 * steps

func ball_heading_here(tolerance:float = 0) -> bool:
	if is_right():
		return ball.direction.x > tolerance
	else:
		return ball.direction.x < tolerance

func ball_in_my_half(tolerance:float = 1) -> bool:
	if is_right():
		return ball.position.x > center.x * (2 - tolerance)
	else:
		return ball.position.x < center.x * tolerance

#=====================================================================#

func easy():
	var condition = away(ball.position, 8) and ball_heading_here() and ball_in_my_half(0.75)
	v_axis = direction_to(ball.position) if condition else 0.0

func medium():
	var condition = away(ball.position, 5) and ball_heading_here() and ball_in_my_half()
	v_axis = direction_to(ball.position) if condition else 0.0

func hard():
	var target = ball.position if ball_heading_here() and ball_in_my_half() else center
	v_axis = direction_to(target) if away(target, 2) else 0.0
	sprint_pressed = away(target, 5) and ball_in_my_half()

#=====================================================================#

func _process(_delta:float) -> void:
	if ball: match mode:
		1: easy()
		2: medium()
		3: hard()
