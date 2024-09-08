class_name CPUMovement extends PaddleMovement

@export var difficulty:PlayerInfo.DIFFICULTY = PlayerInfo.DIFFICULTY.MEDIUM
@export var game:GameManagerNode :
	get:
		return game
	set(value):
		if game:
			game.ball_spawned.disconnect(handle_new_ball)
		game = value
		game.ball_spawned.connect(handle_new_ball)

var get_input:Callable
var ball:BallNode
var delta:float = 0

@onready var center:Vector2 = Constants.screensize / 2

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
	return abs(dif) > speed_multiplier * delta * steps

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

func cpu_easy():
	var condition = away(ball.position, 10) and ball_heading_here() and ball_in_my_half(0.75)
	direction = direction_to(ball.position) if condition else 0.0

func cpu_medium():
	var condition = away(ball.position, 7.5) and ball_heading_here() and ball_in_my_half()
	direction = direction_to(ball.position) if condition else 0.0

func cpu_hard():
	var target = ball.position if ball_heading_here() and ball_in_my_half(1.5) else center
	direction = direction_to(target) if away(target, 5) else 0.0
	is_sprinting = away(target, 12.5) and ball_in_my_half()

func handle_new_ball(ball_node:BallNode):
	ball = ball_node

func setup(cpu_difficulty:PlayerInfo.DIFFICULTY, game_manager:GameManagerNode):
	difficulty = cpu_difficulty
	game = game_manager

#=====================================================================#

func _ready() -> void:
	match difficulty:
		PlayerInfo.DIFFICULTY.EASY:
			get_input = cpu_easy
		PlayerInfo.DIFFICULTY.MEDIUM:
			get_input = cpu_medium
		PlayerInfo.DIFFICULTY.HARD:
			get_input = cpu_hard

func _process(new_delta:float) -> void:
	delta = new_delta
	if get_input:
		get_input.call()
	move(delta)
