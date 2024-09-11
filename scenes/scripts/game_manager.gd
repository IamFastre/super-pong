class_name GameManagerNode extends Node

@export_group("Player 1", "left_")
@export var left_score:int = 0
@export var left_info:PlayerInfo
@export var left_goal:GoalNode
@export var left_label:Label
@export var left_paddle:PaddleNode

@export_group("Player 2", "right_")
@export var right_score:int = 0
@export var right_info:PlayerInfo
@export var right_goal:GoalNode
@export var right_label:Label
@export var right_paddle:PaddleNode

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
		Side.LEFT: left_score += 1
		Side.RIGHT: right_score += 1
	spawn_ball()

func setup_paddle(paddle:PaddleNode, info:PlayerInfo) -> void:
	var movement = info.get_movement_node()

	if movement is HumanMovement:
		(movement as HumanMovement).setup(info.id)
	elif movement is CPUMovement:
		(movement as CPUMovement).setup(info.difficulty)

	paddle.add_child(movement)

#=====================================================================#

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	left_goal.scored.connect(on_score.bind(Side.RIGHT))
	right_goal.scored.connect(on_score.bind(Side.LEFT))

	setup_paddle(left_paddle, left_info)
	setup_paddle(right_paddle, right_info)

	spawn_ball()

func _process(_delta:float) -> void:
	left_label.text = str(left_score)
	right_label.text = str(right_score)
