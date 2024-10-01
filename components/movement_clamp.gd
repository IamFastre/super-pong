class_name MovementClamp extends Component

func _ready():
	process_priority = 2

func _process(_delta:float) -> void:
	parent.position.y = clampf(parent.position.y, 0, Utilities.screensize.y)
