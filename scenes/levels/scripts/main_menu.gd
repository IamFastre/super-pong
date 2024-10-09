extends Node

@export var version_label:Label

@export_group("Expand Button", "expand_")
@export var expand_button:Button
@export var expand_icon_on:Texture2D = preload("res://ui/assets/fullscreen.png")
@export var expand_icon_off:Texture2D = preload("res://ui/assets/windowed.png")

func _on_expand_pressed() -> void:
	if Game.toggle_fullscreen():
		expand_button.icon = expand_icon_off
	else:
		expand_button.icon = expand_icon_on

func _on_start_pressed() -> void:
	SceneManager.switch(SceneManager.Scene.ModeSelector)

func _on_quit_pressed() -> void:
	Game.quit()

#=====================================================================#

func _ready() -> void:
	version_label.text = "indev-" + Game.version

func _process(_delta:float) -> void:
	if Game.is_fullscreen():
		expand_button.icon = expand_icon_off
	else:
		expand_button.icon = expand_icon_on