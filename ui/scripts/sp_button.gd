class_name SPButton extends Button

func _on_button_down() -> void:
	if text:
		text = "> %s <" % text

func _on_button_up() -> void:
	if text and text.begins_with(">") and text.ends_with("<"):
		text = text.substr(2, text.length() - 4)
