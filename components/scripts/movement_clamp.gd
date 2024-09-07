class_name MovementClamp extends ComponentNode

func _process(_delta:float) -> void:
	var screen_length = get_viewport().get_visible_rect().size.y
	parent.position.y = clampf(parent.position.y, 0, screen_length)
