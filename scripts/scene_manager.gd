extends Node

enum Scene {
	MainMenu,
	ModeSelector,
	ClassicGame,
	# SuperPong,
}

const MAIN_MENU:PackedScene     = preload("res://scenes/levels/main_menu.tscn")
const MODE_SELECTOR:PackedScene = preload("res://scenes/levels/mode_selector.tscn")
const CLASSIC_GAME:PackedScene  = preload("res://scenes/levels/classic_game.tscn")

var current:Node
var history:Array[Scene] = []

func switch(scene:Scene) -> void:
	var s:PackedScene

	match scene:
		Scene.MainMenu:     s = MAIN_MENU
		Scene.ModeSelector: s = MODE_SELECTOR
		Scene.ClassicGame:  s = CLASSIC_GAME
		_: assert(false, "Unknown scene id")

	call_deferred("_deferred_switch_to_node", s.instantiate())
	history.append(scene)

func switch_to_node(scene:Node) -> void:
	call_deferred("_deferred_switch_to_node", scene)

func back() -> void:
	var prev = history.pop_at(-2)

	if prev != null:
		switch(prev)
	else:
		switch(Scene.MainMenu)

#=====================================================================#

func _deferred_switch_to_node(scene:Node) -> void:
	if current:
		current.free()
	current = scene

	get_tree().root.add_child(current)
	get_tree().current_scene = current

#=====================================================================#

func _ready() -> void:
	var root = get_tree().root
	current = root.get_child(root.get_child_count() - 1)
	history.append(Scene.MainMenu)
