class_name CPUMovement extends PaddleMovement

@export var difficulty:PlayerInfo.DIFFICULTY = PlayerInfo.DIFFICULTY.MEDIUM

var get_input:Callable
var ball:BallNode

func easy_ai():
	pass

func medium_ai():
	pass

func hard_ai():
	pass

func handle_new_ball(ball_node:BallNode):
	ball = ball_node

func setup(cpu_difficulty:PlayerInfo.DIFFICULTY, new_ball_signal:Signal):
	difficulty = cpu_difficulty
	new_ball_signal.connect(handle_new_ball)

#=====================================================================#

func _ready() -> void:
	match difficulty:
		PlayerInfo.DIFFICULTY.EASY:
			get_input = easy_ai
		PlayerInfo.DIFFICULTY.MEDIUM:
			get_input = medium_ai
		PlayerInfo.DIFFICULTY.HARD:
			get_input = hard_ai

func _physics_process(delta:float) -> void:
	if get_input:
		get_input.call()
	move(delta)
