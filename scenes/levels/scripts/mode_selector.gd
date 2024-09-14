extends Node

@export_group("Classic", "classic_")
@export var classic_packed_scene:PackedScene
@export var classic_players_infos:Array[PlayerInfo] = []
@export var classic_left_options: OptionButton
@export var classic_right_options: OptionButton

@onready var players_options := classic_players_infos

#=====================================================================#

func add_separator(label:String) -> void:
	classic_left_options.add_separator(label)
	classic_right_options.add_separator(label)

func add_item(label:String) -> void:
	classic_left_options.add_item(label)
	classic_right_options.add_item(label)

func get_selected(button:OptionButton) -> PlayerInfo:
	var text := button.get_item_text(button.selected)
	return players_options.filter(func(info:PlayerInfo): return info.name == text)[0]

#=====================================================================#

func _on_back_pressed() -> void:
	SceneManager.back()

func _on_play_pressed() -> void:
	var game := classic_packed_scene.instantiate() as ClassicGame
	game.left_info = get_selected(classic_left_options)
	game.right_info = get_selected(classic_right_options)
	SceneManager.switch_to_node(game)

#=====================================================================#

func _ready() -> void:
	var options_len := len(players_options)
	for i in range(options_len):
		var option := players_options[i]

		# Rule #1 of control flow: don't trust and/or precedence
		if (i == 0 and option.is_human) or (option.is_human and not players_options[i-1].is_human):
			add_separator("Human")
			options_len += 1
		elif (i == 0 and not option.is_human) or (not option.is_human and players_options[i-1].is_human):
			add_separator("CPU")
			options_len += 1
		add_item(option.name)

	classic_left_options.select(1)
	classic_right_options.select(options_len - 1)
