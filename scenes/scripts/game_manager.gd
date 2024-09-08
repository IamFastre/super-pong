class_name GameManagerNode extends Node

@export_group("Player 1")
@export var score_left:int = 0
@export var player_left:PlayerInfo
@export var goal_left:GoalNode
@export var label_left:Label
@export var paddle_left:PaddleNode

@export_group("Player 2")
@export var score_right:int = 0
@export var player_right:PlayerInfo
@export var goal_right:GoalNode
@export var label_right:Label
@export var paddle_right:PaddleNode

@export_group("Ball")
@export var ball:PackedScene = preload("res://scenes/ball.tscn")
@export var initial_position:Vector2 = Vector2(640, 360)

signal ball_spawned(ball:BallNode)

#=====================================================================#

enum Side {
	LEFT,
	RIGHT,
}

#=====================================================================#

func spawn_ball() -> void:
	var ball_node := ball.instantiate() as BallNode
	ball_node.position = initial_position
	call_deferred('add_sibling', ball_node)
	ball_spawned.emit(ball_node)

func on_score(to_player:Side) -> void:
	match to_player:
		Side.LEFT: score_left += 1
		Side.RIGHT: score_right += 1
	spawn_ball()

func setup_paddle(paddle:PaddleNode, info:PlayerInfo) -> void:
	var movement = info.get_movement_node()

	if movement is HumanMovement:
		(movement as HumanMovement).setup(info.id)
	elif movement is CPUMovement:
		(movement as CPUMovement).setup(info.difficulty, self)

	paddle.add_child(movement)

#=====================================================================#

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	goal_left.scored.connect(on_score.bind(Side.RIGHT))
	goal_right.scored.connect(on_score.bind(Side.LEFT))

	setup_paddle(paddle_left, player_left)
	setup_paddle(paddle_right, player_right)

	spawn_ball()

func _process(_delta:float) -> void:
	label_left.text = str(score_left)
	label_right.text = str(score_right)
