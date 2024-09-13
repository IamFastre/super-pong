class_name PressEffect extends ComponentNode

func _on_button_down() -> void:
	if parent.text:
		parent.text = "> %s <" % parent.text

func _on_button_up() -> void:
	if parent.text and parent.text.begins_with(">") and parent.text.ends_with("<"):
		parent.text = parent.text.substr(2, parent.text.length() - 4)
