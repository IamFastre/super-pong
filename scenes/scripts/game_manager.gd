class_name GameManagerNode extends Node

@export_group("Player 1")
@export var player_left:PlayerInfo
@export var goal_left:GoalNode
@export var label_left:Label
@export var paddle_left:PaddleNode

@export_group("Player 2")
@export var player_right:PlayerInfo
@export var goal_right:GoalNode
@export var label_right:Label
@export var paddle_right:PaddleNode

@export_group("Ball")
@export var ball:PackedScene = preload("res://scenes/ball.tscn")
@export var initial_position:Vector2 = Vector2(640, 360)


func on_score(player:PlayerInfo) -> void:
	player.score += 1

	var ball_node := ball.instantiate() as BallNode
	ball_node.position = initial_position
	call_deferred('add_sibling', ball_node)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	goal_left.scored.connect(on_score.bind(player_right))
	goal_right.scored.connect(on_score.bind(player_left))

	paddle_left.setup(player_left)
	paddle_right.setup(player_right)

func _process(_delta:float) -> void:
	label_left.text = str(player_left.score)
	label_right.text = str(player_right.score)
