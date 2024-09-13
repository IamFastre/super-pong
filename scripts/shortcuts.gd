extends Node

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("quit_app"):
		Game.quit()

	elif event.is_action_pressed("toggle_full_screen"):
		Game.toggle_fullscreen()
