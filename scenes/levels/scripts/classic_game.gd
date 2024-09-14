class_name ClassicGame extends Node

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
@export var spawn_ball_on_start:bool = true
@export var ball_packed:PackedScene = preload("res://scenes/ball.tscn")
@export var initial_position:Vector2 = Vector2(640, 360)

@export_group("Game Over Screen", "go_")
@export var go_scene:PackedScene = preload("res://scenes/screens/game_over.tscn")
@export var go_score_goal:int = 10

var running:bool = true :
	get: return running
	set(value):
		if left_paddle.movement and right_paddle.movement:
			left_paddle.movement.disabled = not value
			right_paddle.movement.disabled = not value
		running = value

signal ball_spawned(ball:BallNode)

#=====================================================================#

enum Side {
	LEFT,
	RIGHT,
}

#=====================================================================#

func score_goal_met() -> bool:
	return left_score >= go_score_goal or right_score >= go_score_goal

func spawn_ball() -> void:
	if running:
		var ball_node := ball_packed.instantiate() as BallNode
		ball_node.position = initial_position
		call_deferred('add_child', ball_node)
		ball_spawned.emit(ball_node)

func on_score(to_player:Side) -> void:
	match to_player:
		Side.LEFT: left_score += 1
		Side.RIGHT: right_score += 1

	if not score_goal_met():
		spawn_ball()

func setup_paddle(paddle:PaddleNode, info:PlayerInfo) -> void:
	var movement = info.get_movement_node()

	if movement is HumanMovement:
		(movement as HumanMovement).setup(info.id)
	elif movement is CPUMovement:
		(movement as CPUMovement).setup(info.difficulty)

	paddle.add_child(movement)

func game_over() -> void:
	running = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	left_label.visible = false
	right_label.visible = false

	var go_screen = go_scene.instantiate() as GameOverScreen
	go_screen.game = self
	go_screen.score_left = left_score
	go_screen.score_right = right_score

	if left_score > right_score:
		go_screen.winner_name = left_info.name
		go_screen.winner_side = "left"
	elif left_score < right_score:
		go_screen.winner_name = right_info.name
		go_screen.winner_side = "right"

	add_child(go_screen)

func restart() -> void:
	running = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	left_label.visible = true
	right_label.visible = true

	for c in get_children():
		if c is BallNode:
			c.queue_free()

	left_score = 0
	right_score = 0
	left_paddle.position.y = Constants.screensize.y / 2
	right_paddle.position.y = Constants.screensize.y / 2
	spawn_ball()

#=====================================================================#

func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _ready() -> void:
	setup_paddle(left_paddle, left_info)
	setup_paddle(right_paddle, right_info)

	left_goal.scored.connect(on_score.bind(Side.RIGHT))
	right_goal.scored.connect(on_score.bind(Side.LEFT))

	if spawn_ball_on_start:
		spawn_ball()

func _process(_delta:float) -> void:
	if running and score_goal_met():
		game_over()
		print(running)

	left_label.text = str(left_score)
	right_label.text = str(right_score)
