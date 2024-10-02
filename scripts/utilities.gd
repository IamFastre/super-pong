extends Node

@onready var screensize:Vector2 = get_viewport().content_scale_size
@onready var center:Vector2 = screensize / 2
@onready var has_touch_screen:bool = DisplayServer.is_touchscreen_available()

#=====================================================================#

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("quit_app"):
		Game.quit()

	elif event.is_action_pressed("toggle_full_screen"):
		Game.toggle_fullscreen()
