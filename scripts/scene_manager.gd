extends Node

enum Scene {
	MainMenu,
	ClassicGame,
	# SuperPong,
}

const MAIN_MENU:PackedScene = preload("res://scenes/levels/main_menu.tscn")
const CLASSIC_GAME:PackedScene = preload("res://scenes/levels/classic_game.tscn")

var current:Node

func switch(scene:Scene) -> void:
	call_deferred("_undeferred_switch", scene)

#=====================================================================#

func _undeferred_switch(scene:Scene) -> void:
	if current:
		current.free()

	var new_scene:Node
	match scene:
		Scene.MainMenu:
			new_scene = MAIN_MENU.instantiate()
		Scene.ClassicGame:
			new_scene = CLASSIC_GAME.instantiate()
		_:
			assert(false, "Unknown scene id")

	current = new_scene
	get_tree().root.add_child(current)
	get_tree().current_scene = current
	print(get_tree().current_scene)

#=====================================================================#

func _ready() -> void:
	var root = get_tree().root
	current = root.get_child(root.get_child_count() - 1)
