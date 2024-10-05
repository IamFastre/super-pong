class_name MovementClamp extends Component

@export var shape:CollisionShape2D

var height:float :
	get: return shape.shape.get_rect().size.y

#=====================================================================#

func _ready():
	process_priority = 2

func _process(_delta:float) -> void:
	parent.position.y = clampf(parent.position.y, height / 2, Utilities.screensize.y - height / 2)
