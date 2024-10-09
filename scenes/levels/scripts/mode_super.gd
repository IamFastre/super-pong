class_name SuperModeOptions extends Control

@export var packed_scene:PackedScene
@export var score_goal:SpinBox
@export_group("Left", "left_")
@export var left_info_options:OptionButton
@export var left_paddle_options:OptionButton
@export_group("Right", "right_")
@export var right_paddle_options:OptionButton
@export var right_info_options:OptionButton

@onready var players_options := (get_parent() as ModeSelector).players_infos
@onready var paddles_options := (get_parent() as ModeSelector).paddles_infos

#=====================================================================#

func add_info_separator(label:String) -> void:
	left_info_options.add_separator(label)
	right_info_options.add_separator(label)

func add_info_item(label:String, icon:Texture2D, idx:int) -> void:
	left_info_options.add_item(label)
	right_info_options.add_item(label)

	left_info_options.set_item_icon(idx, icon)
	right_info_options.set_item_icon(idx, icon)

func get_selected_info(button:OptionButton) -> PlayerInfo:
	var text := button.get_item_text(button.selected)
	return players_options.filter(func(info:PlayerInfo): return info.name == text)[0]

#=====================================================================#

func add_paddle_item(label:String, icon:Texture2D, idx:int) -> void:
	left_paddle_options.add_item(label)
	right_paddle_options.add_item(label)

	left_paddle_options.set_item_icon(idx, icon)
	right_paddle_options.set_item_icon(idx, icon)

func get_selected_paddle(button:OptionButton) -> PaddleInfo:
	var text := button.get_item_text(button.selected)
	return paddles_options.filter(func(info:PaddleInfo): return info.name == text)[0]

#=====================================================================#

func _on_play_pressed() -> void:
	var game := packed_scene.instantiate() as SuperGame
	game.left_info = get_selected_info(left_info_options)
	game.paddle_left_info = get_selected_paddle(left_paddle_options)

	game.right_info = get_selected_info(right_info_options)
	game.paddle_right_info = get_selected_paddle(right_paddle_options)
	game.score_goal = int(score_goal.value)
	SceneManager.switch_to_node(game)

#=====================================================================#

func _ready() -> void:
	var info_options_len := len(players_options)
	var info_seps_len := 0

	for i in range(info_options_len):
		var option := players_options[i]

		# Rule #1 of control flow: don't trust and/or precedence
		if (i == 0 and option.is_human) or (option.is_human and not players_options[i-1].is_human):
			add_info_separator("Human")
			info_seps_len += 1
		elif (i == 0 and not option.is_human) or (not option.is_human and players_options[i-1].is_human):
			add_info_separator("CPU")
			info_seps_len += 1

		add_info_item(option.name, option.icon, i + info_seps_len)

	left_info_options.select(1)
	right_info_options.select(info_options_len + info_seps_len - 1)

	#=================================================================#

	var paddle_options_len := len(paddles_options)

	for i in range(paddle_options_len):
		var option := paddles_options[i]
		add_paddle_item(option.name, option.icon, i)

	left_paddle_options.select(0)
	right_paddle_options.select(0)
