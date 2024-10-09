class_name GameMode extends Node

@export var score_goal:int = 10

@export_group("Player 1", "left_")
@export var left_score:int = 0
@export var left_info:PlayerInfo
@export var left_goal:GoalNode
@export var left_label:Label
@export var left_icon:TextureRect

@export_group("Player 2", "right_")
@export var right_score:int = 0
@export var right_info:PlayerInfo
@export var right_goal:GoalNode
@export var right_label:Label
@export var right_icon:TextureRect

@export_group("Paddles", "paddle_")
@export var paddle_left_scene:PackedScene = preload("res://scenes/paddles/classic_paddle.tscn")
@export var paddle_right_scene:PackedScene = preload("res://scenes/paddles/classic_paddle.tscn")
@export var paddle_initial_displacement:Vector2 = Vector2(50, 360)

@export_group("Ball", "ball_")
@export var ball_spawn_on_start:bool = true
@export var ball_packed_scene:PackedScene = preload("res://scenes/ball.tscn")
@export var ball_initial_position:Vector2 = Vector2(640, 360)

@export_group("Menus", "menu_")
@export var menu_pause:PackedScene = preload("res://scenes/overlays/pause_menu.tscn") # menu pause lol
@export var menu_game_over:PackedScene = preload("res://scenes/overlays/game_over.tscn")

var left_paddle:PaddleNode
var right_paddle:PaddleNode

var running:bool = true :
	get: return running
	set(value):
		running = value

		left_paddle.movement.disabled = not running
		left_paddle.ability.disabled = not running

		right_paddle.movement.disabled = not running
		right_paddle.ability.disabled = not running

		for b in balls:
			b.movement_disabled = not running

		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN if running else Input.MOUSE_MODE_VISIBLE)

		running_changed.emit()
		
var balls:Array[BallNode]

signal ball_spawned(ball:BallNode)
signal ball_despawned()

signal running_changed()

#=====================================================================#

enum Side {
	LEFT,
	RIGHT,
}

#=====================================================================#

static func get_instance(node:Node) -> GameMode:
	var parent := node.get_parent()

	if parent is GameMode or parent == null:
		return parent

	return get_instance(parent)

#=====================================================================#

func closest_ball_to(side:Side) -> BallNode:
	if len(balls) == 0:
		return null
	if len(balls) == 1:
		return balls[0]

	var left = func(x:BallNode, y:BallNode): return x.position.x < y.position.x
	var right = func(x:BallNode, y:BallNode): return x.position.x > y.position.x

	match side:
		Side.LEFT:
			balls.sort_custom(left)
		Side.RIGHT:
			balls.sort_custom(right)
	return balls[0]

func score_goal_met() -> bool:
	return left_score >= score_goal or right_score >= score_goal

func get_winner() -> bool:
	return left_score >= score_goal or right_score >= score_goal

func spawn_ball(custom_initial_position:Vector2 = ball_initial_position) -> void:
	if running:
		var ball_node := ball_packed_scene.instantiate() as BallNode
		ball_node.tree_entered.connect(balls.append.bind(ball_node))
		ball_node.tree_exited.connect(balls.erase.bind(ball_node))
		ball_node.position = custom_initial_position
		call_deferred('add_child', ball_node)
		ball_spawned.emit(ball_node)

func on_score(to_player:Side) -> void:
	match to_player:
		Side.LEFT: left_score += 1
		Side.RIGHT: right_score += 1

	ball_despawned.emit()
	if not score_goal_met():
		spawn_ball()

func setup_paddle(paddle:PaddleNode, info:PlayerInfo) -> void:
	# Paddle position setup
	paddle.position.y = paddle_initial_displacement.y
	if paddle == left_paddle:
		paddle.position.x = paddle_initial_displacement.x
	elif paddle == right_paddle:
		paddle.position.x = Utilities.screensize.x - paddle_initial_displacement.x
		paddle.scale.x *= -1

	# Paddle controller setup
	paddle.setup_controller(info.get_controller())

	add_child(paddle)

func game_over() -> void:
	running = false
	left_label.visible = false
	right_label.visible = false

	var go_screen := menu_game_over.instantiate() as GameOverScreen
	go_screen.game = self
	go_screen.score_left = left_score
	go_screen.score_right = right_score

	if left_score > right_score:
		go_screen.winner_name = left_info.name
		go_screen.winner_side = "left"
	elif left_score < right_score:
		go_screen.winner_name = right_info.name
		go_screen.winner_side = "right"
	else:
		go_screen.score_is_tied = true

	add_child(go_screen)

func pause() -> void:
	running = false
	var ps_screen := menu_pause.instantiate() as PauseScreen
	ps_screen.game = self
	ps_screen.is_super = self is SuperGame
	add_child(ps_screen)

func unpause() -> void:
	running = true

func restart() -> void:
	running = true
	left_label.visible = true
	right_label.visible = true

	for b in balls:
		b.queue_free()

	left_score = 0
	right_score = 0
	left_paddle.position.y = Utilities.screensize.y / 2
	right_paddle.position.y = Utilities.screensize.y / 2
	spawn_ball()

func startup() -> void:
	left_paddle = paddle_left_scene.instantiate()
	right_paddle = paddle_right_scene.instantiate()

	setup_paddle(left_paddle, left_info)
	setup_paddle(right_paddle, right_info)

	left_goal.scored.connect(on_score.bind(Side.RIGHT))
	right_goal.scored.connect(on_score.bind(Side.LEFT))

	left_icon.texture = left_info.icon
	right_icon.texture = right_info.icon

	if ball_spawn_on_start:
		spawn_ball()


#=====================================================================#

func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		if running:
			pause()
		else:
			unpause()

func _ready() -> void:
	startup()

func _process(_delta:float) -> void:
	if running and score_goal_met():
		game_over()

	left_label.text = str(left_score)
	right_label.text = str(right_score)
