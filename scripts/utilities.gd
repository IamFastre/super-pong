extends Node

@onready var screensize:Vector2 = get_viewport().content_scale_size
@onready var center:Vector2 = screensize / 2
@onready var system:System = get_system()
@onready var has_touch_screen:bool = DisplayServer.is_touchscreen_available()

#=====================================================================#

enum System {
	GOD_KNOWS,
	WINDOWS,
	POSIX,
	OSX,
	IOS,
	ANDROID,
	WEB,
}

#=====================================================================#

func get_system() -> System:
	match OS.get_name():
		"Windows":
			return System.WINDOWS
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			return System.POSIX
		"macOS":
			return System.OSX
		"iOS":
			return System.IOS
		"Android":
			return System.ANDROID
		"Web":
			return System.WEB
		_: # Unknown
			OS.crash("I'm racist against this specific OS")
			return System.GOD_KNOWS

#=====================================================================#

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("quit_app"):
		Game.quit()

	elif event.is_action_pressed("toggle_full_screen"):
		Game.toggle_fullscreen()
