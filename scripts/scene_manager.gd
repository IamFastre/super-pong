extends Node

enum Scene {
	MainMenu,
	ClassicGame,
	# SuperPong,
}

const MAIN_MENU:PackedScene    = preload("res://scenes/levels/main_menu.tscn")
const CLASSIC_GAME:PackedScene = preload("res://scenes/levels/classic_game.tscn")

var current:Node

func switch(scene:Scene) -> void:
	call_deferred("_deferred_switch", scene)

#=====================================================================#

func _deferred_switch(scene:Scene) -> void:
	if current:
		current.free()

	var s:PackedScene

	match scene:
		Scene.MainMenu:    s = MAIN_MENU
		Scene.ClassicGame: s = CLASSIC_GAME
		_: assert(false, "Unknown scene id")

	current = s.instantiate()

	get_tree().root.add_child(current)
	get_tree().current_scene = current

#=====================================================================#

func _ready() -> void:
	var root = get_tree().root
	current = root.get_child(root.get_child_count() - 1)
