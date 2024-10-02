class_name ClassicModeOptions extends Control

@export var packed_scene:PackedScene
@export var score_goal:SpinBox
@export var left_info_options:OptionButton
@export var right_info_options:OptionButton

@onready var players_infos := (get_parent() as ModeSelector).players_infos

#=====================================================================#

func add_separator(label:String) -> void:
	left_info_options.add_separator(label)
	right_info_options.add_separator(label)

func add_item(label:String, icon:Texture2D, idx:int) -> void:
	left_info_options.add_item(label)
	right_info_options.add_item(label)

	left_info_options.set_item_icon(idx, icon)
	right_info_options.set_item_icon(idx, icon)

func get_selected(button:OptionButton) -> PlayerInfo:
	var text := button.get_item_text(button.selected)
	return players_infos.filter(func(info:PlayerInfo): return info.name == text)[0]

#=====================================================================#

func _on_play_pressed() -> void:
	var game := packed_scene.instantiate() as ClassicGame
	game.left_info = get_selected(left_info_options)
	game.right_info = get_selected(right_info_options)
	game.score_goal = int(score_goal.value)
	SceneManager.switch_to_node(game)

#=====================================================================#

func _ready() -> void:
	var options_len := len(players_infos)
	var seps_len := 0
	for i in range(options_len):
		var option := players_infos[i]

		# Rule #1 of control flow: don't trust and/or precedence
		if (i == 0 and option.is_human) or (option.is_human and not players_infos[i-1].is_human):
			add_separator("Human")
			seps_len += 1
		elif (i == 0 and not option.is_human) or (not option.is_human and players_infos[i-1].is_human):
			add_separator("CPU")
			seps_len += 1

		add_item(option.name, option.icon, i + seps_len)

	left_info_options.select(1)
	right_info_options.select(options_len + seps_len - 1)
