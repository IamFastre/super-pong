extends Node

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("quit_app"):
		get_tree().quit()

	if event.is_action_pressed("toggle_full_screen"):
		var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if is_fullscreen else DisplayServer.WINDOW_MODE_FULLSCREEN)
