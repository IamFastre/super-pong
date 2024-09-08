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
var delta:float = 0.0

@onready var screensize:Vector2 = get_viewport().content_scale_size

var y_delta:float :
	get: return ball.position.y - parent.position.y

var ball_direction:float :
	get:
		var dir = y_delta / abs(y_delta)
		return 0.0 if is_nan(dir) else dir

#=====================================================================#

func is_right() -> bool:
	return parent.position.x > ball.position.x

func ball_away(steps:float):
	return abs(y_delta) > speed_multiplier * delta * steps

func ball_heading_here(tolerance:float = 0.0) -> bool:
	if is_right():
		return ball.direction.x > tolerance
	else:
		return ball.direction.x < tolerance

func ball_in_my_half(tolerance:float = 1.0) -> bool:
	if is_right():
		return ball.position.x > (screensize.x / 2) * tolerance
	else:
		return ball.position.x < (screensize.x / 2) * tolerance

#=====================================================================#

func easy_ai():
	pass

func medium_ai():
	if ball_away(10.0) and ball_heading_here() and ball_in_my_half():
		direction = ball_direction
	elif ball_away(5.0):
		pass
	else:
		direction = 0.0

func hard_ai():
	pass

func handle_new_ball(ball_node:BallNode):
	ball = ball_node

func setup(cpu_difficulty:PlayerInfo.DIFFICULTY, game_manager:GameManagerNode):
	difficulty = cpu_difficulty
	game = game_manager

#=====================================================================#

func _ready() -> void:
	match difficulty:
		PlayerInfo.DIFFICULTY.EASY:
			get_input = easy_ai
		PlayerInfo.DIFFICULTY.MEDIUM:
			get_input = medium_ai
		PlayerInfo.DIFFICULTY.HARD:
			get_input = hard_ai

func _physics_process(new_delta:float) -> void:
	delta = new_delta
	if get_input:
		get_input.call()
	move(delta)
