class_name ModeSelector extends Control

@export var players_infos:Array[PlayerInfo] = [
	preload("res://resources/player_info/human_p1.tres"),
	preload("res://resources/player_info/human_p2.tres"),
	preload("res://resources/player_info/cpu_easy.tres"),
	preload("res://resources/player_info/cpu_medium.tres"),
	preload("res://resources/player_info/cpu_hard.tres"),
]

@export var paddles_infos:Array[PaddleInfo] = [
	preload("res://resources/paddle_info/classic.tres"),
	preload("res://resources/paddle_info/castle.tres"),
	preload("res://resources/paddle_info/speedy.tres"),
	preload("res://resources/paddle_info/strike.tres"),
	preload("res://resources/paddle_info/tempo.tres"),
]

#=====================================================================#

func on_back_pressed() -> void:
	SceneManager.back()
