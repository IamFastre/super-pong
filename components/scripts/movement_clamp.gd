class_name MovementClamp extends ComponentNode

func _ready():
	process_priority = 2

func _process(_delta:float) -> void:
	parent.position.y = clampf(parent.position.y, 0, Constants.screensize.y)
