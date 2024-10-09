extends Node

var version:String = ProjectSettings.get_setting("application/config/version")

func is_fullscreen():
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

func toggle_fullscreen() -> bool:
	var fs = is_fullscreen()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if fs else DisplayServer.WINDOW_MODE_FULLSCREEN)
	return not fs

func quit() -> void:
	get_tree().quit()
